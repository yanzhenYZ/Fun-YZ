//
//  YZYKLiveViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZYKLiveViewController: UIViewController, LFLiveSessionDelegate {

    private var preView: UIView!
    private var session: LFLiveSession!
    @IBOutlet private weak var statusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        preView = UIView(frame: CGRectScreen)
        self.view.addSubview(preView)
        self.view.insertSubview(preView, at: 1)
        YZFunnyManager.requestAccessForVideo(completionHandler: nil)
        YZFunnyManager.requestAccessForAudio()
        
        session = LFLiveSession(audioConfiguration: LFLiveAudioConfiguration.default(), videoConfiguration: LFLiveVideoConfiguration.defaultConfiguration(for: LFLiveVideoQuality(rawValue: YZUserDefaultsManager.getVideoQuality())!))
        session.showDebugInfo = false
        session.delegate = self
        session.preView = preView
        session.beautyLevel = CGFloat(YZUserDefaultsManager.getBeautyLevel())
        session.brightLevel = CGFloat(YZUserDefaultsManager.getBrightLevel())
        session.running = true
    }

    @IBAction private func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func switchCamera(_ sender: UIButton) {
        session.captureDevicePosition = session.captureDevicePosition == .front ? .back : .front
    }
    
    @IBAction private func startLive(_ sender: UIButton) {
        if !sender.isSelected {
            let streamInfo = LFLiveStreamInfo()
            streamInfo.url = YK_Live_Header + YZUserDefaultsManager.getSelfLiveAddress()
            print(streamInfo.url)
            session.startLive(streamInfo)
        }else{
            session.stopLive()
        }
        sender.isSelected = !sender.isSelected
    }
//MARK: - LFLiveSessionDelegate
    func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
        statusLabel.text = ["准备中","连接中","已连接","已断开","连接出错","刷新中"][Int(state.rawValue)]
    }
    
    func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
        print("LFLiveSocketErrorCode\(errorCode)")
    }
}
