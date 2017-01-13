//
//  YZContentWebViewController.swift
//  Funny
//
//  Created by yanzhen on 16/12/29.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZContentWebViewController: YZWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func jsString() -> String {
        var js = "var openNow = document.getElementsByClassName('banner-warpper')[0];"
        js = js + "var openNow1 = document.getElementsByClassName('banner-warpper')[1];"
        js = js + "var topBar = openNow.parentNode;"
        js = js + "topBar.parentNode.removeChild(topBar);"
        js = js + "var bottomBar = openNow1.parentNode;"
        js = js + "bottomBar.parentNode.removeChild(bottomBar);"
        ///
        js = js + "var yzMCClass = document.getElementsByClassName('more-comment')[0];"
        js = js + "var yzMCClassParent = yzMCClass.parentNode;"
        js = js + "yzMCClassParent.parentNode.removeChild(yzMCClassParent);"
        return js
    }

}
