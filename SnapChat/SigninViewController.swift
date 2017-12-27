//
//  SigninViewController.swift
//  SnapChat
//
//  Created by Daniel Moi on 26/12/17.
//  Copyright © 2017 Daniel Moi. All rights reserved.
//

import UIKit
import FirebaseAuth

class SigninViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func goAction(_ sender: Any) {
        let email = emailTextField.text
        let password = passwordTextField.text
        Auth.auth().signIn(withEmail: email!, password: password!, completion: { (user, error) in
            print("We tried to sign in!")
            if (error != nil) {
                print("Hey we have an error: \(error!)")
                
                Auth.auth().createUser(withEmail: email!, password: password!, completion: { (user, error) in
                    if (error != nil) {
                        print("Hey we have an error: \(error!)")
                    } else {
                        print("Created user successfully!")
                        self.performSegue(withIdentifier: "signinSegue", sender: nil)
                    }
                })
            } else {
                print("Signed in successfully")
                self.performSegue(withIdentifier: "signinSegue", sender: nil)
            }
        })
    }
    

}

