//
//  YZUCPicturesTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 17/1/4.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZUCPicturesTableViewCell: UITableViewCell {

    
    @IBOutlet private weak var titleLab: UILabel!
    @IBOutlet private weak var subTitleLab: UILabel!
    @IBOutlet private weak var leftIV: UIImageView!
    @IBOutlet private weak var middleIV: UIImageView!
    @IBOutlet private weak var rightIV: UIImageView!
    public func configureCell(_ model: YZUCNewsModel) {
        titleLab.text = model.title
        let time = model.publish_time.intValue / 1000
        subTitleLab.text = dateString(time) + "    " + model.origin_src_name
        
        var pictureModel = model.thumbnails![0]
        leftIV.yz_setImage(pictureModel.url, placeholderImageString: nil)
        pictureModel = model.thumbnails![1]
        middleIV.yz_setImage(pictureModel.url, placeholderImageString: nil)
        pictureModel = model.thumbnails![2]
        rightIV.yz_setImage(pictureModel.url, placeholderImageString: nil)
        
    }
    
}
