//
//  YZBezierPath.swift
//  Funny
//
//  Created by yanzhen on 17/1/4.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZBezierPath: UIBezierPath {

    public var color: UIColor?
    init(pathLineWidth: CGFloat,pathColor: UIColor,startPoint: CGPoint) {
        super.init()
        self.lineWidth = pathLineWidth
        self.color = pathColor
        self.move(to: startPoint)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
