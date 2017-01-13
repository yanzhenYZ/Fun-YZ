//
//  YZWalfareGirlTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZWalfareGirlTableViewCell: YZPictureTableViewCell {

    private var creatTimeLabel: UILabel!
    private var contentLabel: UILabel!
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        creatTimeLabel = UILabel(frame: CGRect(x: CONTENTSPACE * 2, y: CONTENTSPACE / 2, width: 200, height: 25))
        creatTimeLabel.font = UIFont.systemFont(ofSize: CREATTIMELABELFONT)
        backView.addSubview(creatTimeLabel)
        ///
        contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: USERTEXTMAINLABELFONT)
        backView.addSubview(contentLabel)
        
    }
    
    public func configureCell(_ girlframe: YZWalfareGirlFrame) {
        creatTimeLabel.text = dateString(Int(girlframe.girlModel.update_time)!)
        contentLabel.text  = girlframe.girlModel.wbody
        mainImageView.yz_setImage(girlframe.girlModel.wpic_middle, placeholderImageString: nil)
        ///
        contentLabel.frame = girlframe.contentLabelFrame
        mainImageView.frame = girlframe.mainIVFrame
        backView.frame = girlframe.backViewFrame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
