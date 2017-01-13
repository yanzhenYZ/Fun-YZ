//
//  YZContentTextTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 16/12/29.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZContentTextTableViewCell: YZTextTableViewCell {

    fileprivate var userView: YZUserView!
    fileprivate var commentView: YZCommentView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        userView = YZUserView(frame: CGRect(x: CONTENTSPACE, y: 0, width: WIDTH - 4 * CONTENTSPACE, height: USERVIEWHEIGHT))
        backView.addSubview(userView)
        
        commentView = YZCommentView(frame: CGRectZero)
        backView.addSubview(commentView)
    }
    
    public func configureCell(textFrame: YZContentTextFrame) {
        let group = textFrame.contentModel.group!
        userView.configureUserView(group.user!.avatar_url!, name: group.user!.name!, time: dateString(group.create_time!.intValue))
        mainTextLabel.text = group.text
        mainTextLabel.frame = textFrame.mainLabelFrame
        commentView.frame = textFrame.commentViewFrame
        backView.frame = textFrame.backViewFrame
        if (textFrame.contentModel.comments?.count)! > 0 {
            let user = textFrame.contentModel.comments![0]
            commentView.configureCommentView(user)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
