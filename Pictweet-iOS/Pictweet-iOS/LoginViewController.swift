//
//  LoginViewController.swift
//  Pictweet-iOS
//
//  Created by 松下慶大 on 2015/09/07.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 5
        signUpButton.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapLoginButton(sender: UIButton) {
        if nameTextField.text.isEmpty || passwordTextField.text.isEmpty {
            showAlert("User name or password is empty")
            return
        }
        let user = User(name: nameTextField.text, password: passwordTextField.text)
        user.login { (message) -> Void in
            if message == nil {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                self.showAlert(message)
            }
        }
    }
    
    @IBAction func tapSignUpButton(sender: UIButton) {
        if nameTextField.text.isEmpty || passwordTextField.text.isEmpty {
            showAlert("User name or password is empty")
            return
        }
        let user = User(name: nameTextField.text, password: passwordTextField.text)
        user.signUp { (message) -> Void in
            if message == nil {
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                self.showAlert(message)
            }
        }
    }
    
    func showAlert(message: String?) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

}
