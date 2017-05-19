//
//  YZBuDeJieVideoTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZBuDeJieVideoTableViewCell: YZVideoTableViewCell {

    private var userView: YZUserView!
    private var contentLabel: UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        userView = YZUserView(frame: CGRect(x: CONTENTSPACE, y: 0, width: WIDTH - 4 * CONTENTSPACE, height: USERVIEWHEIGHT))
        backView.addSubview(userView)
        
        contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: USERTEXTMAINLABELFONT)
        backView.addSubview(contentLabel)
    }
    
    public func configureCell(_ videoFrame: YZBuDeJieVideoFrame) {
        shareURL = videoFrame.videoModel.videouri
        shareTitle = videoFrame.videoModel.text
        userView.configureUserView(videoFrame.videoModel.profile_image, name: videoFrame.videoModel.name, time: videoFrame.videoModel.create_time)
        contentLabel.text = videoFrame.videoModel.text
        mainImageView.yz_setImage(videoFrame.videoModel.bimageuri)
        
        contentLabel.frame = videoFrame.contentLabelFrame
        videoViewFrame = videoFrame.mainIVFrame
        backView.frame = videoFrame.backViewFrame

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
