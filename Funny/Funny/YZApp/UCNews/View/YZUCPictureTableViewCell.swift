//
//  YZUCPictureTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 17/1/4.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZUCPictureTableViewCell: UITableViewCell {

    @IBOutlet private weak var onlyIV: UIImageView!
    @IBOutlet private weak var titleLab: UILabel!
    @IBOutlet private weak var subTitleLab: UILabel!
    
    public func configureCell(_ model: YZUCNewsModel) {
        let pictureModel = model.thumbnails![0]
        onlyIV.yz_setImage(pictureModel.url, placeholderImageString: nil)
        titleLab.text = model.title
        
        let time = model.publish_time.intValue / 1000
        subTitleLab.text = dateString(time) + "    " + model.origin_src_name
    }
    
}
