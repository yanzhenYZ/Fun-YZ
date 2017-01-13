//
//  YZNoteModel.swift
//  Funny
//
//  Created by yanzhen on 17/1/5.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZNoteModel: NSObject {

    var title: String!
    var time: Int!
    var animated: Bool = false
    init(noteTitle: String, noteTime: Int) {
        super.init()
        title = noteTitle
        time  = noteTime
    }
}
