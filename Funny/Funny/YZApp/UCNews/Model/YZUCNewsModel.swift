//
//  YZUCNewsModel.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZUCNewsModel: NSObject {

    var title: String!
    var url: String!
    var origin_src_name: String!
    var original_url: String!
    var style_type: NSNumber!
    var publish_time: NSNumber!
    var thumbnails: Array<YZUCPictureModel>?
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["thumbnails" : YZUCPictureModel.self]
    }
}

class YZUCPictureModel: NSObject {
    var url: String!
    var type: String!
    var width: NSNumber!
    var height: NSNumber!
}
