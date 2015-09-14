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
                for tweet in tweets {
                    let text      = tweet["text"] as! String
                    let imageFile = tweet["image"] as! PFFile
                    let tweet = Tweet(text: text, image: nil)
                    self.tweets.append(tweet)
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
