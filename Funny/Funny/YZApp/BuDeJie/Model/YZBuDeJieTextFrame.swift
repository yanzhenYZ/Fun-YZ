//
//  YZBuDeJieTextFrame.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZBuDeJieTextFrame: YZTextFrame {

    var textModel: YZBuDeJieTextModel!
    init(_ model: YZBuDeJieTextModel) {
        super.init()
        self.textModel = model
        let viewWidth = WIDTH - 4 * CONTENTSPACE
        let textHeight = textModel.text?.boundingHeight(fontSize: USERTEXTMAINLABELFONT, maxWidth: viewWidth)
        mainLabelFrame = CGRect(x: CONTENTSPACE, y: USERVIEWHEIGHT - CONTENTSPACE / 2, width: viewWidth, height: textHeight!)
        backViewFrame = CGRect(x: CONTENTSPACE, y: CONTENTSPACE / 2, width: WIDTH - CONTENTSPACE * 2, height: mainLabelFrame.maxY + 5)
    }
}

class YZBuDeJieTextModel: NSObject {
    ///头像地址
    var profile_image: String!
    ///用户名称
    var name: String!
    ///发布时间
    var create_time: String!
    ///段子内容
    var text: String?
    ///webView网址
    var weixin_url: String!
}
