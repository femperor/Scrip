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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        addSubviews()
        addConstraints()
        animateLogo()
        ZZSpeechRecognizer.shared.ensureAuthorization{ (success) -> (Void) in
            if Thread.isMainThread {
                print("main thread")
            } else {
                print("not main thread")
            }
            print("nothing")
        }
       
    }
    
    private func animateLogo() {
        let transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height/4.0)
        
        UIView.animate(withDuration: 0.4, delay: 0.1, animations: {
            self.logo.transform = transform
        }) { success in
            UIView.animate(withDuration: 0.3, animations: {
                self.name.alpha = 1.0
                self.message.alpha = 1.0
                self.name.transform = transform
                self.message.transform = transform
            })
        }
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
    }

    private func addSubviews() {
        view.addSubview(logo)
        view.addSubview(name)
        view.addSubview(message)
    }
    
    private func addConstraints() {
        logo.constrain([
            logo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = InputViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .partialCurl
         self.present(vc, animated: true, completion: nil)
    }
}

