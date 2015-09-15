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

    let tweetManager = TweetManager.sharedInstanse
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.roundCorner()
        signUpButton.roundCorner()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //login
    @IBAction func tapLoginButton(sender: UIButton) {
        if nameTextField.text.isEmpty || passwordTextField.text.isEmpty {
            showAlert("User name or password is empty")
            return
        }
        let user = User(name: nameTextField.text, password: passwordTextField.text)
        user.login { (message) in
            if message == nil {
                self.tweetManager.emptyTweets()
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                self.showAlert(message)
            }
        }
    }
    
    //sign up
    @IBAction func tapSignUpButton(sender: UIButton) {
        if nameTextField.text.isEmpty || passwordTextField.text.isEmpty {
            showAlert("User name or password is empty")
            return
        }
        let user = User(name: nameTextField.text, password: passwordTextField.text)
        user.signUp { (message) in
            if message == nil {
                self.tweetManager.emptyTweets()
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                self.showAlert(message)
            }
        }
    }
    
    //alert
    func showAlert(message: String?) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

}
