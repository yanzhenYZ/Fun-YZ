//
//  YZNEPicturesTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 17/1/4.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZNEPicturesTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLab: UILabel!
    @IBOutlet private weak var leftIV: UIImageView!
    @IBOutlet private weak var middleIV: UIImageView!
    
    @IBOutlet weak var rightIV: UIImageView!
    func configureCell(_ model: YZNetEaseModel) {
        titleLab.text = model.title
        leftIV.yz_setImage(model.imgsrc)
        var pictureModel = model.imgextra![0]
        middleIV.yz_setImage(pictureModel.imgsrc)
        pictureModel = model.imgextra![1]
        rightIV.yz_setImage(pictureModel.imgsrc)
    }
    
}
