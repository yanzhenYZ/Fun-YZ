//
//  YZGifShowTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZGifShowTableViewCell: YZVideoTableViewCell {

    private var userView: YZUserView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        userView = YZUserView(frame: CGRect(x: CONTENTSPACE, y: 0, width: WIDTH - 4 * CONTENTSPACE, height: USERVIEWHEIGHT))
        backView.addSubview(userView)
    }
    
    public func configCell(_ model: YZGifShowModel) {
        shareURL = model.main_mv_url
        userView.configureUserView(model.headurl, name: model.user_name, time: model.time)
        mainImageView.yz_setImage(model.thumbnail_url)
        let mainHeight = (WIDTH - 100) / 3 * 4
        let mainIVFrame = CGRect(x: 50, y: 65, width: WIDTH - 100, height: mainHeight)
        mainImageView.frame = mainIVFrame
        progressView.frame = CGRect(x: mainIVFrame.origin.x, y: mainIVFrame.maxY, width: mainIVFrame.size.width, height: 2)
        playBtn.frame = CGRect(x: mainIVFrame.maxX - 70, y: mainIVFrame.maxY - 62, width: 70, height: 62)
        backView.frame = CGRect(x: CONTENTSPACE, y: CONTENTSPACE / 2, width: WIDTH - 2 * CONTENTSPACE, height: mainIVFrame.maxY + 7)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
