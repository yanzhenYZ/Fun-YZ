//
//  YZSuperFrame.swift
//  Funny
//
//  Created by yanzhen on 16/12/27.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZSuperFrame: NSObject {

    var backViewFrame: CGRect!
    var rowHeight: CGFloat! {
        get{
             return backViewFrame.maxY + CONTENTSPACE / 2
        }
    }
}
