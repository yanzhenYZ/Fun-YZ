//
//  YZDeclartionViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/9.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZDeclartionViewController: UIViewController {

    @IBOutlet private weak var declarationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "声明"
        declarationLabel.text = "This app based on Swift3.0.I use a lot of network resources, and this app is just for personal use, and does not for any commercial use。\n\nApp主要适用于 iPhone 6、iPhone 6s、iPhone 7，其他设备可能存在问题。"
    }

    

}
