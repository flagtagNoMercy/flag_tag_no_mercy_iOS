//
//  RegistrationViewController.swift
//  Flag Tag
//
//  Created by Bobby Towers on 3/7/15.
//  Copyright (c) 2015 Ebony Nyenya. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var registrationEmailField: UITextField!
    @IBOutlet weak var registrationPasswordField: UITextField!
    
    var registrationEmail = NSString()
    var registrationPassword = NSString()
    
    @IBAction func registerButton(sender: AnyObject) {
        
        registrationEmail = registrationEmailField.text
        registrationPassword = registrationPasswordField.text
        
        if registrationEmail.length > 0 && registrationPassword.length > 0 {
            
            UserSingleton.userData().register(registrationEmail, password: registrationPassword)
            
            // if error is sent back, pop UI alert
            
            // perform segue only if success
//            self.performSegueWithIdentifier("unwindToLogin", sender: self)
            
        } else {
            
            // Alert controller 
            let message = "Empty fields detected. Please fill in all fields."
            let alert = UIAlertController(title: "Invalid login", message: message, preferredStyle: .Alert)
            let action = UIAlertAction(title: "Go back", style: .Default, handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        registrationEmailField.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        registrationEmailField.becomeFirstResponder()
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
