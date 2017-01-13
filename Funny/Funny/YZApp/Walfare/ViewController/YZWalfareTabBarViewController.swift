//
//  YZWalfareTabBarViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZWalfareTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let block = { (model: YZNVCModel) ->UINavigationController in
            let vc = model.vc as! YZWalfareViewController
            vc.title = model.title
            vc.defaultURL    = model.otherStrs[0]
            vc.pullHeaderURL = model.otherStrs[1]
            vc.pushHeaderURL = model.otherStrs[2]
            let nvc = UINavigationController(rootViewController: vc)
            nvc.tabBarItem.image = UIImage(named: model.imageNameHeader + "_u")
            nvc.tabBarItem.selectedImage = UIImage(named: model.imageNameHeader + "_s")
            return nvc
        }
        let model = YZNVCModel()
        model.vc = YZWalfareVideoViewController()
        model.otherStrs = [WalfareVideoDefaultURL,WalfareVideoPullHeadURL,WalfareVideoPushHeadURL]
        model.title = "视频"
        model.imageNameHeader = "weibo_music"
        let nvc1 = block(model)
        ///
        model.vc = YZWalfareTextViewController()
        model.otherStrs = [WalfareTextDefaultURL,WalfareTextPullHeadURL,WalfareTextPushHeadURL]
        model.title = "段子"
        model.imageNameHeader = "weibo_compose"
        let nvc2 = block(model)
        ///
        model.vc = YZWalfareGirlViewController()
        model.otherStrs = [WalfareGirlDefaultURL,WalfareGirlPullHeadURL,WalfareGirlPushHeadURL]
        model.title = "美女"
        model.imageNameHeader = "weibo_favorite"
        let nvc3 = block(model)
        self.viewControllers = [nvc1,nvc2,nvc3]
    }

}
