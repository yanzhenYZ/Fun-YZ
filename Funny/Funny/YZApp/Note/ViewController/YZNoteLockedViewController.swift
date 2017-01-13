//
//  YZNoteLockedViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/4.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZNoteLockedViewController: YZSuperViewController, YZLockedViewDelegate{

    @IBOutlet private weak var lockView: YZLockedView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Note"
        lockView.delegate = self
        YZFunnyManager.authentication(failed: nil) { [weak self] in
            self?.intoNextVC()
        }
    }
    
    private func intoNextVC() {
        let vc = YZNoteViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//MARK: - YZLockedViewDelegate
    func passwordIsRight(password: String) -> Bool {
        if password == YZUserDefaultsManager.getNotePassword() {
            intoNextVC()
            return true
        }
        return false
    }

}
