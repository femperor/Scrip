//
//  UILabel+Scrip.swift
//  Scrip
//
//  Created by fire on 16/01/2018.
//  Copyright © 2018 ZZStudio. All rights reserved.
//

import UIKit


extension UILabel {
    convenience init(font: UIFont, color: UIColor) {
        self.init()
        self.font = font
        self.textColor = color
    }
}
