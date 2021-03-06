//
//  YZContentVideoTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 16/12/28.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZContentVideoTableViewCell: YZVideoTableViewCell {

    private var userView: YZUserView!
    private var commentView: YZCommentView!
    private var contentLabel: UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        userView = YZUserView(frame: CGRect(x: CONTENTSPACE, y: 0, width: WIDTH - 4 * CONTENTSPACE, height: USERVIEWHEIGHT))
        backView.addSubview(userView)
        
        contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: USERTEXTMAINLABELFONT)
        backView.addSubview(contentLabel)
        
        commentView = YZCommentView(frame: CGRectZero)
        backView.addSubview(commentView)
    }
    
    public func configureCell(_ videoFrame: YZContentVideoFrame) {
        let group = videoFrame.contentModel.group
        if let url = group?.mp4_url {
            shareURL = url
        }
        shareTitle = group?.text
        
        userView.configureUserView(group!.user!.avatar_url!, name: group!.user!.name!, time: dateString(group!.create_time!.intValue))
        contentLabel.text = group?.text
        mainImageView.yz_setImage(group!.large_cover!.url_list![0]["url"]!)
        ///
        contentLabel.frame  = videoFrame.contentLabelFrame
        videoViewFrame = videoFrame.mainIVFrame
        commentView.frame   = videoFrame.commentViewFrame
        backView.frame      = videoFrame.backViewFrame
    
        guard let comments = videoFrame.contentModel.comments, comments.count > 0 else {
            return
        }
        commentView.configureCommentView(comments[0])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
