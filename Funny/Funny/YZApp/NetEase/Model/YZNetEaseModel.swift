//
//  YZNetEaseModel.swift
//  Funny
//
//  Created by yanzhen on 17/1/4.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZNetEaseModel: NSObject {

    ///主标题
    var title: String!
    ///副标题--段子
    var digest: String!
    ///时间
    var ptime: String!
    ///来源
    var source: String!
    ///URL
    var url: String?
    ///源URL
    var url_3w: String!
    ///一张图片的地址
    var imgsrc: String!
    ///其他两张图片的地址
    var imgextra: Array<YZImgsrcModel>?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["imgextra" : YZImgsrcModel.self]
    }
    
}

class YZImgsrcModel: NSObject {
    var imgsrc: String!
}
