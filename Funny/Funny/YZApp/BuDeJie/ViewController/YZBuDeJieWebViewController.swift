//
//  YZBuDeJieWebViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZBuDeJieWebViewController: YZWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func jsString() -> String {
        var js = ""
        if ISIPAD {
            js = "var topBar = document.getElementsByClassName('nav-new')[0];"
        }else{
            js = "var topBar = document.getElementsByClassName('bar bar-header')[0];"
        }
        js = js + "topBar.parentNode.removeChild(topBar);"
        return js
    }

}
