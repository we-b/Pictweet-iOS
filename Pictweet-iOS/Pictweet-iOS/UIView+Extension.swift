//
//  UIView+Extension.swift
//  Pictweet-iOS
//
//  Created by 松下慶大 on 2015/09/16.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func makeCircle() {
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
    }
    
    func roundCorner() {
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }

    func drawBorderByMainColor() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.mainColor().CGColor
    }
    
    func drawBorderByWhiteColor() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.whiteColor().CGColor
    }
    
}
