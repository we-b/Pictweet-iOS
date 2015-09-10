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
    func tweetManagerDidFinishedFetch()
}

class TweetManager: NSObject {
    
    static let sharedInstanse = TweetManager()
    var tweets = [Tweet]()
    var currentUserTweets = [Tweet]()
    weak var delegate: TweetManagerDelegate?
    
    func fetchTweets() {
        let query = PFQuery(className: "tweets")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                self.tweets = []
                let tweets = objects as! [PFObject]
                for tweetObject in tweets {
                    let tweet = Tweet(attribute: tweetObject)
                    self.tweets.append(tweet)
                    self.delegate?.tweetManagerDidFinishedFetch()
                }
            }
        }
    }
    
    func fetchCurrentUserTweets() {
        let query = PFQuery(className: "tweets")
        query.orderByDescending("createdAt")
        query.whereKey("user_id", containsString: PFUser.currentUser()?.objectId)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                self.currentUserTweets = []
                let tweets = objects as! [PFObject]
                for tweetObject in tweets {
                    let tweet = Tweet(attribute: tweetObject)
                    self.currentUserTweets.append(tweet)
                    self.delegate?.tweetManagerDidFinishedFetch()
                }
            }
        }
    }
    
    func tweetsMakeEmpty() {
        tweets = []
        currentUserTweets = []
    }
}

