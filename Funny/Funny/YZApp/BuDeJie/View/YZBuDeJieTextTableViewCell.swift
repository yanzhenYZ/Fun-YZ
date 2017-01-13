//
//  YZBuDeJieTextTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZBuDeJieTextTableViewCell: YZTextTableViewCell {

    private var userView: YZUserView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        userView = YZUserView(frame: CGRect(x: CONTENTSPACE, y: 0, width: WIDTH - 4 * CONTENTSPACE, height: USERVIEWHEIGHT))
        backView.addSubview(userView)
    }
    
    public func configureCell(_ textFrame: YZBuDeJieTextFrame) {
        userView.configureUserView(textFrame.textModel.profile_image, name: textFrame.textModel.name, time: textFrame.textModel.create_time)
        mainTextLabel.text = textFrame.textModel.text
        mainTextLabel.frame = textFrame.mainLabelFrame
        backView.frame = textFrame.backViewFrame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
