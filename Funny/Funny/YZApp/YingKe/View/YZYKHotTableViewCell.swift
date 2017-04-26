//
//  YZYKHotTableViewCell.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZYKHotTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var nickLabel: UILabel!
    @IBOutlet private weak var mainIV: UIImageView!
    @IBOutlet private weak var viewCountLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var headIV: UIImageView!
    
    public func configureCell(_ model: YZYingKeModel) {
        var mainIVURL = model.creator!.portrait
        if !model.creator!.portrait.hasPrefix(YK_ImageURL_Header) {
            mainIVURL = YK_ImageURL_Header + model.creator!.portrait
        }
        mainIV.yz_setImage(mainIVURL!, placeholder: "live_default")
        headIV.yz_setImage(mainIVURL!, placeholder: "default_head")
        nickLabel.text = model.creator!.nick
        viewCountLabel.text = model.online_users
        cityLabel.text = model.city.isEmpty ? "难道在火星" : model.city
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
