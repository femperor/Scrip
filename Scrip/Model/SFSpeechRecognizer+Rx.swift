//
//  SFSpeechRecognizer+Rx.swift
//  Scrip
//
//  Created by zhiou on 2019/7/6.
//  Copyright © 2019 ZZStudio. All rights reserved.
//

import Speech
import RxSwift

extension Reactive where Base: SFSpeechRecognizer {
    func authorization() -> Single<SFSpeechRecognizerAuthorizationStatus> {
        return Observable<SFSpeechRecognizerAuthorizationStatus>.create { observer in
            let status = SFSpeechRecognizer.authorizationStatus()
            if case .notDetermined = status {
                SFSpeechRecognizer.requestAuthorization({ (status) in
                    observer.onNext(status)
                })
            } else {
                observer.onNext(status)
            }
            return Disposables.create()
            }.asSingle()
    }
    
    func recognitionTask(request: SFSpeechRecognitionRequest) -> Observable<SFSpeechRecognitionResult> {
        return Observable<SFSpeechRecognitionResult>.create { observer in
            let task = self.base.recognitionTask(with: request, resultHandler: { (result, error) in
                if let error = error {
                    observer.onError(error)
                    return
                }
                if let result = result {
                    observer.onNext(result)
                }
            })
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
