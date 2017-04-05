//
//  YZIconButton.swift
//  Funny
//
//  Created by yanzhen on 16/12/23.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZIconButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView?.layer.masksToBounds = true
        self.imageView?.layer.cornerRadius = 12
        self.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        self.titleLabel?.textAlignment = .center
        self.setTitleColor(UIColor.white, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame  = CGRect(x: 0, y: 0, width: self.width, height: self.width)
        self.titleLabel?.frame = CGRect(x: 0, y: self.width + 5, width: self.width, height: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
