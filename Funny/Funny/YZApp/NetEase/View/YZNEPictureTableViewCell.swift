//
//  YZNEPictureTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 17/1/4.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZNEPictureTableViewCell: UITableViewCell {

    @IBOutlet private weak var onlyIv: UIImageView!
    @IBOutlet private weak var titleLab: UILabel!
    @IBOutlet private weak var subTitleLab: UILabel!
    func configureCell(_ model: YZNetEaseModel) {
        titleLab.text = model.title
        subTitleLab.text = model.digest
        onlyIv.yz_setImage(model.imgsrc)
    }
    
}
