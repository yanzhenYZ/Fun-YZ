//
//  YZCommentView.swift
//  Funny
//
//  Created by yanzhen on 16/12/28.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZCommentView: UIView {

    private var headImageView: UIImageView!
    private var userNameLabel: UILabel!
    private var userTextLabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = YZColor(246, 246, 256)
        self.clipsToBounds = true
        ///
        let tipLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 37, height: 18))
        tipLabel.backgroundColor = YZColor(251, 95, 136)
        tipLabel.textAlignment = .center
        tipLabel.textColor = UIColor.white
        tipLabel.font = UIFont.systemFont(ofSize: 12)
        tipLabel.text = "神评论"
        self.addSubview(tipLabel)
        ///
        headImageView = UIImageView(frame: CGRect(x: 10, y: 25, width: 25, height: 25))
        headImageView.contentMode = .scaleAspectFill
        headImageView.clipsToBounds = true
        headImageView.corner()
        self.addSubview(headImageView)
        ///
        userNameLabel = UILabel(frame: CGRect(x: 40.0, y: headImageView.y, width: 200.0, height: headImageView.height))
        userNameLabel.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(userNameLabel)
        ///
        userTextLabel = UILabel(frame: CGRect(x: 40.0, y: 55, width: WIDTH - 70, height: 0))
        userTextLabel.numberOfLines = 0
        userTextLabel.font = UIFont.systemFont(ofSize: OTHERUSERTEXTLABELFONT)
        self.addSubview(userTextLabel)
    }
    
    public func configureCommentView(_ user: YZContentUser) {
        headImageView.yz_setImage(user.avatar_url!)
        userNameLabel.text = user.user_name
        userTextLabel.text = user.text
        userTextLabel.height = self.height - COMMENTVIEWSPACE
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
