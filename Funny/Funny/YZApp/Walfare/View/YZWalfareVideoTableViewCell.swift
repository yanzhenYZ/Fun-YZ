//
//  YZWalfareVideoTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZWalfareVideoTableViewCell: YZVideoTableViewCell {

    private var creatTimeLabel: UILabel!
    private var contentLabel: UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        creatTimeLabel = UILabel(frame: CGRect(x: CONTENTSPACE * 2, y: CONTENTSPACE / 2, width: 200, height: 25))
        creatTimeLabel.font = UIFont.systemFont(ofSize: CREATTIMELABELFONT)
        backView.addSubview(creatTimeLabel)
        ///
        contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: USERTEXTMAINLABELFONT)
        backView.addSubview(contentLabel)
    }
    
    public func configureCell(_ videoFrame: YZWalfareVideoFrame) {
        shareURL   = videoFrame.videoModel.vplay_url
        shareTitle = videoFrame.videoModel.wbody
        creatTimeLabel.text = dateString(Int(videoFrame.videoModel.update_time)!)
        contentLabel.text  = videoFrame.videoModel.wbody
        mainImageView.yz_setImage(videoFrame.videoModel.vpic_small, placeholderImageString: nil)
        ///
        contentLabel.frame  = videoFrame.contentLabelFrame
        mainImageView.frame = videoFrame.mainIVFrame
        playBtn.frame       = videoFrame.playBtnFrame
        progressView.frame  = videoFrame.progressViewFrame
        backView.frame      = videoFrame.backViewFrame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
