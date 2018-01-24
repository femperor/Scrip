//
//  ViewController.swift
//  Scrip
//
//  Created by fire on 16/01/2018.
//  Copyright © 2018 ZZStudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var logo: UIImageView = {
        let image = UIImageView(image:UIImage.logo)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var name: UILabel = {
        let content = UILabel(font: .title, color: .blue)
        return content
    }()
    
    private var message: UILabel = {
        let content = UILabel(font: .customMedium(size: 18.0), color: .blue)
        return content
    }()
    
    private var startBtn: UIButton = {
        let btn = UIButton(type: .system)
        return btn
    }()
    
    private var cleanBtn: UIButton = {
        let btn = UIButton(type: .system)
        return btn
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel(font: UIFont.boldSystemFont(ofSize: 55), color: .red)
        return label
    }()
    
    private var totalLabel: UILabel = {
        let total = UILabel(font: UIFont.boldSystemFont(ofSize: 40), color: .green)
        return total
    }()
    
    var timer: Timer? = nil
    let limit = 200
    var count = 0 {
        didSet {
            self.timeLabel.text = "\(count)"
        }
    }
    var total: Int = 0 {
        didSet {
            self.totalLabel.text = "\(total)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        addSubviews()
        addConstraints()
        let transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height/4.0)
        UIView.animate(withDuration: 0.4, delay: 0.1, animations: {
            self.logo.transform = transform
        }) { success in
            UIView.animate(withDuration: 0.3, animations: {
                self.name.alpha = 1.0
                self.message.alpha = 1.0
                self.name.transform = transform
                self.message.transform = transform
            }, completion: nil)
            
        }
        startBtn.addTarget(self, action: #selector(toggleTimer(_:)), for: .touchUpInside)
        cleanBtn.addTarget(self, action: #selector(cleanData(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let valid = self.timer?.isValid, valid{
            self.timer?.fireDate = Date()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let valid = self.timer?.isValid, valid {
            self.timer?.fireDate = Date.distantFuture
        }
    }
    
    @objc func cleanData(_ btn: UIButton) {
        total = 0
        count = 0
        self.timer?.invalidate()
        self.timer = nil
    }
    
    @objc func toggleTimer(_ btn: UIButton) {
        guard let timer = timer else {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter(_:)), userInfo: nil, repeats: true)
            return
        }
        timer.invalidate()
        self.timer = nil
    }
    
    @objc func updateCounter(_ timer:Timer) {
        if self.count >= 3 {
            self.count = 0
            total += 1
        } else {
            self.count += 1
        }
//        self.timeLabel.text = "\(self.count)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setData() {
        name.text = S.App.name
        name.textAlignment = .center
        name.alpha = 0.0
        message.text = S.App.message
        message.textAlignment = .center
        message.lineBreakMode = .byWordWrapping
        message.numberOfLines = 0
        message.alpha = 0.0
        
        startBtn.setTitle("开始/暂停", for: .normal)
        cleanBtn.setTitle("清除记录", for: .normal)
        
        self.timeLabel.text = "0"
        
        totalLabel.text = "0"
    }

    private func addSubviews() {
        view.addSubview(logo)
        view.addSubview(name)
        view.addSubview(message)
        view.addSubview(startBtn)
        view.addSubview(cleanBtn)
        view.addSubview(timeLabel)
        view.addSubview(totalLabel)
    }
    
    private func addConstraints() {
//        let yConstraint = NSLayoutConstraint(item: logo, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 0.5, constant: 0.0)
        let yConstraint = NSLayoutConstraint(item:startBtn, attribute: .centerY, relatedBy:.equal, toItem:view, attribute: .centerY, multiplier: 1.5, constant: 0.0)
        logo.constrain([
            logo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            yConstraint,
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             logo.heightAnchor.constraint(equalTo: logo.widthAnchor, multiplier: C.Sizes.logoAspectRatio),
            logo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.35)
           
            ])
        name.constrain([
            name.centerXAnchor.constraint(equalTo: logo.centerXAnchor),
            name.topAnchor.constraint(equalTo: logo.bottomAnchor),
            name.widthAnchor.constraint(equalTo: logo.widthAnchor),
            ])
        message.constrain([
            message.centerXAnchor.constraint(equalTo: logo.centerXAnchor),
            message.topAnchor.constraint(equalTo: name.bottomAnchor),
            message.widthAnchor.constraint(equalTo: logo.widthAnchor, multiplier: 1.0/0.618)])
        startBtn.constrain([
            startBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            yConstraint
            ])
        cleanBtn.constrain([
            cleanBtn.topAnchor.constraint(equalTo: startBtn.bottomAnchor, constant: 5.0),
            cleanBtn.centerXAnchor.constraint(equalTo: startBtn.centerXAnchor, constant: 0.0)
            ])
        timeLabel.constrain([
            timeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        totalLabel.constrain([
            totalLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant:20.0),
            totalLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20.0)
            ])
    }

}

