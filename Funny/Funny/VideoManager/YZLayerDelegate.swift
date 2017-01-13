//
//  YZLayerDelegate.swift
//  Funny
//
//  Created by yanzhen on 16/12/29.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZLayerDelegate: NSObject, CALayerDelegate {

    public var rightSpace: CGFloat = 90
    public var left: Bool = false
    
    func draw(_ layer: CALayer, in ctx: CGContext) {
        UIGraphicsPushContext(ctx)
        let x = WIDTH - rightSpace
        let attributes = [NSForegroundColorAttributeName : FunnyColor, NSFontAttributeName : UIFont(name: "IowanOldStyle-BoldItalic", size: 18)]
        let tv: NSString = "Y&Z TV"
        if left {
            tv.draw(in: CGRect(x: 5, y: 5, width: 120, height: 40), withAttributes: attributes)
        }else{
            tv.draw(in: CGRect(x: x, y: 0, width: 120, height: 40), withAttributes: attributes)
        }
        
        UIGraphicsPopContext()
    }
}
