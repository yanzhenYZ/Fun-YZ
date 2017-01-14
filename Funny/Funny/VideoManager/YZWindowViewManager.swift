//
//  YZWindowViewManager.swift
//  Funny
//
//  Created by yanzhen on 16/12/29.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit
import AVFoundation

class YZWindowViewManager: NSObject, WindowViewProtocol {
   
    private var player: AVPlayer? = nil
    private var playerLayer: AVPlayerLayer?
    private var urlStr: String?
    private var isPlayEnd: Bool? = false;
    private var enterBackground: Bool = false
    private var isPause: Bool = false;
    private var isPlaying: Bool = false
    
    public func isWindowViewShow() ->Bool {
        return !self.windowView.isHidden;
    }
    
    public func videoPlayWithVideoUrlString(_ urlString: String) {
        urlStr = urlString
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.showVideoWindow()
        appDelegate.videoWindow.makeWindowView(self.windowView)
        self.windowView.isHidden = false
        self.startPlayVideo(urlString)
    }
    
    private func startPlayVideo(_ urlString: String) {
        self.windowView.playBtn.isSelected = false
        self.windowView.loadingView.showLoadingView()
        isPause = false
        
        let url = URL(string: urlString)
        let playerItem = AVPlayerItem(url: url!)
        DispatchQueue.main.async(execute: { () -> Void in
            if self.isPlayEnd! && self.player?.currentItem != nil {
                NotificationCenter.default.removeObserver(self)
                self.player?.currentItem!.removeObserver(self, forKeyPath: "status")
                self.player?.replaceCurrentItem(with: playerItem)
            }else{
                self.player = AVPlayer(playerItem: playerItem)
                self.playerLayer = AVPlayerLayer(player: self.player)
                self.playerLayer!.backgroundColor = UIColor.clear.cgColor
                self.isPlayEnd = true
            }
            self.playerLayer!.frame = self.windowView.mainImageView.bounds
            self.windowView.mainImageView.layer.addSublayer(self.playerLayer!)
            self.addNotifi(playerItem)
            self.player!.play()
            self.isPlaying = true
        })
    }
    
    @objc private func updateProgress() {
        let currentTime = CGFloat(self.player!.currentTime().value) / CGFloat(self.player!.currentTime().timescale)
        let time = CGFloat(self.player!.currentItem!.duration.value) / CGFloat(self.player!.currentItem!.duration.timescale)
        let progress = CGFloat(currentTime) / CGFloat(time)
        self.windowView.progressView.setProgress(Float(progress), animated: true)
    }
//MARK: - WindowViewProtocol
    func closeWindowView() {
        if (self.player?.rate)! > Float(0) || isPlaying {
            self.player?.pause()
            self.timer.fireDate = Date.distantFuture
        }
        self.windowView.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.videoWindow.isHidden = true
        appDelegate.window?.makeKeyAndVisible()
    }

    func videoPlayOrPause(_ playBtn: UIButton) {
        let block = {(pause: Bool) ->Void in
            self.isPause = pause
            playBtn.isSelected = pause
            self.isPlaying = !pause
            if pause {
                self.player?.pause()
                self.timer.fireDate = Date.distantFuture
            }else{
                self.player?.play()
                self.timer.fireDate = Date.distantPast
            }
        }

        if isPlaying {
            block(true)
        }else{
            if isPause {
                block(false)
            }else{
                self.startPlayVideo(urlStr!)
            }
        }
    }
    
    func loadingViewDismissForFail() {
        self.windowView.playBtn.isSelected = true
    }
//MARK: - observe
    func addNotifi(_ item: AVPlayerItem) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.playVideoEnd), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        item.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: .UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didBecomeActive), name: .UIApplicationDidBecomeActive, object: nil)
    }
    
    @objc private func playVideoEnd() {
        isPlaying = false;
        self.windowView.playBtn.isSelected = true
        self.timer.fireDate = Date.distantFuture
        self.windowView.progressView.setProgress(0.0, animated: false)
    }
    
    @objc private func didEnterBackground() {
        if (self.player?.rate)! > Float(0) || isPlaying {
            self.player?.pause()
            enterBackground = true
        }
    }
    
    @objc private func didBecomeActive() {
        if enterBackground {
            enterBackground = false
            self.player?.play()
            isPlaying = true
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            let playItem = self.player?.currentItem
            if playItem?.status == .readyToPlay {
                self.timer.fireDate = Date.distantPast
                self.windowView.loadingView.stopAnimating()
                self.windowView.loadingView.isHidden = true
            }else if playItem?.status == .failed {
                self.isPlayEnd = false
                isPlaying = false
                self.windowView.loadingView.loadingFail()
                self.player?.currentItem!.removeObserver(self, forKeyPath: "status")
                self.timer.fireDate = Date.distantFuture
            }
        }
    }

//MARK: - lazy
    lazy var timer: Timer = {
        let time = Timer(timeInterval: 0.1, target: self, selector: #selector(self.updateProgress), userInfo: nil, repeats: true)
        RunLoop.current.add(time, forMode: .commonModes);
        return time
    }()
    
    lazy var windowView: YZWindowView = {
        let windowView = YZWindowView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: WIDTH / 4 * 3 + 4))
        windowView.delegate = self
        windowView.isHidden = true
        //        let window = UIApplication.sharedApplication().keyWindow;
        //        window!.addSubview(windowView);
        return windowView
    }()

//MARK: - 单例
    static let manager = YZWindowViewManager()
    private override init() {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}
