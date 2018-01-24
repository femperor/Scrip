//
//  UIFont+Scrip.swift
//  Scrip
//
//  Created by fire on 16/01/2018.
//  Copyright © 2018 ZZStudio. All rights reserved.
//

import UIKit

extension UIFont {
    static var title: UIFont {
        guard let font = UIFont(name: "CircularPro-Bold", size: 40.0) else {
            return UIFont.preferredFont(forTextStyle: .headline)
        }
        return font
    }
    
    static func customMedium(size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "CircularPro-Medium", size: size) else { return UIFont.preferredFont(forTextStyle: .body) }
        return font
    }
}
