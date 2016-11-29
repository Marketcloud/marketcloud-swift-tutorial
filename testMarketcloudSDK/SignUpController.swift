//
//  SignUpController.swift
//  testMarketcloudSDK
//
//  Created by Mirco Lacalandra on 07/11/2016.
//  Copyright © 2016 Mirco Lacalandra. All rights reserved.
//

import Foundation
import Marketcloud
import SwiftyJSON

class SignUpController: UIViewController, UITextFieldDelegate {
    
    let marketcloud:Marketcloud = MarketcloudMain.getMarketcloud()
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    //when the user has completed filling a field, the keyboard must hide itself!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    
    @IBAction func confirmButton(_ sender: UIButton) {
        
        print("Confirm button pressed!!")
        
        //Let's collect the datas from the textFields
        let data:[String:String] = ["email":self.emailField.text!, "password":self.passwordField.text!, "name":self.nameField.text!]
        
        //in this tutorial we're not going to validate the fields.. but i really suggest you to do that!
        let newUser:JSON = JSON(marketcloud.createUser(data))
        
        //let's print the result, for debugging purpose...
        print(newUser)
        
        //let's check if everything went fine...
        
        guard newUser["status"] == true else {
            //something went wrong...
            //we're not going to cover errors in this tutorial!
            print("There was an error...")
            return
        }
        
        //we're done here! Let's create an alert to inform the user!
        
        let alertController = UIAlertController(title: "Ok!", message: "User registered!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title:"Close", style:UIAlertActionStyle.default, handler:nil))
        
        self.present(alertController, animated:true, completion:nil)
    
    }
    
}
