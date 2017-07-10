//
//  YZVideoTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 16/12/27.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit
import YZPlayer

protocol YZVideoPlayDelegate : NSObjectProtocol {
    func playVideo(_ play: Bool, videoCell: YZVideoTableViewCell)
    func playVideoOnWindow(_ videoCell: YZVideoTableViewCell)
}

class YZVideoTableViewCell: YZTableViewCell {

    var mainImageView: YZAVView!
    var playBtn: UIButton!
    fileprivate var progressView: UIProgressView!
    ///分享的标题可能不存在--网址一定存在
    var shareTitle: String?
    var shareURL: String!
    var videoViewFrame: CGRect! {
        didSet {
            mainImageView.frame = videoViewFrame;
            playBtn.frame = CGRect(x: videoViewFrame.maxX - 70, y: videoViewFrame.maxY - 62, width: 70, height: 62)
            progressView.frame = CGRect(x: videoViewFrame.origin.x, y: videoViewFrame.maxY, width: videoViewFrame.size.width, height: 2)
            
        }
    }

    
    public func tableViewReloadData() {
        playBtn.isSelected = false
        progressView.setProgress(0, animated: false)
        mainImageView.reset()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGestureAction(longPress:)))
        self.addGestureRecognizer(longPress)
        
        let pin = UIPinchGestureRecognizer(target: self, action: #selector(self.pinGestureAction(pin:)))
        self.addGestureRecognizer(pin)
        configureUI()
    }
    
    deinit {
        mainImageView.reset()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension YZVideoTableViewCell {
    
    fileprivate func configureUI() {
        mainImageView = YZAVView()
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
        backView.addSubview(mainImageView)
        
        let color = UIColor(colorLiteralRed: 1.0, green: 155 / 255.0, blue: 23 / 255.0, alpha: 1)
        let attributes = [NSForegroundColorAttributeName : color, NSFontAttributeName : UIFont(name: "IowanOldStyle-BoldItalic", size: 18)!]
        let mark = YZAVMark("Y&Z TV", rect: CGRect(x: 5, y: 5, width: 120, height: 40), attrs: attributes)
        mainImageView.mark = mark
        
        playBtn = UIButton(type: .custom)
        playBtn.backgroundColor = UIColor.clear
        playBtn.setBackgroundImage(#imageLiteral(resourceName: "play_start"), for: .normal)
        playBtn.setBackgroundImage(#imageLiteral(resourceName: "play_pause"), for: .selected)
        playBtn.addTarget(self, action: #selector(self.playBtnClick(btn:)), for: .touchUpInside)
        backView.addSubview(playBtn)
        
        progressView = UIProgressView()
        progressView.progressTintColor = YZColor(255, 155, 23)
        progressView.progress = 0
        backView.addSubview(progressView)
    }
    
    @objc fileprivate func longPressGestureAction(longPress: UILongPressGestureRecognizer) {
        YZLog("longPressGestureAction")
        if longPress.state == .began {
            let message = WXMediaMessage()
            message.title = shareTitle~~ ? shareTitle : "搞笑视频"
            var data = UIImageJPEGRepresentation(mainImageView.image!, 0.3)
            var scale: CGFloat = 0.2
            for _ in 0..<3 {
                scale *= 0.5
                if data!.count / 1000 > 16 {
                    data = UIImageJPEGRepresentation(mainImageView.image!, scale)
                }else{
                    break
                }
            }
            var image = UIImage(data: data!)
            if data!.count / 1000 > 17 {
                image = #imageLiteral(resourceName: "play")
            }
            message.setThumbImage(image)
            let ext = WXVideoObject();
            ext.videoUrl = shareURL;
            message.mediaObject = ext;
            let req = SendMessageToWXReq();
            req.bText = false;
            req.message = message;
            req.scene = Int32(1);
            WXApi.send(req);
        }
    }
    
    @objc fileprivate func pinGestureAction(pin: UIPinchGestureRecognizer) {
        if pin.state == .began {
            if playBtn.isSelected || mainImageView.isPausing {
                playBtn.isSelected = false
                progressView.setProgress(0, animated: false)
                let appdegate = UIApplication.shared.delegate as! AppDelegate
                appdegate.avWindow.isHidden = false
                appdegate.avWindow.coverImage = mainImageView.image
                mainImageView.reset()
                appdegate.avWindow.playAV(shareURL)
            }
        }
    }
    
    @objc fileprivate func playBtnClick(btn: UIButton) {
        let appdegate = UIApplication.shared.delegate as! AppDelegate
        if !appdegate.avWindow.isHidden {
            appdegate.avWindow.coverImage = mainImageView.image
            appdegate.avWindow.playAV(shareURL)
            return
        }
        
        btn.isSelected = !btn.isSelected
        if (!btn.isSelected) {
            mainImageView.pause()
            return;
        }
        if (mainImageView.isPausing) {
            mainImageView.play()
            return;
        }
        
        mainImageView.playAV(shareURL, begin: {
            print("begin")
        }, finished: { [weak self] in
            self?.playBtn.isSelected = !(self?.playBtn.isSelected)!
            self?.progressView.setProgress(0, animated: false)
            print("finished")
            }, failed: { (error) in
                print(error!)
        }) { [weak self] (time) in
            print("\(time.totalTime)--\(time.currentTime)--\(time.loadedTime)")
            self?.progressView.setProgress(Float(time.currentTime / time.totalTime), animated: false)
        }
    }
}
