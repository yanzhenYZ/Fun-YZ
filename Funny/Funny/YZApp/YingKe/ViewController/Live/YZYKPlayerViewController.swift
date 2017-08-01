//
//  YZYKPlayerViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit
import IJKMediaFramework

class YZYKPlayerViewController: UIViewController {

    private var model: YZYingKeModel!
    private var loadBlurImage: UIImageView!
    private var closeBtn: UIButton!
    private var player: IJKFFMoviePlayerController!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    init(_ liveModel: YZYingKeModel) {
        super.init(nibName: nil, bundle: nil)
        model = liveModel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        if !player.isPlaying() {
            player.prepareToPlay()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
        player.shutdown()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black
        player = IJKFFMoviePlayerController(contentURLString: model.stream_addr, with: IJKFFOptions.byDefault())
        player.view.frame = self.view.bounds
        player.shouldAutoplay = true
        self.view.addSubview(player.view)
        ///
        loadBlurImage = UIImageView(frame: self.view.bounds)
        if model.creator~~ {
            loadBlurImage.yz_setImage(model.creator!.portrait, placeholder: "default_room")
        }
        self.view.addSubview(loadBlurImage)
        
        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = loadBlurImage.bounds
        loadBlurImage.addSubview(effectView)
        
        let closeBthWH:CGFloat = 35
        let closeBtn = UIButton(frame: CGRect(x: WIDTH - closeBthWH - 10, y: HEIGHT - closeBthWH - 10, width: closeBthWH, height: closeBthWH))
        closeBtn.setImage(#imageLiteral(resourceName: "window_close"), for: .normal)
        closeBtn.layer.masksToBounds = true
        closeBtn.layer.cornerRadius = closeBthWH * 0.5
        closeBtn.layer.borderWidth = 1.0
        closeBtn.layer.borderColor = UIColor(27, 210, 189).cgColor
        closeBtn.addTarget(self, action: #selector(self.closeBtnClick), for: .touchUpInside)
        self.view.addSubview(closeBtn)
        
        installMovieNotificationObservers()
    }
    
    @objc private func closeBtnClick() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    private func installMovieNotificationObservers() {
        let center = NotificationCenter.default
        center.addObserver(forName: .IJKMPMoviePlayerLoadStateDidChange, object: player, queue: OperationQueue.main) { (notification) in
            YZLog(self.player.loadState)
        }
        
        center.addObserver(forName: .IJKMPMoviePlayerPlaybackDidFinish, object: player, queue: OperationQueue.main) { (notification) in
            let reason = notification.userInfo?[IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey]
            YZLog(reason ?? "IJKMPMoviePlayerPlaybackDidFinish")
        }
        
        center.addObserver(forName: .IJKMPMediaPlaybackIsPreparedToPlayDidChange, object: player, queue: OperationQueue.main) { (notification) in
            YZLog("mediaIsPreparedToPlayDidChange")
        }
        
        center.addObserver(forName: .IJKMPMoviePlayerPlaybackStateDidChange, object: player, queue: OperationQueue.main) { (notification) in
            YZLog(self.player.playbackState)
            self.loadBlurImage.isHidden = true
            self.loadBlurImage.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
