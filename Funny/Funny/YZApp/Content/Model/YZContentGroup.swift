//
//  YZContentGroup.swift
//  Funny
//
//  Created by yanzhen on 16/12/27.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZContentGroup: NSObject {

    var user: YZContentUser?
    var share_url: String?
    var create_time: NSNumber?
    var duration: NSNumber?
    var text: String?
    var mp4_url: String?
    var category_name: String?
    var large_cover: YZContentLarge_cover?
    var video_720p: YZContent720p_video?
    
}

class YZContentLarge_cover: NSObject {
    ///
    var uri: String?
    ///视频图像---[0][url]
    var url_list: Array<[String : String]>?
}

class YZContent720p_video: NSObject {
    ///视频宽
    var width: NSNumber?
    ///视频高
    var height: NSNumber?
    ///视频地址---[0][url]
    var url_list: Array<[String : String?]>?
}
