//
//  YZContentModel.swift
//  Funny
//
//  Created by yanzhen on 16/12/27.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZContentModel: NSObject {

    var group: YZContentGroup?
    var comments: Array<YZContentUser>?

    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["comments" : YZContentUser.self]
    }
}
