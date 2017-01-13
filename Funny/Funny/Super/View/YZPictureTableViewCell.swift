//
//  YZPictureTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZPictureTableViewCell: YZTableViewCell {

    public var mainImageView: UIImageView!
    public var isCanSave: Bool = true
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainImageView = UIImageView()
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
        mainImageView.isUserInteractionEnabled = true
        backView.addSubview(mainImageView)
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longGestureAction(longGesture:)))
        mainImageView.addGestureRecognizer(longGesture)
    }
    
    @objc private func longGestureAction(longGesture: UILongPressGestureRecognizer) {
        if isCanSave {
            if longGesture.state == .began {
                let imageView = longGesture.view as! UIImageView
                YZFunnyManager.saveImage(imageView.image!)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
