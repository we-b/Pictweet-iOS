//
//  MyPageTableViewController.swift
//  Pictweet-iOS
//
//  Created by 松下慶大 on 2015/09/09.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit
import Parse

class MyPageTableViewController: UITableViewController, TweetDelegate, TweetManagerDelegate, ProfileTableViewCellDelegate, UserDelegate {

    let tweetManager = TweetManager.sharedInstanse
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        tableView.registerNib(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetTableViewCell")
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableViewAutomaticDimension
        tweetManager.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tweetManager.fetchCurrentUserTweets()
        currentUser = User(attribute: PFUser.currentUser()!)
        currentUser.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return tweetManager.currentUserTweets.count
        }
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("ProfileTableViewCell", forIndexPath: indexPath) as! ProfileTableViewCell
            cell.delegate = self
            cell.nameLabel.text         = currentUser.name
            cell.profileImageView.image = currentUser.image
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
            let tweet = tweetManager.currentUserTweets[indexPath.row]
            tweet.delegate = self
            cell.tweetImageView.image = tweet.image
            cell.tweetLabel.text      = tweet.text
            cell.nameLabel.text       = currentUser.name
            cell.profileIconImageView.image = currentUser.image
            return cell
        }
    }
    
    // MARK - delegate
    
    func didFinishFetchingTweets() {
        tableView.reloadData()
    }
    
    func didFinishFetchingTweetsBy(tweetManager: TweetManager) {
        tableView.reloadData()
    }
    
    func didFinishUpdateUser() {
        println("Update!!!!!!!")
        tableView.reloadData()
    }
    
    //MARK - action
    
    func tappedEditButton() {
        performSegueWithIdentifier("presentEditProfileViewController", sender: nil)
    }

    
}
