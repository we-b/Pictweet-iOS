//
//  Tweet.swift
//  Pictweet-iOS
//
//  Created by 松下慶大 on 2015/08/30.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit
import Parse

class Tweet: NSObject {
    var text: String!
    var image: UIImage?
    
    init(text: String, image: UIImage?) {
        self.text = text
        self.image = image
    }
    
    func saveTweet(callback: () -> Void ) {
        let tweetsObject = PFObject(className: "tweets")
        tweetsObject["text"] = text
        tweetsObject["image"] = image!.convertToPFFile()
        tweetsObject.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                println("Tweet has been saved")
                callback()
            }
        }
    }
}
