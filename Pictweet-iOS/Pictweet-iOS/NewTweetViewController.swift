//
//  NewTweetViewController.swift
//  Pictweet-iOS
//
//  Created by 松下慶大 on 2015/08/31.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var imageSelectButton: UIButton!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileIconLabel: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        imageSelectButton.layer.cornerRadius = 5
        profileIconLabel.makeCircle()
        
        let gesture = UITapGestureRecognizer(target: self, action: "tapView:")
        view.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "＜", style: UIBarButtonItemStyle.Plain, target: self, action: "backToTweetsViewController")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func backToTweetsViewController() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func tapImageSelectButton(sender: UIButton) {
        //カメラロールアクセスを記述
    }
    
    func tapView(sender: UITapGestureRecognizer) {
        tweetTextView.resignFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}










