//
//  YZContentVideoFrame.swift
//  Funny
//
//  Created by yanzhen on 16/12/27.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZContentVideoFrame: YZVideoFrame {

    var contentLabelFrame: CGRect!
    var commentViewFrame: CGRect!
    var contentModel: YZContentModel! {
        didSet{
            let group = contentModel.group!
            let viewWidth = WIDTH - 4 * CONTENTSPACE
            var rect = CGRect(x: CONTENTSPACE, y: USERVIEWHEIGHT - CONTENTSPACE / 2, width: viewWidth, height: 0)
            if group.text != nil {
                rect.size.height = group.text!.boundingHeight(fontSize: USERTEXTMAINLABELFONT, maxWidth: viewWidth) + CONTENTSPACE / 2
            }
            contentLabelFrame = rect
            ///
            var originW = group.video_720p!.width!.intValue
            originW = originW == 0 ? 1 : originW
            let originH = group.video_720p!.height!.intValue
            let scale = viewWidth / CGFloat(originW)
            let imageH = CGFloat(originH) * scale
            mainIVFrame = CGRect(x: CONTENTSPACE, y: rect.maxY, width: viewWidth, height: imageH)
            ///
            commentViewFrame = CGRect(x: CONTENTSPACE, y: mainIVFrame.maxY + CONTENTSPACE + 2, width: viewWidth, height: 0)
            if (contentModel.comments?.count)! > 0 {
                let user = contentModel.comments![0]
                commentViewFrame.size.height = user.text!.boundingHeight(fontSize: OTHERUSERTEXTLABELFONT, maxWidth: WIDTH - 70) + COMMENTVIEWSPACE
                backViewFrame = CGRect(x: CONTENTSPACE, y: CONTENTSPACE / 2 , width: WIDTH - 2 * CONTENTSPACE, height: commentViewFrame.maxY + CONTENTSPACE)
            }else{
                backViewFrame = CGRect(x: CONTENTSPACE, y: CONTENTSPACE / 2 , width: WIDTH - 2 * CONTENTSPACE, height: commentViewFrame.maxY)
            }
        }
    }
}
