//
//  YZYingKeModel.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZYingKeModel: NSObject {

    ///所在城市
    var city: String!
    ///直播创建人
    var creator: YZYingKeCreator?
    ///附近的人--距离
    var distance: String!
    ///id
    var ID: String!
//    var ID: NSNumber!
    ///在线人数
    var online_users: String!
    ///直播间id
    var room_id: NSNumber!
    ///分享地址？？
    var share_addr: String!
    ///视频流地址
    var stream_addr: String!
    /// show
    var show: Bool = false
    
}

class YZYingKeCreator: NSObject {
    ///id
    var ID: NSNumber!
    ///等级
    var level: NSNumber!
    ///昵称
    var nick: String!
    ///图片地址
    var portrait: String!
}
