//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //just to save time
        emailTextfield.text = K.User.username
        passwordTextfield.text = K.User.password
    }
    @IBAction func loginPressred(_ sender: UIButton!) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
             Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        print(e)
                    }else{
                        //navigate to chat controller
                        print("successful log in")
                        self.performSegue(withIdentifier: K.loginSegue, sender: self)
                    }
                }
                
            }
    }
}
