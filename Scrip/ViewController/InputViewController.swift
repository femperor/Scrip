//
//  InputViewController.swift
//  Scrip
//
//  Created by zhiou on 2019/4/7.
//  Copyright © 2019 ZZStudio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

// 音频通话界面，主要由通话按钮和通话记录组成，纯界面，音频处理和转换文本流程由Model层进行
class InputViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    // 通话界面音频通话按钮，按住时开始通话，松开结束；可设置双击保持通话状态，具体待定
    
    override func loadView() {
        view = BaseView(frame: UIScreen.main.bounds)
    }
    
    private let microphoneFloatingButton: FloatingButton  = FloatingButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        bindings()
        layout();
    }
    
    private func addSubviews() {
        view.addSubview(microphoneFloatingButton)
    }
    
    private func bindings() {
        
        ZZSpeechRecognizer.shared.recognizing.asObservable()
            .subscribe(onNext: { (on) in
            print(on ? "On": "Off")
        })
        .disposed(by: disposeBag)
        
        microphoneFloatingButton.isPressing.asDriver()
        .distinctUntilChanged()
            .map({ (state) -> Bool in
                switch state {
                case .holding:
                        return true
                case .pause:
                        fallthrough
                case .stopped:
                        return false
                }
            })
        .drive(ZZSpeechRecognizer.shared.recognizing)
        .disposed(by: disposeBag)
  
    }
    
    private func layout() {
        var bottomOffset:CGFloat = -10.0
        if #available(iOS 11, *) {
            bottomOffset += -additionalSafeAreaInsets.bottom
        } else {
            bottomOffset += -self.bottomLayoutGuide.length
        }
        microphoneFloatingButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(bottomLayoutGuide.snp.top).offset(-10 + bottomOffset)
            make.centerX.equalToSuperview()
            make.width.equalTo(55)
            make.height.equalTo(55)
        }
        microphoneFloatingButton.roundStyle()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
