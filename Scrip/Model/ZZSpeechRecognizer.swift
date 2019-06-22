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

class ZZSpeechRecognizer: NSObject {
    
    static let shared = ZZSpeechRecognizer()
    
    var recognizing: Variable<Bool> = Variable<Bool>(false)
    
    private let callbackQueue = DispatchQueue(label: "com.zzstudio.speech.callback")
    
    private let audioEngine = AVAudioEngine()
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    private var recognizerRequest: SFSpeechAudioBufferRecognitionRequest?
    
    let availableState:Variable<Bool> = Variable<Bool>(false)
    
    private var speechRecognizer: SFSpeechRecognizer? {
        get {
            let recognizer = SFSpeechRecognizer(locale: Locale(identifier: Locale.preferredLanguages.first ?? "zh-CN"))
            recognizer?.delegate = self
            return recognizer
        }
    }
    
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
        
        // Cancel the previous task if it's running.
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
                
        }
        let inputNode = audioEngine.inputNode
        
        // Create and configure the speech recognition request.
        recognizerRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognizerRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        
        // Keep speech recognition data on device
        //        if #available(iOS 13, *) {
        //            recognitionRequest.requiresOnDeviceRecognition = false
        //        }
        
        // Create a recognition task for the speech recognition session.
        // Keep a reference to the task so that it can be canceled.
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                // Update the text view with the results.
//                self.textView.text = result.bestTranscription.formattedString
                isFinal = result.isFinal
                print("Text \(result.bestTranscription.formattedString)")
            }
            
            if error != nil || isFinal {
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognizerRequest = nil
                self.recognitionTask = nil
            }
        }
        
        // Configure the microphone input.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognizerRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        do {
        try audioEngine.start()
        }catch {
            
        }
 
    }
    
    func stop() {
        if self.audioEngine.isRunning {
            self.audioEngine.stop()
            recognizerRequest?.endAudio()
        }
//        self.recognitionTask = nil
    }
    
}


extension ZZSpeechRecognizer: SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        self.availableState.value = available
    }
}
