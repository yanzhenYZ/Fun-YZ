//
//  YZNetEaseTabBarViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/4.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZNetEaseTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let block = { (model: YZNVCModel) ->UINavigationController in
            let vc = model.vc as! YZNetEaseViewController
            vc.title = model.title
            vc.defaultURL = model.otherStrs[0]
            vc.pushURL = model.otherStrs[1]
            vc.key = model.otherStrs[2]
            vc.index = Int(model.otherStrs[3])!
            let nvc = UINavigationController(rootViewController: vc)
            nvc.tabBarItem.image = UIImage(named: model.imageNameHeader + "_u")
            nvc.tabBarItem.selectedImage = UIImage(named: model.imageNameHeader + "_s")
            return nvc
        }
        let model = YZNVCModel()
        model.vc = YZNetEaseViewController()
        model.title = "头条"
        model.imageNameHeader = "weibo_home"
        model.otherStrs = [NetEaseHeadLineDefaultURL,NetEaseHeadLinePushURL,"T1348647909107","7"]
        let nvc1 = block(model)
        ///
        model.vc = YZNetEaseViewController()
        model.title = "原创"
        model.imageNameHeader = "weibo_compose"
        model.otherStrs = [NetEaseOriginalDefaultURL,NetEaseOriginalPushURL,"T1370583240249","1"]
        let nvc2 = block(model)
        ///
        model.vc = YZNetEaseViewController()
        model.title = "娱乐"
        model.imageNameHeader = "weibo_message"
        model.otherStrs = [NetEasePlayDefaultURL,NetEasePlayPushURL,"T1348648517839","1"]
        let nvc3 = block(model)
        ///
        model.vc = YZNetEaseViewController()
        model.title = "体育"
        model.imageNameHeader = "weibo_favorite"
        model.otherStrs = [NetEaseSportDefaultURL,NetEaseSportPushURL,"T1348649079062","1"]
        let nvc4 = block(model)
        self.viewControllers = [nvc1,nvc2,nvc3,nvc4]
    }


}
