//
//  YZVideoManager.swift
//  Funny
//
//  Created by yanzhen on 16/12/29.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit
import AVFoundation

class YZVideoManager: NSObject {

    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private weak var videoCell: YZVideoTableViewCell?
    private var urlStr: String?
    private var isPlayEnd: Bool = false
    private var enterBackground: Bool = false
    
    public func playVideo(_ cell: YZVideoTableViewCell, urlString: String) {
        if !startPlayNewAV(urlString, play: cell.playBtn.isSelected) {
            return
        }
        videoPlayInterrupted()
        urlStr = urlString
        videoCell = cell
        videoCell?.isPause = false
        let playerItem = AVPlayerItem(url: URL(string: urlString)!)
        DispatchQueue.main.async { 
            if self.isPlayEnd && self.player?.currentItem != nil {
                NotificationCenter.default.removeObserver(self)
                self.player?.currentItem?.removeObserver(self, forKeyPath: "status")
                self.player?.replaceCurrentItem(with: playerItem)
            }else{
                self.player = AVPlayer(playerItem: playerItem)
                self.playerLayer = AVPlayerLayer(player: self.player)
                self.playerLayer?.backgroundColor = UIColor.black.cgColor
                self.isPlayEnd = true
            }
            ///
            self.playerLayer?.frame = cell.mainImageView.bounds
            cell.mainImageView.layer.addSublayer(self.playerLayer!)
            let layer = CALayer()
            layer.frame = cell.mainImageView.bounds
            layer.backgroundColor = UIColor.clear.cgColor
            self.layerDelegate.rightSpace = cell.rightSpace
            layer.delegate = self.layerDelegate
            layer.setNeedsDisplay()
            cell.mainImageView.layer.addSublayer(layer)
            ///
            self.addNotifi(playerItem)
            self.player?.play()
        }
    }
    
    public func tableViewReload() {
        videoPlayInterrupted()
    }
    
    
    private func videoPlayInterrupted() {
        urlStr = nil
        if player?.currentItem != nil {
            player?.pause()
            playVideoEnd()
        }
        ///暂停状态下刷新
        if videoCell != nil {
            if videoCell!.isPause {
                playVideoEnd()
                videoCell?.isPause = false
            }
        }
    }
    
    private func startPlayNewAV(_ urlString: String, play: Bool) ->Bool {
        if urlString == urlStr {
            if play {
                videoCell?.isPause = false
                self.player?.play()
                self.timer.fireDate = Date.distantPast
            }else{
                videoCell?.isPause = true
                self.player?.pause()
                self.timer.fireDate = Date.distantFuture
            }
            return false
        }
        return true
    }
    
    @objc private func updateProgress() {
        let currentTime = CGFloat(self.player!.currentTime().value) / CGFloat(self.player!.currentTime().timescale)
        let time = CGFloat(self.player!.currentItem!.duration.value) / CGFloat(self.player!.currentItem!.duration.timescale)
        let progress = CGFloat(currentTime) / CGFloat(time)
        videoCell?.progressView.setProgress(Float(progress), animated: true)
    }
//MARK: NotificationCenter
    private func addNotifi(_ item: AVPlayerItem) {
        item.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.playVideoEnd), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didEnterBackground), name: .UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didBecomeActive), name: .UIApplicationDidBecomeActive, object: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            let playerItem = self.player?.currentItem
            if playerItem?.status == .readyToPlay {
                self.timer.fireDate = Date.distantPast
            }else if playerItem?.status == .failed {
                self.isPlayEnd = false
                self.player?.currentItem!.removeObserver(self, forKeyPath: "status")
                self.timer.fireDate = Date.distantFuture
            }
        }
    }
    
    @objc private func playVideoEnd() {
        videoCell?.playBtn.isSelected = false
        if videoCell?.mainImageView.layer.sublayers != nil {
            if videoCell!.mainImageView.layer.sublayers!.count > 1 {
                let subLayer = videoCell!.mainImageView.layer.sublayers![0]
                let subLayer1 = videoCell!.mainImageView.layer.sublayers![1]
                subLayer.removeFromSuperlayer()
                subLayer1.removeFromSuperlayer()
            }
        }
        videoCell?.progressView.setProgress(0, animated: false)
        self.timer.fireDate = Date.distantFuture
        videoCell = nil
        urlStr = nil
    }
    
    @objc private func didEnterBackground() {
        if (self.player!.rate > 0) {
            self.player?.pause();
            self.willEnterBackground(true);
        }
    }
    
    @objc private func didBecomeActive() {
        if enterBackground {
            self.player?.play();
            self.willEnterBackground(false);
        }
    }
    
    private func willEnterBackground(_ status: Bool) {
        videoCell?.playBtn.isSelected = !status;
        videoCell!.isPause = status;
        enterBackground = status;
    }
//MARK: - lazy
    private lazy var timer:Timer = {
        let time = Timer(timeInterval: 0.1, target: self, selector: #selector(self.updateProgress), userInfo: nil, repeats: true);
        RunLoop.current.add(time, forMode: .commonModes)
        return time;
    }()
    
    private lazy var layerDelegate: YZLayerDelegate = {
        let layerDelegate = YZLayerDelegate()
        return layerDelegate
    }()

//MARK: - instance
    static let manager = YZVideoManager()
    private override init() {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
