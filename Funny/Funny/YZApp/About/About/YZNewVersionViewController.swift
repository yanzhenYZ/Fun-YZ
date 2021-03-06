//
//  YZNewVersionViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/9.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZNewVersionViewController: UIViewController {

    @IBOutlet private weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = "[1.0.0] 基于Swift3.0-Funny\n[17.03.03] 模仿FaceTime页面\n[17.04.05] Swift3.1\n[17.04.21] 修改YZUIKit\n[17.04.25] Add YZUIKit.YZCircularMenu\n[17.05.02] 修改framework路径\n[17.05.09] 添加自拍App\n[17.05.19] YZPlayer\n[18.04.09] Swift4.1"
    }

    override var previewActionItems: [UIPreviewActionItem] {
        get{
            let action = UIPreviewAction(title: "取消", style: .default) { (previewAction, vc) in
                
            }
            return [action]
        }
    }

}
