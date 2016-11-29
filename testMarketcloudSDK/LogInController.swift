import Foundation
import Marketcloud
import SwiftyJSON

class LogInController: UIViewController, UITextFieldDelegate {
    
    let marketcloud:Marketcloud = MarketcloudMain.getMarketcloud()
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    //when the user taps the keyboard's return button, the keyboard must hide itself
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    
    @IBAction func logInButton(_ sender: UIButton) {
        
        print("Log In Button pressed!!")
        
        //let's collect the datas...
        
        
        let data:[String:String] = ["email":self.emailField.text!, "password":self.passwordField.text!]
        
        let loginResult:JSON = JSON(marketcloud.logIn(data))
        
        //i'm going to print the result, for debugging purposes
        print(loginResult)
        
        //Let's check if everything was fine...
        
        guard loginResult["Error"] == JSON.null else {
            //we're not going to manage any errors in this tutorial...
            print("There was an error")
            return
        }
        
        /*
         when an user does a successful login, an user token is stored into the SDK.
         You can retrieve it (just for debug) with the marketcloud.getToken() method.
         Let's try it:
         */
        
        let userToken = marketcloud.getToken()
        let text = "Logged In! \n Token is \(userToken)"
        
        //if there is no cart for this user, we will create a new one.
        let cart:JSON = JSON(self.marketcloud.getCart())
        print(cart)
        if(cart["errors"] != JSON.null) {
            print("let's create a new cart")
            marketcloud.createEmptyCart()
        }
        
        //save the email for further use
        MarketcloudMain.userEmail = self.emailField.text!
        
        //we're done here! Let's show an alert
        
        let alertController = UIAlertController(title: "Ok!", message: text, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title:"Close",style:UIAlertActionStyle.default, handler:someHandler))
        
        self.present(alertController, animated:true, completion: nil)
    }
    
    func someHandler(alert: UIAlertAction!) {
        self.performSegue(withIdentifier: "segueToProductsList", sender: nil)
    }
}
