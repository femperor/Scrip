//
//  InputViewController.swift
//  Scrip
//
//  Created by zhiou on 2019/4/7.
//  Copyright © 2019 ZZStudio. All rights reserved.
//

import UIKit

// 音频通话界面，主要由通话按钮和通话记录组成，纯界面，音频处理和转换文本流程由Model层进行
class InputViewController: UIViewController {

    // 通话界面音频通话按钮，按住时开始通话，松开结束；可设置双击保持通话状态，具体待定
    private var microphoneFloatingButton: ZZFloatingButton {
        let btn = ZZFloatingButton()
        
        view.addSubview(btn)
        return btn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
