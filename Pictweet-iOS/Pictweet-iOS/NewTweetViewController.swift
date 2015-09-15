//
//  NewTweetViewController.swift
//  Pictweet-iOS
//
//  Created by 松下慶大 on 2015/08/31.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit
import Parse

class NewTweetViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UserDelegate {
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var imageSelectButton: UIButton!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileIconImageView: UIImageView!
    
    //イメージピッカー(カメララロール)
    let imagePicker = UIImagePickerController()
    var currentUser: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = User(attribute: PFUser.currentUser()!)
        currentUser.delegate = self
        nameLabel.text = currentUser.name
        imageSelectButton.roundCorner()
        tweetImageView.setContentMode()
        profileIconImageView.makeCircle()
        profileIconImageView.setContentMode()
        let gesture = UITapGestureRecognizer(target: self, action: "tapView:")
        view.addGestureRecognizer(gesture)
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "＜", style: .Plain, target: self, action: "backToTweetsViewController")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "TWEET", style: .Plain, target: self, action: "saveTweet")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK - delegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        tweetImageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tapView(sender: UITapGestureRecognizer) {
        tweetTextView.resignFirstResponder()
    }
    
    func didFinishUpdateUser() {
        profileIconImageView.image = currentUser.image
    }
    
    // MARK - action
    
    @IBAction func tapImageSelectButton(sender: UIButton) {
        self.imagePicker.sourceType = .PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func saveTweet() {
        let text = tweetTextView.text
        let image = tweetImageView.image
        if text.isEmpty || image == nil {
            return
        }
        let tweet = Tweet(text: text, image: image!)
        let callback = { () in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        tweet.saveTweet(callback)
    }
    
    func backToTweetsViewController() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
