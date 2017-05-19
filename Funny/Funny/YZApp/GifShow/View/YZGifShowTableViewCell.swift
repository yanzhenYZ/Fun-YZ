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
        
        videoViewFrame = CGRect(x: 50, y: 65, width: WIDTH - 100, height: mainHeight)
        backView.frame = CGRect(x: CONTENTSPACE, y: CONTENTSPACE / 2, width: WIDTH - 2 * CONTENTSPACE, height: videoViewFrame.maxY + 7)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
