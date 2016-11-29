import Foundation
import Marketcloud
import SwiftyJSON

class CheckoutController:UITableViewController, UITextFieldDelegate {
    
    let marketcloud:Marketcloud = MarketcloudMain.getMarketcloud()
    
    //@IBOutlets
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var postalCode: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    
    @IBAction func nextButton(_ sender: UIButton) {
        
        //first thing: address creation!
        print("Processing address creation....")
        let testAddress:[String:String] = ["email": MarketcloudMain.userEmail!, "full_name":fullName.text!, "country":country.text!, "state":state.text!, "city":city.text!, "address1":address.text!, "postal_code":postalCode.text!]
        
        let shippingAddress:JSON = JSON(marketcloud.createAddress(testAddress))
        
        guard shippingAddress["status"].int == 1 else {
            print(shippingAddress["Error"])
            return
        }
        
        let shippingAddressID:Int = shippingAddress["data"]["id"].int!
        
        print("Address created with id \(shippingAddressID)")
        print("processing order creation...")
        
        //we need to retrieve the cart because we didn't store it 
        let cart:JSON = JSON(marketcloud.getCart()["data"])
        
        //second thing: order creation!
        let order:JSON = JSON(marketcloud.createOrder(shippingAddressID, billingId: shippingAddressID, cartId: cart["id"].int!))
        
        guard order["status"].bool == true else {
            print("Error in creating order")
            print(order)
            return
        }
        
        let orderId:Int = order["data"]["id"].int!
        
        //let's show an alert. when the alert is closed we will return to the cart view
        let alertController = UIAlertController(title:"OK!", message: "Done! order Id is \(orderId)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title:"Close", style: UIAlertActionStyle.default, handler : {
            action in self.navigationController?.popViewController(animated:true)
        }))
        self.present(alertController, animated:true, completion:nil)
    }
}
