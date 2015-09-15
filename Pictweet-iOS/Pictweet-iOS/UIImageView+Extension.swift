//
//  UIImageView+Extension.swift
//  Pictweet-iOS
//
//  Created by 松下慶大 on 2015/08/31.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setContentMode() {
        contentMode = UIViewContentMode.ScaleAspectFill
        layer.masksToBounds = true
    }

}
