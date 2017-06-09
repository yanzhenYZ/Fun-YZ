//
//  YZWhatSomeFrame.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZWhatSomeFrame: YZPictureFrame {

    var contentLabelFrame: CGRect!
    public var model: YZWhatSomeModel!
    init(_ someModel: YZWhatSomeModel) {
        super.init()
        self.model = someModel
        
        let group = model.group!
        let viewWidth = WIDTH - 4 * CONTENTSPACE
        var rect = CGRect(x: CONTENTSPACE, y: USERVIEWHEIGHT - CONTENTSPACE / 2, width: viewWidth, height: 0)
        if group.text~~ {
            rect.size.height = group.text!.boundingHeight(fontSize: USERTEXTMAINLABELFONT, maxWidth: viewWidth) + CONTENTSPACE / 2
        }
        contentLabelFrame = rect
        ///
        var originW = group.middle_image!.r_width!.intValue
        originW = originW == 0 ? 1 : originW
        let originH = group.middle_image!.r_height!.intValue
        let scale = viewWidth / CGFloat(originW)
        let imageH = CGFloat(originH) * scale
        mainIVFrame = CGRect(x: CONTENTSPACE, y: rect.maxY, width: viewWidth, height: imageH)
        backViewFrame = CGRect(x: CONTENTSPACE, y: CONTENTSPACE / 2 , width: WIDTH - 2 * CONTENTSPACE, height: mainIVFrame.maxY + 5)
    }
}

class YZWhatSomeModel: NSObject {
    var group: YZWhatSomeGroup?
    var comments: Array<YZContentUser>?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["comments" : YZContentUser.self]
    }
}
