//
//  SigninViewController.swift
//  SnapChat
//
//  Created by Daniel Moi on 26/12/17.
//  Copyright © 2017 Daniel Moi. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func goAction(_ sender: Any) {
        print("HELLO")
    }
    

}

