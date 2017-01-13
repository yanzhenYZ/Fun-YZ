//
//  YZNEWebViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/4.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZNEWebViewController: YZWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func jsString() -> String {
        var js = ""
        if ISIPAD {
            js = js + "var yzHeader = document.getElementsByClassName('header')[0];"
            js = js + "yzHeader.parentNode.removeChild(yzHeader);"
            js = js + "var yzAside = document.getElementsByClassName('aside')[0];"
            js = js + "yzAside.parentNode.removeChild(yzAside);"
        }else{
            ///删除顶部
            js = js + "var yzTopbar = document.getElementsByClassName('topbar')[0];"
            js = js + "yzTopbar.parentNode.removeChild(yzTopbar);"
            ///删除广告
            js = js + "var box = document.getElementsByClassName('a_adtemp a_topad js-topad')[0];"
            js = js + "box.parentNode.removeChild(box);"
            ///
            js = js + "var buyNow = document.getElementsByClassName('more_client more-client')[0];"
            js = js + "buyNow.parentNode.removeChild(buyNow);"
            ///广告
            js = js + "var yzTB = document.getElementsByClassName('a_adtemp a_tbad js-tbad')[0];"
            js = js + "yzTB.parentNode.removeChild(yzTB);"
        }
        return js
    }

}
