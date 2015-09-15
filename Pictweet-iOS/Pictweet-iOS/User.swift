//
//  User.swift
//  Pictweet-iOS
//
//  Created by 松下慶大 on 2015/09/07.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit
import Parse

@objc protocol UserDelegate {
    func didFinishUpdateUser()
}

class User: NSObject {
    
    var name: String
    var password: String?
    var image: UIImage?
    weak var delegate: UserDelegate?
    
    convenience init(attribute: PFUser) {
        let name      = attribute.username
        let imageFile = attribute["image"] as! PFFile
        self.init(name: name!, image: nil)
        fetchUserImage(imageFile)
    }

    init(name: String, image: UIImage?) {
        self.name = name
        self.image = image
    }
    
    //ログイン時のみ使用
    init(name: String, password: String) {
        self.name     = name
        self.password = password
    }
    
    func signUp(callback: (message: String?) -> Void) {
        let user = PFUser()
        user.username = name
        user.password = password
        user["image"] = UIImage(named: "noimage")?.convertToPFFile()
        user.signUpInBackgroundWithBlock { (success, error) -> Void in
            if error == nil {
                callback(message: nil)
            } else {
                callback(message: error?.userInfo?["error"] as? String)
            }
        }
    }
    
    func login(callback: (message: String?) -> Void) {
        PFUser.logInWithUsernameInBackground(self.name, password: self.password!) { (user, error) -> Void in
            if error == nil {
                callback(message: nil)
            } else {
                callback(message: error?.userInfo?["error"] as? String)
            }
        }
    }
    
    func update(callback: () -> Void) {
        let currentUser = PFUser.currentUser()
        currentUser?.username = name
        currentUser?["image"] = image?.convertToPFFile()
        currentUser?.saveInBackgroundWithBlock({ (success, error) -> Void in
            if success {
                println("update!")
                callback()
            }
        })
    }
    
    func fetchUserImage(imageFile: PFFile) {
        imageFile.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
            if error == nil {
                self.image = UIImage(data: imageData!)
                self.delegate?.didFinishUpdateUser()
            }
        })
    }
}
