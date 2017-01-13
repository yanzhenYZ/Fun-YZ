//
//  YZUCTabBarViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZUCTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let block = { (model: YZNVCModel) ->UINavigationController in
            let vc = model.vc as! YZUCViewController
            vc.title = model.title
            vc.headerURL = model.otherStrs[0]
            vc.middleURL = model.otherStrs[1]
            vc.footerURL = model.otherStrs[2]
            let nvc = UINavigationController(rootViewController: vc)
            nvc.tabBarItem.image = UIImage(named: model.imageNameHeader + "_u")
            nvc.tabBarItem.selectedImage = UIImage(named: model.imageNameHeader + "_s")
            return nvc
        }
        
        let model = YZNVCModel()
        model.vc = YZUCViewController()
        model.title = "推荐"
        model.imageNameHeader = "weibo_home"
        model.otherStrs = [UCNewsRecommendHeadURL,UCNewsRecommendMiddleURL,UCNewsRecommendFootURL]
        let nvc1 = block(model)
        ///
        model.vc = YZUCViewController()
        model.title = "NBA"
        model.imageNameHeader = "weibo_compose"
        model.otherStrs = [UCNewsNBAHeadURL,UCNewsNBAMiddleURL,UCNewsNBAFootURL]
        let nvc2 = block(model)
        ///
        model.vc = YZUCViewController()
        model.title = "娱乐"
        model.imageNameHeader = "weibo_music"
        model.otherStrs = [UCNewsPlayHeadURL,UCNewsPlayMiddleURL,UCNewsPlayFootURL]
        let nvc3 = block(model)
        ///
        model.vc = YZUCViewController()
        model.title = "社会"
        model.imageNameHeader = "weibo_message"
        model.otherStrs = [UCNewsSocialHeadURL,UCNewsSocialMiddleURL,UCNewsSocialFootURL]
        let nvc4 = block(model)
        ///
        model.vc = YZUCViewController()
        model.title = "搞笑"
        model.imageNameHeader = "weibo_favorite"
        model.otherStrs = [UCNewsFunnyHeadURL,UCNewsFunnyMiddleURL,UCNewsFunnyFootURL]
        let nvc5 = block(model)
        self.viewControllers = [nvc1,nvc2,nvc3,nvc4,nvc5]
    }

    

}
