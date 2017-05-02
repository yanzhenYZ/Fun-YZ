//
//  YZVideoTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 16/12/27.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

protocol YZVideoPlayDelegate : NSObjectProtocol {
    func playVideo(_ play: Bool, videoCell: YZVideoTableViewCell)
    func playVideoOnWindow(_ videoCell: YZVideoTableViewCell)
}

class YZVideoTableViewCell: YZTableViewCell {

    var mainImageView: UIImageView!
    var playBtn: UIButton!
    var progressView: UIProgressView!
    
    weak var delegate: YZVideoPlayDelegate?
    ///分享的标题可能不存在--网址一定存在
    var shareTitle: String?
    var shareURL: String!
    ///
    var rightSpace: CGFloat = 90
    var isPause: Bool = false
    ///
    ///
    ///
    var isRefresh: Bool {
        get{
            return playBtn.isSelected || isPause
        }
    }
    
    public func tableViewReloadData() {
        if isRefresh {
            YZVideoManager.manager.tableViewReload()
            playBtn.isSelected = false
        }
    }
    
    deinit {
        if playBtn.isSelected {
            YZVideoManager.manager.tableViewReload()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGestureAction(longPress:)))
        self.addGestureRecognizer(longPress)
        
        let pin = UIPinchGestureRecognizer(target: self, action: #selector(self.pinGestureAction(pin:)))
        self.addGestureRecognizer(pin)
        configureUI()
    }
    
    @objc private func longPressGestureAction(longPress: UILongPressGestureRecognizer) {
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
    
    @objc private func pinGestureAction(pin: UIPinchGestureRecognizer) {
        YZLog("pinGestureAction")
        if pin.state == .began && isRefresh {
            delegate?.playVideoOnWindow(self)
        }
    }
    
    @objc private func platBtnClick(btn: UIButton) {
        btn.isSelected = !btn.isSelected
        delegate?.playVideo(btn.isSelected, videoCell: self)
    }
    
    private func configureUI() {
        mainImageView = UIImageView()
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
        backView.addSubview(mainImageView)
        
        playBtn = UIButton(type: .custom)
        playBtn.backgroundColor = UIColor.clear
        playBtn.setBackgroundImage(UIImage(named: "play_start"), for: .normal)
        playBtn.setBackgroundImage(UIImage(named: "play_pause"), for: .selected)
        playBtn.addTarget(self, action: #selector(self.platBtnClick(btn:)), for: .touchUpInside)
        backView.addSubview(playBtn)
        
        progressView = UIProgressView()
        progressView.progressTintColor = YZColor(255, 155, 23)
        progressView.progress = 0
        backView.addSubview(progressView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
