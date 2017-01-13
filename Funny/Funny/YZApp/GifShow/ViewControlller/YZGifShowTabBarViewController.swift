//
//  YZGifShowTabBarViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZGifShowTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = YZGifShowViewController()
        vc1.title = "快手"
        let nvc1 = UINavigationController(rootViewController: vc1)
        nvc1.tabBarItem.image = UIImage(named: "weibo_music_u")
        nvc1.tabBarItem.selectedImage = UIImage(named: "weibo_music_s")
        
        let vc2 = YZWhatSomeViewController()
        vc2.title = "图片"
        vc2.pullHeaderStr = SomeWhatPullHeadURL
        vc2.pullFooterStr = SomeWhatDefaultFootURL
        vc2.pushHeaderStr = SomeWhatPushHeadURL
        vc2.pushFooterStr = SomeWhatDefaultFootURL
        let nvc2 = UINavigationController(rootViewController: vc2)
        nvc2.tabBarItem.image = UIImage(named: "weibo_favorite_u")
        nvc2.tabBarItem.selectedImage = UIImage(named: "weibo_favorite_s")
        self.viewControllers = [nvc1,nvc2]
    }

}
