//
//  YZTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 16/12/27.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZTableViewCell: UITableViewCell {

    var backView: UIView!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = UIColor(246, 246, 246)
        backView = UIView(frame: CGRect(x: CONTENTSPACE, y: CONTENTSPACE / 2, width: WIDTH - 2 * CONTENTSPACE, height: 0))
        backView.backgroundColor = UIColor.white
        self.contentView.addSubview(backView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
