//
//  ViewController.swift
//  Flag Tag
//
//  Created by Ebony Nyenya and Bobby Towers on 3/6/15.
//  Copyright (c) 2015 Ebony Nyenya and Bobby Towers. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var loginEmailField: UITextField!
    @IBOutlet weak var loginPasswordField: UITextField!
    
    var loginEmail = NSString()
    var loginPassword = NSString()
    
    @IBAction func loginButton(sender: AnyObject) {
        
        loginEmail = loginEmailField.text
        loginPassword = loginPasswordField.text
        
        if loginEmail.length > 0 && loginPassword.length > 0 {
            
            UserSingleton.userData().login(loginEmail, password: loginPassword)
            
            // if error is sent back, pop UI alert
            
        } else {
            
            // Alert controller
            let message = "Empty fields detected. Please fill in all fields."
            let alert = UIAlertController(title: "Invalid login", message: message, preferredStyle: .Alert)
            let action = UIAlertAction(title: "Go back", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
            
        }

        
    }
    
    @IBAction func cancelToLogin(segue: UIStoryboardSegue) {
    }

    @IBAction func goToRegistrationButton(sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginEmailField.delegate = self
        loginPasswordField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

