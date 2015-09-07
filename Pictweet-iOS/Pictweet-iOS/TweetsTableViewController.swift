//
//  TweetsTableViewController.swift
//  Pictweet-iOS
//
//  Created by 松下慶大 on 2015/08/30.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class TweetsTableViewController: UITableViewController, TweetManagerDelegate {

    let tweetManager = TweetManager.sharedInstanse
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetTableViewCell")
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableViewAutomaticDimension
        tweetManager.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "NEW", style: UIBarButtonItemStyle.Plain, target: self, action: "modalNewTweetTableViewController")
        tweetManager.fetchTweets()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetManager.tweets.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
        let tweet = tweetManager.tweets[indexPath.row]
        cell.tweetLabel.text      = tweet.text
        cell.tweetImageView.image = tweet.image
        return cell
    }

    func modalNewTweetTableViewController() {
        performSegueWithIdentifier("modalNewTweetTableViewController", sender: self)
    }

    func didFinishedFetchTweets() {
        println("finished fetch tweets")
        tableView.reloadData()
    }
}
