//
//  YZVideoFrame.swift
//  Funny
//
//  Created by yanzhen on 16/12/27.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZVideoFrame: YZSuperFrame {

    var mainIVFrame: CGRect!
    var playBtnFrame: CGRect {
        get{
            return CGRect(x: mainIVFrame.maxX - 70, y: mainIVFrame.maxY - 62, width: 70, height: 62)
        }
    }
    
    var progressViewFrame: CGRect {
        get{
            return CGRect(x: mainIVFrame.origin.x, y: mainIVFrame.maxY, width: mainIVFrame.size.width, height: 2)
        }
    }
}
