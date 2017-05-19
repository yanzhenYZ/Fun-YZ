//
//  YZRootSecondViewController.swift
//  Funny
//
//  Created by yanzhen on 16/12/23.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit
import YZUIKit

class YZRootSecondViewController: UIViewController {

    private var transition: YZTransition!
    override func viewDidLoad() {
        super.viewDidLoad()

        let titles = ["画图","记事本","二维码","自拍"]
        let images = ["drawPicture","note","QR","meipai"]
        let IconWidth: CGFloat = 60
        let IconHeight: CGFloat = 90
        for (index,value) in images.enumerated() {
            let row = index % 4
            let col = index / 4
            let spaceX = (WIDTH - IconWidth * 4) / 5
            let btn = YZIconButton(type: .custom)
            btn.frame = CGRect(x: spaceX + (spaceX + IconWidth) * CGFloat(row), y: 30 + (IconHeight + 20) * CGFloat(col), width: IconWidth, height: IconHeight)
            btn.tag = YZAPPNAME.Draw.rawValue + index
            btn.setImage(UIImage(named: value), for: .normal)
            btn.setTitle(titles[index], for: .normal)
            btn.addTarget(self, action: #selector(self.selectedApp(btn:)), for: .touchUpInside)
            self.view.addSubview(btn)
        }
        transition = YZTransition()
        transition.type = .custom
        transition.rotation = Rotation(x: 0, y: 1, z: 0, angle: Double.pi/2)
    }
    
    @objc private func selectedApp(btn: YZIconButton) {
        widgetIntoViewController(btn.tag)
    }

    public func widgetIntoViewController(_ tag: NSInteger) {
        let vcClass = NSClassFromString(FunnyApp[tag]!) as! UIViewController.Type
        let vc = vcClass.init()
        let nvc = UINavigationController(rootViewController: vc)
        nvc.modalPresentationStyle = .custom
        nvc.transitioningDelegate = transition
        self.navigationController?.present(nvc, animated: true, completion: nil)
    }
}
