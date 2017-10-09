//
//  YZWalfareGirlFrame.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZWalfareGirlFrame: YZPictureFrame{

    var contentLabelFrame: CGRect!
    var girlModel: YZWalfareGirlModel!
    init(_ model: YZWalfareGirlModel) {
        super.init()
        self.girlModel = model
        let viewWidth = WIDTH - CONTENTSPACE * 4
        var rect = CGRect(x: CONTENTSPACE * 2, y: 25, width: viewWidth, height: 0)
        if (girlModel.wbody?.count)! > 1 {
            rect.size.height = girlModel.wbody!.boundingHeight(fontSize: USERTEXTMAINLABELFONT, maxWidth: viewWidth) + CONTENTSPACE
        }
        contentLabelFrame = rect
        ///
        var originW = Int(girlModel.wpic_m_width)
        originW = originW == 0 ? 1 : originW
        let originH = Int(girlModel.wpic_m_height)
        let scale = viewWidth / CGFloat(originW!)
        let imageH = CGFloat(originH!) * scale
        mainIVFrame = CGRect(x: CONTENTSPACE, y: rect.maxY, width: viewWidth, height: imageH)
        backViewFrame = CGRect(x: CONTENTSPACE, y: CONTENTSPACE / 2 , width: WIDTH - 2 * CONTENTSPACE, height: mainIVFrame.maxY + 5)
    }
}

class YZWalfareGirlModel: YZWalfareTextModel {
    ///图片高度
    var wpic_m_height: String!
    ///图片宽度
    var wpic_m_width: String!
    ///图片地址 
    var wpic_middle: String!
    ///是否是gif
    var is_gif: String!
    
}
