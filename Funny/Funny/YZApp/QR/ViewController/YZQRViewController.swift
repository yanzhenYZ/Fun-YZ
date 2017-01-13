//
//  YZQRViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/5.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZQRViewController: YZSuperViewController {

    private var qrMakeVC: YZQRMakeViewController!
    private var qrScanVC: YZQRScanViewController!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        let segment = UISegmentedControl(items: ["扫描二维码","生成二维码"])
        segment.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        segment.addTarget(self, action: #selector(self.segmentValueChanged(_:)), for: .valueChanged)
        segment.selectedSegmentIndex = 0
        self.navigationItem.titleView = segment
        
        qrScanVC = YZQRScanViewController()
        qrMakeVC = YZQRMakeViewController()
        qrMakeVC.view.frame = CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT)
        qrScanVC.view.frame = qrMakeVC.view.frame
        self.addChildViewController(qrScanVC)
        self.addChildViewController(qrMakeVC)
        self.view.addSubview(qrScanVC.view)
        self.view.addSubview(qrMakeVC.view)
        self.view.insertSubview(qrScanVC.view, at: 0)
        self.view.insertSubview(qrMakeVC.view, at: 0)
    }

    @objc private func segmentValueChanged(_ segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 1 {
            UIView.animate(withDuration: 0.25, animations: { 
                self.qrScanVC.view.alpha = 0
            }, completion: { (finished) in
                self.qrMakeVC.view.alpha = 1
            })
        }else{
            UIView.animate(withDuration: 0.25, animations: {
                self.qrMakeVC.view.alpha = 0
            }, completion: { (finished) in
                self.qrScanVC.view.alpha = 1
            })
        }
    }

}
