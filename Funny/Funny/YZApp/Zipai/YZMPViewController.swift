//
//  YZMPViewController.swift
//  Funny
//
//  Created by yanzhen on 2017/5/9.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit
import YZLFLiveKit

private let MPSETHEIGHT: CGFloat = 100

class YZMPViewController: UIViewController, YZMPSettingViewDelegate {

    private var videoView: UIImageView!
    private var session: LFLiveSession!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.navigationController?.isNavigationBarHidden = true
        
        videoView = UIImageView(frame: self.view.bounds)
        videoView.isUserInteractionEnabled = true
        videoView.clipsToBounds = true
        self.view.addSubview(videoView)
        
        let makeFaceBtn = UIButton(type: .custom)
        makeFaceBtn.frame = CGRect(x: 0, y: 0, width: 61, height: 61)
        makeFaceBtn.center = CGPoint(x: self.view.centerX, y: self.view.height - 60)
        makeFaceBtn.setBackgroundImage(#imageLiteral(resourceName: "mp_takePhoto"), for: .normal)
        makeFaceBtn.addTarget(self, action: #selector(self.takePhoto), for: .touchUpInside)
        self.view.addSubview(makeFaceBtn)
        
        let btnWH: CGFloat = 40
        let closeBtn = UIButton(type: .custom)
        closeBtn.frame = CGRect(x: self.view.width - btnWH - 10, y: self.view.height - btnWH - 10, width: btnWH, height: btnWH)
        closeBtn.setBackgroundImage(#imageLiteral(resourceName: "mp_close"), for: .normal)
        closeBtn.addTarget(self, action: #selector(self.close), for: .touchUpInside)
        self.view.addSubview(closeBtn)
        
        let switchCamera = UIButton(type: .custom)
        switchCamera.frame = CGRect(x: self.view.width - btnWH - 10, y: 20, width: btnWH, height: btnWH)
        switchCamera.setBackgroundImage(#imageLiteral(resourceName: "mp_switchCamera"), for: .normal)
        switchCamera.addTarget(self, action: #selector(self.switchCamera), for: .touchUpInside)
        self.view.addSubview(switchCamera)
        
        session = LFLiveSession(audioConfiguration: LFLiveAudioConfiguration.default(), videoConfiguration: LFLiveVideoConfiguration.defaultConfiguration(for: .medium3))
        session.showDebugInfo = false
        session.preView = videoView
        session.beautyLevel = 0.5
        session.brightLevel = 0.5
        session.running = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: .UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didBecomeActive), name: .UIApplicationDidBecomeActive, object: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.25) { 
            var frame = self.settingView.frame
            if frame.origin.y == 0 {
                frame.origin.y = -MPSETHEIGHT
            }else{
                frame.origin.y = 0
            }
            self.settingView.frame = frame
        }
    }
    
    @objc private func didEnterBackground() {
        session.running = false
    }
    
    @objc private func didBecomeActive() {
        session.running = true
    }
    
    @objc private func takePhoto() {
        let image = videoView.snapshotScreenInView()
        YZFunnyManager.saveImage(image)
    }
    
    @objc private func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func switchCamera() {
        if session.captureDevicePosition == .front {
            session.captureDevicePosition = .back
        }else{
            session.captureDevicePosition = .front
        }
    }
//MARK: - YZMPSettingViewDelegate
    lazy var settingView: YZMPSettingView = {
        let settingView = YZMPSettingView(frame: CGRect(x: 0, y: -MPSETHEIGHT, width: self.view.width, height: MPSETHEIGHT))
        settingView.delegate = self
        self.view.addSubview(settingView)
        return settingView
    }()
    
    func beautyValueChanged(value: CGFloat) {
        session.beautyLevel = value
    }
    
    func brightValueChanged(value: CGFloat) {
        session.brightLevel = value
    }
    
    deinit {
        session.running = false
        NotificationCenter.default.removeObserver(self)
    }
}
