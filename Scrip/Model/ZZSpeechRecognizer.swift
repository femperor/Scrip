//
//  ZZSpeechRecognizer.swift
//  Scrip
//
//  Created by zhiou on 2019/6/1.
//  Copyright © 2019 ZZStudio. All rights reserved.
//

import Foundation
import Speech
import AVFoundation
import os.log
import RxSwift

class ZZSpeechRecognizer {
    
    static let shared = ZZSpeechRecognizer()
    
    var recognizing: Variable<Bool> = Variable<Bool>(false)
    
    private let callbackQueue = DispatchQueue(label: "com.zzstudio.speech.callback")
    
    func ensureAuthorization(block: @escaping (Bool) -> Void){
        let status = SFSpeechRecognizer.authorizationStatus()
        if case .authorized =  status {
            callbackQueue.async {
                block(true)
            }
            return
        }
        
        if case .denied = status {
            // 提示用户开启权限
            callbackQueue.async {
                block(false)
            }
            return
        }
        
        SFSpeechRecognizer.requestAuthorization { (status) in
            switch status {
            case .authorized:
                os_log("SFSpeedchRecognizer authorization status: authorized")
                self.callbackQueue.async {
                    block(true)
                }
            case .denied:
                    fallthrough
            case .restricted:
                os_log("SFSpeedchRecognizer authorization status: denied or restricted")
                self.callbackQueue.async {
                    block(false)
                }
            case .notDetermined:
                os_log("SFSpeedchRecognizer authorization status: not determined")
            }
        }
    }
    
    func start() {
        
    }
    
    func stop() {
        
    }
    
}
