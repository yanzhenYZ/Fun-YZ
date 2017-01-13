//
//  YZContentTextFrame.swift
//  Funny
//
//  Created by yanzhen on 16/12/27.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZContentTextFrame: YZTextFrame {

    var commentViewFrame: CGRect!
    var contentModel: YZContentModel! {
        didSet{
            let group = contentModel.group!
            let viewWidth = WIDTH - 4 * CONTENTSPACE
            let textHeight = group.text?.boundingHeight(fontSize: USERTEXTMAINLABELFONT, maxWidth: viewWidth)
            mainLabelFrame = CGRect(x: CONTENTSPACE, y: USERVIEWHEIGHT - CONTENTSPACE / 2, width: viewWidth, height: textHeight!)
            ///
            commentViewFrame = CGRect(x: CONTENTSPACE, y: mainLabelFrame.maxY + CONTENTSPACE, width: viewWidth, height: 0)
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
