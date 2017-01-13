//
//  YZBuDeJieTabBarViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZBuDeJieTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = YZBuDeJieVideoViewController()
        vc1.title = "视频"
        let nvc1 = UINavigationController(rootViewController: vc1)
        nvc1.tabBarItem.image = UIImage(named: "weibo_music_u")
        nvc1.tabBarItem.selectedImage = UIImage(named: "weibo_music_s")
        
        let vc2 = YZBuDeJieTextViewController()
        vc2.title = "段子"
        let nvc2 = UINavigationController(rootViewController: vc2)
        nvc2.tabBarItem.image = UIImage(named: "weibo_compose_u")
        nvc2.tabBarItem.selectedImage = UIImage(named: "weibo_compose_s")
        self.viewControllers = [nvc1,nvc2]
    }

    

}
