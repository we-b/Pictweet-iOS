//
//  TweetManager.swift
//  Pictweet-iOS
//
//  Created by 松下慶大 on 2015/08/30.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit
import Parse

@objc protocol TweetManagerDelegate {
    func didFinishedFetchTweets()
}

class TweetManager: NSObject {
    static let sharedInstanse = TweetManager()
    var tweets = [Tweet]()
    weak var delegate: TweetManagerDelegate?
    
    func fetchTweets() {
        let query = PFQuery(className: "tweets")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                self.tweets = []
                let tweets = objects as! [PFObject]
                for tweetObject in tweets {
                    let text      = tweetObject["text"] as! String
                    let imageFile = tweetObject["image"] as! PFFile
                    let tweet = Tweet(text: text, image: nil)
                    self.tweets.append(tweet)
                    
                    //tweetしたuserを取得
                    let relation = tweetObject.relationForKey("user")
                    relation.query()?.getFirstObjectInBackgroundWithBlock({ (object, error) -> Void in
                        if error == nil {
                            let userObject = object as! PFUser
                            let user = User(name: userObject.username!)
                            tweet.user = user
                            self.delegate?.didFinishedFetchTweets()
                        }
                    })
                
                    //tweetの画像データを取得
                    imageFile.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
                        if error == nil {
                            tweet.image = UIImage(data: imageData!)
                            self.delegate?.didFinishedFetchTweets()
                        }
                    })
                }
            }
        }
    }
}
