//
//  TweetTableViewCell.swift
//  Pictweet-iOS
//
//  Created by 松下慶大 on 2015/08/30.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileIconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileIconImageView.makeCircle()
        profileIconImageView.setContentMode()
        tweetImageView.setContentMode()
     
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
