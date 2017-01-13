//
//  YZTextTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 16/12/29.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZTextTableViewCell: YZTableViewCell {

    public var mainTextLabel: UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainTextLabel = UILabel()
        mainTextLabel.font = UIFont.systemFont(ofSize: USERTEXTMAINLABELFONT)
        mainTextLabel.numberOfLines = 0
        backView.addSubview(mainTextLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
