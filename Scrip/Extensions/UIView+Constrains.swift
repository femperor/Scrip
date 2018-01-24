//
//  UIView+Constrains.swift
//  Scrip
//
//  Created by fire on 16/01/2018.
//  Copyright © 2018 ZZStudio. All rights reserved.
//

import UIKit

extension UIView {
    func constrain(_ constraints: [NSLayoutConstraint?]) {
        guard superview != nil else {
            assert(false, "Superview cannot be nil when adding constraints");
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints.flatMap{ $0 })
    }
}
