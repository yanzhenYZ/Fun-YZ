//
//  YZWalfareVideoFrame.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZWalfareVideoFrame: YZVideoFrame {

    var contentLabelFrame: CGRect!
    var videoModel: YZWalfareVideoModel! {
        didSet{
            let viewWidth = WIDTH - CONTENTSPACE * 4
            var rect = CGRect(x: CONTENTSPACE * 2, y: 25, width: viewWidth, height: 0)
            if videoModel.wbody~~ {
                rect.size.height = videoModel.wbody!.boundingHeight(fontSize: USERTEXTMAINLABELFONT, maxWidth: viewWidth) + CONTENTSPACE
            }
            contentLabelFrame = rect
            mainIVFrame = CGRect(x: CONTENTSPACE * 2, y: rect.maxY, width: viewWidth, height: viewWidth * 3 / 4)
            backViewFrame = CGRect(x: CONTENTSPACE, y: CONTENTSPACE / 2 , width: WIDTH - 2 * CONTENTSPACE, height: mainIVFrame.maxY + 7)
        }
    }
    
}

class YZWalfareVideoModel: YZWalfareTextModel {
    ///图片地址
    var vpic_small: String!
    ///播放地址
    var vplay_url: String!
    var vsource_url: String!
}
