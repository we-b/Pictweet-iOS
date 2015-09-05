//
//  TweetManager.swift
//  Pictweet-iOS
//
//  Created by 松下慶大 on 2015/08/30.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class TweetManager: NSObject {
    static let sharedInstanse = TweetManager()
    var tweets: Array<Tweet> = []
}
