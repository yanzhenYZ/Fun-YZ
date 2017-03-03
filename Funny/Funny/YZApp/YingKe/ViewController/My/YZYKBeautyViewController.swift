//
//  YZYKBeautyViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZYKBeautyViewController: UIViewController {
    
    private var session: LFLiveSession!
    private var beautyLevel: Float = 0.0
    private var brightLevel: Float = 0.0
    @IBOutlet private weak var beautySlider: UISlider!
    @IBOutlet private weak var brightSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "美颜设置"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(self.saveAction))
        beautyLevel = YZUserDefaultsManager.getBeautyLevel() * 10
        brightLevel = YZUserDefaultsManager.getBrightLevel() * 10
        brightSlider.value = brightLevel
        beautySlider.value = beautyLevel
        YZFunnyManager.requestAccessForAudio()
        YZFunnyManager.requestAccessForVideo(completionHandler: nil)
        
        session = LFLiveSession(audioConfiguration: LFLiveAudioConfiguration.default(), videoConfiguration: LFLiveVideoConfiguration.defaultConfiguration(for: LFLiveVideoQuality(rawValue: YZUserDefaultsManager.getVideoQuality())!))
        session.showDebugInfo = false
        session.preView = self.view
        session.beautyLevel = CGFloat(YZUserDefaultsManager.getBeautyLevel())
        session.brightLevel = CGFloat(YZUserDefaultsManager.getBrightLevel())
        session.running = true
    }

    @objc private func saveAction() {
        YZUserDefaultsManager.saveBeautyLevel(beautyLevel)
        YZUserDefaultsManager.saveBrightLevel(brightLevel)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func beautySliderValueChanged(_ sender: UISlider) {
        beautyLevel = sender.value
        session.beautyLevel = CGFloat(sender.value) / 10
    }

    @IBAction private func brightSliderValueChanged(_ sender: UISlider) {
        brightLevel = sender.value
        session.brightLevel = CGFloat(sender.value) / 10
    }
}
