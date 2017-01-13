//
//  YZWhatSomeTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZWhatSomeTableViewCell: YZPictureTableViewCell {

    private var userView: YZUserView!
    private var contentLabel: UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        userView = YZUserView(frame: CGRect(x: CONTENTSPACE, y: 0, width: WIDTH - 4 * CONTENTSPACE, height: USERVIEWHEIGHT))
        backView.addSubview(userView)
        
        contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: USERTEXTMAINLABELFONT)
        contentLabel.numberOfLines = 0
        backView.addSubview(contentLabel)
    }
    
    public func configureCell(_ pictureFrame: YZWhatSomeFrame) {
        let group = pictureFrame.model.group!
        userView.configureUserView(group.user!.avatar_url!, name: group.user!.name!, time: dateString(group.create_time!.intValue))
        contentLabel.text = group.text
        mainImageView.yz_setImage(group.middle_image!.url_list![0]["url"]!, placeholderImageString: nil)
        contentLabel.frame = pictureFrame.contentLabelFrame
        mainImageView.frame = pictureFrame.mainIVFrame
        backView.frame = pictureFrame.backViewFrame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
