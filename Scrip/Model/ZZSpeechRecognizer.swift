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

class ZZSpeechRecognizer {
    
    
    func ensureAuthorization(block: @escaping (Bool) -> Void){
        let status = SFSpeechRecognizer.authorizationStatus()
        if case .authorized =  status {
            block(true)
            return
        }
        
        if case .denied = status {
            // 提示用户开启权限
            block(false)
            return
        }
        
        
        SFSpeechRecognizer.requestAuthorization { (status) in
            switch status {
            case .authorized:
                os_log("SFSpeedchRecognizer authorization status: authorized")
                block(true)
            case .denied:
                    fallthrough
            case .restricted:
                os_log("SFSpeedchRecognizer authorization status: denied or restricted")
                block(false)
            case .notDetermined:
                os_log("SFSpeedchRecognizer authorization status: not determined")
            }
        }
    }
}
