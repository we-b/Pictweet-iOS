//
//  User.swift
//  Pictweet-iOS
//
//  Created by 松下慶大 on 2015/09/07.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit
import Parse

class User: NSObject {
    var name: String!
    var password: String!
    
    init(name: String, password: String) {
        self.name     = name
        self.password = password
    }
    
    func signUp(callback: (message: String?) -> Void) {
        let user = PFUser()
        user.username = name
        user.password = password
        user.signUpInBackgroundWithBlock { (success, error) -> Void in
            if error == nil {
                callback(message: nil)
            } else {
                callback(message: error?.userInfo?["error"] as? String)
            }
        }
    }
    
    func login(callback: (message: String?) -> Void) {
        PFUser.logInWithUsernameInBackground(self.name, password: self.password) { (user, error) -> Void in
            if error == nil {
                callback(message: nil)
            } else {
                callback(message: error?.userInfo?["error"] as? String)
            }
        }
    }
}
