//
//  BaseView.swift
//  Scrip
//
//  Created by zhiou on 2019/6/25.
//  Copyright © 2019 ZZStudio. All rights reserved.
//

import UIKit

class BaseView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = UIBezierPath()
//        path.move(to: CGPoint(x:bounds.origin.x, y:bounds.origin.y + bounds.size.height))
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
