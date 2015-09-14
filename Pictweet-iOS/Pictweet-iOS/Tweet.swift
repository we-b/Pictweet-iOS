//
//  Tweet.swift
//  Pictweet-iOS
//
//  Created by 松下慶大 on 2015/08/30.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit
import Parse

@objc protocol TweetDelegate {
    func didFinishFetchingTweets()
}

class Tweet: NSObject {
    
    var text: String
    var image: UIImage?
    var user: User?
    weak var delegate: TweetDelegate?

    convenience init(attribute: PFObject) {
        let text      = attribute["text"] as! String
        let imageFile = attribute["image"] as! PFFile
        self.init(text: text, image: nil)
        fetchTweetedUser(attribute)
        fetchTweetImage(imageFile)
    }
    
    init(text: String, image: UIImage?) {
        self.text  = text
        self.image = image
    }
    
    func saveTweet(callback: () -> Void ) {
        let tweetsObject = PFObject(className: "tweets")
        tweetsObject["text"] = text
        tweetsObject["image"] = image!.convertToPFFile()
        tweetsObject["user_id"] = PFUser.currentUser()?.objectId
        let relation = tweetsObject.relationForKey("user") //PFRelation
        relation.addObject(PFUser.currentUser()!)
        
        tweetsObject.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                println("Tweet has been saved")
                callback()
            }
        }
    }
    
    func fetchTweetedUser(tweetObject: PFObject) {
        let relation = tweetObject.relationForKey("user")
        relation.query()?.getFirstObjectInBackgroundWithBlock({ (object, error) -> Void in
            if error == nil {
                let userObject = object as! PFUser
                let user = User(name: userObject.username!)
                self.user = user
                self.delegate?.didFinishFetchingTweets()
            }
        })
    }
    
    func fetchTweetImage(imageFile: PFFile) {
        imageFile.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
            if error == nil {
                self.image = UIImage(data: imageData!)
                self.delegate?.didFinishFetchingTweets()
            }
        })
    }
}
