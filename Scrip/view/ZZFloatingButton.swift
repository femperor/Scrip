//
//  ZZFloatingButton.swift
//  Scrip
//
//  Created by zhiou on 2019/6/1.
//  Copyright © 2019 ZZStudio. All rights reserved.
//

import UIKit

class ZZFloatingButton: UIButton {
    enum Style {
        case round
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = UIBezierPath()
        path.move(to: CGPoint(x:bounds.origin.x, y:bounds.origin.y + bounds.size.height))
//        path.addLine(to: CGPoint(x:bounds.origin.x + bounds.size.width, y:bounds.origin.y + bounds.size.height))
         path.addArc(withCenter: self.center, radius: 55, startAngle: 0, endAngle: .pi * 2, clockwise: false)
        path.lineWidth = 2.0
        path.lineCapStyle = .round

            UIColor.lightGray.setStroke()
        
        path.stroke()
//        let bezierPath = UIBezierPath()
//        bezierPath.addArc(withCenter: self.center, radius: 22.5, startAngle: 0, endAngle: .pi * 2, clockwise: false)
//        bezierPath.lineWidth = 3.0
//        UIColor.green.setFill()
//        bezierPath.fill()
    }
}


extension ZZFloatingButton {
    func roundStyle() {
        layoutIfNeeded()
        let size = self.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize)
        self.layer.cornerRadius = min(size.width, size.height)/2
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
    }
    
    
    
}
