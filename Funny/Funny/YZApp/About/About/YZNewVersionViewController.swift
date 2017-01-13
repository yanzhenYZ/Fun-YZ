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

        textView.text = "1.0.0基于Swift3.0-Funny"
    }

    override var previewActionItems: [UIPreviewActionItem] {
        get{
            let action = UIPreviewAction(title: "取消", style: .default) { (previewAction, vc) in
                
            }
            return [action]
        }
    }

}
