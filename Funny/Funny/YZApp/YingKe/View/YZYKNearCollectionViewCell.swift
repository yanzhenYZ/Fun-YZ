//
//  YZYKNearCollectionViewCell.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZYKNearCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var mainIV: UIImageView!
    
    var model: YZYingKeModel! {
        didSet{
            var mainIVURL = model.creator!.portrait
            if !model.creator!.portrait.hasPrefix(YK_ImageURL_Header) {
                mainIVURL = YK_ImageURL_Header + model.creator!.portrait
            }
            mainIV.yz_setImage(mainIVURL!, placeholder: "live_default")
            if model.distance.isEmpty {
                addressLabel.text = model.city.isEmpty ? "火星" : model.city
            }else{
                addressLabel.text = "距您--" + model.distance
            }
        }
    }
    
    public func animation() {
        if model.show {
            return
        }
        self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.5) { 
            self.layer.transform = CATransform3DIdentity
        }
        model.show = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
