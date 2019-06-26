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

        path.addArc(withCenter: self.center, radius: 55, startAngle: 0, endAngle: .pi * 2, clockwise: false)
        path.lineWidth = 2.0
        path.lineCapStyle = .round
        
        UIColor.lightGray.setStroke()
        
        path.stroke()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
