//
//  YZBuDeJieVideoFrame.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZBuDeJieVideoFrame: YZVideoFrame {

    var contentLabelFrame: CGRect!
    var videoModel: YZBuDeJieVideoModel!
    init(_ model: YZBuDeJieVideoModel) {
        super.init()
        self.videoModel = model
        let viewWidth = WIDTH - 4 * CONTENTSPACE
        var rect = CGRect(x: CONTENTSPACE, y: USERVIEWHEIGHT - CONTENTSPACE / 2, width: viewWidth, height: 0)
        if videoModel.text~~ {
            rect.size.height = videoModel.text!.boundingHeight(fontSize: USERTEXTMAINLABELFONT, maxWidth: viewWidth) + CONTENTSPACE / 2
        }
        contentLabelFrame = rect
        ///
        var originW = Int(videoModel.width)
        originW = originW == 0 ? 1 : originW
        let originH = Int(videoModel.height)
        let scale = viewWidth / CGFloat(originW!)
        let imageH = CGFloat(originH!) * scale
        mainIVFrame = CGRect(x: CONTENTSPACE, y: rect.maxY, width: viewWidth, height: imageH)
        backViewFrame = CGRect(x: CONTENTSPACE, y: CONTENTSPACE / 2, width: WIDTH - 2 * CONTENTSPACE, height: mainIVFrame.maxY + 7)
    }
//    var videoModel: YZBuDeJieVideoModel! {
//        didSet{
//            let viewWidth = WIDTH - 4 * CONTENTSPACE
//            var rect = CGRect(x: CONTENTSPACE, y: USERVIEWHEIGHT - CONTENTSPACE / 2, width: viewWidth, height: 0)
//            if videoModel.text~~ {
//                rect.size.height = videoModel.text!.boundingHeight(fontSize: USERTEXTMAINLABELFONT, maxWidth: viewWidth) + CONTENTSPACE / 2
//            }
//            contentLabelFrame = rect
//            ///
//            var originW = Int(videoModel.width)
//            originW = originW == 0 ? 1 : originW
//            let originH = Int(videoModel.height)
//            let scale = viewWidth / CGFloat(originW!)
//            let imageH = CGFloat(originH!) * scale
//            mainIVFrame = CGRect(x: CONTENTSPACE, y: rect.maxY, width: viewWidth, height: imageH)
//            backViewFrame = CGRect(x: CONTENTSPACE, y: CONTENTSPACE / 2, width: WIDTH - 2 * CONTENTSPACE, height: mainIVFrame.maxY + 7)
//        }
//    }
}

//可以作为textModel
class YZBuDeJieVideoModel: YZBuDeJieTextModel {
    ///视频封面
    var bimageuri: String!
    ///视频高度
    var height: String!
    ///视频宽度
    var width: String!
    ///视频地址
    var videouri: String!
}
