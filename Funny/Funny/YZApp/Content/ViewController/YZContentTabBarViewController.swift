//
//  YZContentTabBarViewController.swift
//  Funny
//
//  Created by yanzhen on 16/12/26.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZContentTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let block = {(model: YZNVCModel) ->UINavigationController in
            let vc = model.vc as! YZContentSuperViewController
            vc.pullHeaderStr = model.otherStrs[0];
            vc.pullFooterStr = model.otherStrs[1];
            vc.pushHeaderStr = model.otherStrs[2];
            vc.pushFooterStr = model.otherStrs[3];
            vc.title = model.title
            let nvc = UINavigationController(rootViewController: vc)
            let uImage = UIImage(named: model.imageNameHeader + "_u")
            let sImage = UIImage(named: model.imageNameHeader + "_s")
            nvc.tabBarItem.image = uImage
            nvc.tabBarItem.selectedImage = sImage
            return nvc
        }
        let model = YZNVCModel()
        model.vc = YZContentRecommendViewController()
        model.title = "推荐"
        model.imageNameHeader = "weibo_home"
        model.otherStrs = [ContentRecommendMaxHeadURL,ContentRecommendMaxFootURL,ContentRecommendMinHeadURL,ContentRecommendMinFootURL]
        let nvc1 = block(model)
        
        model.vc = YZContentTextViewController()
        model.title = "段子"
        model.imageNameHeader = "weibo_compose"
        model.otherStrs = [ContextTextHeadURL,ContextTextTailUrl,ConTentTextFooterURL,ContentTextTailerURL]
        let nvc2 = block(model)
        
        model.vc = YZContentVideoViewController()
        model.title = "视频"
        model.imageNameHeader = "weibo_music"
        model.otherStrs = [ContentVideoMaxHeadURL,ContentVideoMaxFootURL,ContentVideoMinHeadURL,ContentVideoMinFootURL]
        let nvc3 = block(model)
        self.viewControllers = [nvc1,nvc2,nvc3]
        
    }

}
