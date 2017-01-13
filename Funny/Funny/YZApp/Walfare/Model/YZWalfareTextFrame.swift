//
//  YZWalfareTextFrame.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZWalfareTextFrame: YZTextFrame {

    var textModel: YZWalfareTextModel! {
        didSet{
            let viewWidth = WIDTH - CONTENTSPACE * 4
            let contentHeigth = textModel.wbody?.boundingHeight(fontSize: USERTEXTMAINLABELFONT, maxWidth: viewWidth)
            mainLabelFrame = CGRect(x: CONTENTSPACE * 2, y: 25, width: viewWidth, height: contentHeigth!)
            backViewFrame = CGRect(x: CONTENTSPACE, y: CONTENTSPACE / 2 , width: WIDTH - 2 * CONTENTSPACE, height: mainLabelFrame.maxY + 5)
        }
    }
    
}

class YZWalfareTextModel: NSObject {
    ///发布时间
    var update_time: String!
    ///发布内容
    var wbody: String?
}
