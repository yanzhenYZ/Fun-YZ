//
//  YZWhatSomeGroup.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZWhatSomeGroup: NSObject {

    var user: YZContentUser?
    var share_url: String?
    var create_time: NSNumber?
    var text: String?
    var middle_image: YZWhatSomeMiddle_image?
}

class YZWhatSomeMiddle_image: NSObject {
    var r_height: NSNumber?
    var r_width: NSNumber?
    var url_list: Array<[String : String]>?
}
