//
//  ZZFloatingButton.swift
//  Scrip
//
//  Created by zhiou on 2019/6/1.
//  Copyright © 2019 ZZStudio. All rights reserved.
//

import UIKit
import RxSwift

class FloatingButton: UIView {
    enum Style {
        case round
    }
    
    enum state {
        case holding
        case pause
        case stopped
        case canceled
        
        var description: String {
            switch self {
            case .holding:
                return "holding state"
            case .pause:
                return "pause state"
            case .stopped:
                return "stopped"
            case .canceled:
                return "canceled"
            }
        }
    }
    
    let isPressing = Variable<state>(.stopped)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = UIBezierPath()
        path.move(to: CGPoint(x:bounds.origin.x, y:bounds.origin.y + bounds.size.height))
        path.addArc(withCenter: self.center, radius: 55, startAngle: 0, endAngle: .pi * 2, clockwise: false)
        path.lineWidth = 2.0
        path.lineCapStyle = .round
        UIColor.lightGray.setStroke()
        path.stroke()
    }
}


extension FloatingButton {
    func roundStyle() {
        let size = self.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize)
        self.layer.cornerRadius = min(size.width, size.height)/2
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 1.0
    }
}

extension FloatingButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isPressing.value = .holding
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.randomElement()
        if let point = touch?.location(in: self)
        {
            isPressing.value = self.layer.contains(point) ? .stopped : .canceled
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isPressing.value = .stopped
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.randomElement()
        if let point = touch?.location(in: self)
             {
                isPressing.value = self.layer.contains(point) ? .holding : .pause
        }
    }
}
