//
//  YZRootFirstViewController.swift
//  Funny
//
//  Created by yanzhen on 16/12/23.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit
import YZUIKit

class YZRootFirstViewController: UIViewController {

    private var transition: YZTransition!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let images = [#imageLiteral(resourceName: "content"),#imageLiteral(resourceName: "gifShow"),#imageLiteral(resourceName: "budejie"),#imageLiteral(resourceName: "walfare"),#imageLiteral(resourceName: "uc"),#imageLiteral(resourceName: "netease"),#imageLiteral(resourceName: "yingke")]
        let titles = ["内涵段子","快手","不得姐","福利社","UC新闻","网易新闻","直播"]
        let IconWidth: CGFloat = 60
        let IconHeight: CGFloat = 90
        for (index,value) in images.enumerated() {
            let row = index % 4
            let col = index / 4
            let spaceX = (WIDTH - IconWidth * 4) / 5
            let btn = YZIconButton(type: .custom)
            btn.frame = CGRect(x: spaceX + (spaceX + IconWidth) * CGFloat(row), y: 30 + (IconHeight + 20) * CGFloat(col), width: IconWidth, height: IconHeight)
            btn.tag = YZAPPNAME.Content.rawValue + index
            btn.setImage(value, for: .normal)
            btn.setTitle(titles[index], for: .normal)
            btn.addTarget(self, action: #selector(self.selectedApp(btn:)), for: .touchUpInside)
            self.view.addSubview(btn)
        }
        transition = YZTransition()
        transition.type = .custom
        
    }

    @objc private func selectedApp(btn: YZIconButton) {
        widgetIntoViewController(btn.tag)
    }

    public func widgetIntoViewController(_ tag: NSInteger) {
        let vcClass = NSClassFromString(FunnyApp[tag]!) as! UIViewController.Type
        let vc = vcClass.init()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = transition
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}
