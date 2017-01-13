//
//  YZActionSheetItem.swift
//  Funny
//
//  Created by yanzhen on 16/12/26.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZActionSheetItem: NSObject {

    /**     标题     */
    var title: String!
    /**     标题颜色     */
    var titleColor: UIColor?
    /**     标题大小     */
    var titleFont: CGFloat?
    
    init(title: String, titleColor: UIColor?, titleFont: CGFloat?){
        super.init();
        self.title      = title;
        self.titleColor = titleColor;
        self.titleFont  = titleFont;
    }
}
