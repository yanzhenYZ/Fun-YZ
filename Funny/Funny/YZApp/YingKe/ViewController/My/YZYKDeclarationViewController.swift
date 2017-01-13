//
//  YZYKDeclarationViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZYKDeclarationViewController: UIViewController {

    @IBOutlet private weak var declarationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "声明"
        declarationLabel.text = "1.直播数据来自网络\n2.视频播放库-https://github.com/Bilibili/ijkplayer\n3.直播控件-LFLiveKit\n4.rtmp服务器未知(数据不安全)"
    }

    

}
