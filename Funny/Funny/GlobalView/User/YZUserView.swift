//
//  YZUserView.swift
//  Funny
//
//  Created by yanzhen on 16/12/28.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZUserView: UIView {

    
    private var headImageView: UIImageView!
    private var userNameLabel: UILabel!
    private var createTimeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        headImageView = UIImageView(frame: CGRect(x: 0, y: CONTENTSPACE, width: 50.0, height: 50.0))
        headImageView.contentMode = .scaleAspectFill
        headImageView.clipsToBounds = true
        headImageView.corner()
        addSubview(headImageView)
        ///
        userNameLabel = UILabel(frame: CGRect(x: headImageView.maxX + CONTENTSPACE, y: CONTENTSPACE * 1.5, width: 200, height: 20))
        userNameLabel.font = UIFont.systemFont(ofSize: USERNAMELABELFONT)
        addSubview(userNameLabel)
        ///
        createTimeLabel = UILabel(frame: CGRect(x: userNameLabel.x, y: userNameLabel.maxY + CONTENTSPACE / 2, width: 200, height: 20))
        createTimeLabel.font = UIFont.systemFont(ofSize: CREATTIMELABELFONT)
        addSubview(createTimeLabel)
    }
    
    public func configureUserView(_ headImageUrlString: String, name: String, time: String) {
        headImageView.yz_setImage(headImageUrlString)
        userNameLabel.text   = name
        createTimeLabel.text = time
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
