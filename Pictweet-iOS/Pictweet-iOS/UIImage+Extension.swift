//
//  UIImage+Extension.swift
//  Pictweet-iOS
//
//  Created by 松下慶大 on 2015/09/05.
//  Copyright (c) 2015年 matsushita keita. All rights reserved.
//

import Foundation
import UIKit
import Parse

extension UIImage {
    
    func convertToPFFile() -> PFFile {
        let imageData = UIImagePNGRepresentation(self)
        let imageFile = PFFile(name: "imageFile.png", data: imageData)
        return imageFile
    }
    
}