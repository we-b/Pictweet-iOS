//
//  ProfileTableViewCell.swift
//  Pictweet-iOS
//
//  Created by 松下慶大 on 2015/09/09.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import UIKit
import CoreImage

@objc protocol ProfileTableViewCellDelegate {
    func tappedEditButton()
}

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    weak var delegate: ProfileTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.makeCircle()
        editButton.roundCorner()
        editButton.drawBorderByWhiteColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapEditButton(sender: UIButton) {
        delegate?.tappedEditButton()
    }
}
