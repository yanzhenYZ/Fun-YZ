//
//  YZQRScanViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/5.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit
import YZUIKit

class YZQRScanViewController: UIViewController {

    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var openURLBtn: UIButton!
    private var transition: YZTransition!
    override func viewDidLoad() {
        super.viewDidLoad()

        transition = YZTransition()
        transition.type = .fromTop
    }

    public func scanningDone(_ string: String) {
        textView.isHidden = false
        textView.text = string
        openURLBtn.isHidden = !string.isURL
    }
    
    @IBAction func scanQR(_ sender: UIButton) {
        textView.text = ""
        openURLBtn.isHidden = true
        let vc = YZQRScanningViewController(touch3D: false)
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = transition
        vc.scanVC = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func openURL(_ sender: UIButton) {
        if textView.text.isEmpty {
            return
        }
        UIApplication.shared.open(URL(string: textView.text)!, options: [:], completionHandler: nil)
    }

}
