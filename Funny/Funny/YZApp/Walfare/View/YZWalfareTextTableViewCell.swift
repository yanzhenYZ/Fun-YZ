//
//  YZWalfareTextTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZWalfareTextTableViewCell: YZTextTableViewCell {

    private var creatTimeLabel: UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        creatTimeLabel = UILabel(frame: CGRect(x: CONTENTSPACE * 2, y: CONTENTSPACE / 2, width: 200, height: 25))
        creatTimeLabel.font = UIFont.systemFont(ofSize: CREATTIMELABELFONT)
        backView.addSubview(creatTimeLabel)
    }
    
    public func configureCell(_ textFrame: YZWalfareTextFrame) {
        creatTimeLabel.text = dateString(Int(textFrame.textModel.update_time)!)
        mainTextLabel.text  = textFrame.textModel.wbody
        ///
        mainTextLabel.frame = textFrame.mainLabelFrame
        backView.frame = textFrame.backViewFrame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
