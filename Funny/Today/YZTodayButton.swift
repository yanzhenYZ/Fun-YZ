//
//  YZTodayButton.swift
//  Funny
//
//  Created by yanzhen on 17/1/12.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZTodayButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView?.layer.masksToBounds = true
        self.imageView?.layer.cornerRadius = 12
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.titleLabel?.textAlignment = .center
        self.setTitleColor(UIColor.black, for: .normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = self.frame.size.width
        self.imageView?.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        self.imageView?.center = CGPoint(x: width * 0.5, y: 37.5)
        self.titleLabel?.frame = CGRect(x: 0, y: 65 + 5, width: width, height: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
