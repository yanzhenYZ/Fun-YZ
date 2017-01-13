//
//  YZPresentationController.swift
//  Funny
//
//  Created by yanzhen on 16/12/23.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZPresentationController: UIPresentationController, UIViewControllerTransitioningDelegate {

    override func presentationTransitionWillBegin() {
        self.presentedView?.frame = self.containerView!.bounds
        self.containerView?.addSubview(self.presentedView!)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        self.presentedView?.removeFromSuperview()
    }
}
