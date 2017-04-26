//
//  YZYKTabBarViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZYKTabBarViewController: UITabBarController, YKTabBarDelegate {

    private var tabBarView: YZYKTabBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        let nvc1 = YZYKNavigationViewController(rootViewController: YZYKHomeViewController())
        let nvc2 = YZYKNavigationViewController(rootViewController: YZYKMyTableViewController())
        self.viewControllers = [nvc1,nvc2]
        ///
        tabBarView = YZYKTabBar(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 49))
        tabBarView.delegate = self
        tabBar.addSubview(tabBarView)
    }
//MARK: - YKTabBarDelegate
    func ykTabBarBtnClick(_ type: YKTabBarBtnType) {
        if type == .launch {
            self.present(YZYKLiveViewController(), animated: true, completion: nil)
        }else{
            self.selectedIndex = type.rawValue - YKTabBarBtnType.home.rawValue
        }
    }
    deinit {
        YZLog("tabBar - deinit")
    }

}
