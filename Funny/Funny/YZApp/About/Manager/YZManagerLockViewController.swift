//
//  YZManagerLockViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/9.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZManagerLockViewController: UIViewController, YZLockedViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "管理"
        view.backgroundColor = UIColor(32, 52, 62)
        let lockView = YZLockedView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT))
        lockView.delegate = self
        view.addSubview(lockView)
        YZFunnyManager.authentication(failed: nil) { [weak self] in
                self?.intoNextVC()
        }
    }
    
    
    private func intoNextVC() {
        let vc = YZPasswordManagerTableViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//MARK: - YZLockedViewDelegate
    func passwordIsRight(password: String) -> Bool {
        if password == YZUserDefaultsManager.getManagerPassword() {
            intoNextVC()
            return true
        }
        return false
    }
}
