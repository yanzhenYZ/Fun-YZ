//
//  YZVideoWindow.swift
//  Funny
//
//  Created by yanzhen on 16/12/29.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZVideoWindow: UIWindow {

    private weak var videoView: UIView?
    private var beginPoint: CGPoint!
    private var scale: CGFloat = 1.0
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        let pin = UIPinchGestureRecognizer(target: self, action: #selector(self.pinGestureAction(pin:)))
        self.addGestureRecognizer(pin)
    }
    
    public func makeWindowView(_ view: UIView) {
        if videoView == view {
            return
        }
        videoView = view
        self.frame = view.frame
        if subviews.count > 0 {
            for (_,value) in subviews.enumerated() {
                value.removeFromSuperview()
            }
        }
        addSubview(view)
    }
    
    @objc private func pinGestureAction(pin: UIPinchGestureRecognizer) {
        scale = pin.scale
        if scale > 1.0 {
            if self.width * scale > WIDTH {
                scale = WIDTH / self.width
            }
        }else{
            if self.width * scale < 200 {
                scale = 200 / self.width
            }
        }
        self.transform = self.transform.scaledBy(x: scale, y: scale)
        pin.scale = 1.0
        if pin.state == .ended {
            resetFrame()
        }
    }
    
    private func resetFrame() {
        var cX = self.centerX
        var cY = self.centerY
        if cX < self.width / 2 {
            cX = self.width / 2
        }else if cX > WIDTH - self.width / 2 {
            cX = WIDTH - self.width / 2
        }
        ///
        if cY < self.height / 2 {
            cY = self.height / 2
        }else if cY > HEIGHT - self.height / 2 {
            cY = HEIGHT - self.height / 2
        }
        
        UIView.animate(withDuration: 0.25) { 
            self.center = CGPoint(x: cX, y: cY)
        }
    }
//MARK: Touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         beginPoint = ((touches as NSSet).anyObject()! as! UITouch).location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let nowPoint = ((touches as NSSet).anyObject()! as! UITouch).location(in: self)
        let offsetX = nowPoint.x - beginPoint.x
        let offsetY = nowPoint.y - beginPoint.y
        let centerX = self.centerX + offsetX
        let centerY = self.centerY + offsetY
        self.center = CGPoint(x: centerX, y: centerY)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetFrame()
    }
    
//MARK: super
    override func layoutSubviews() {
        super.layoutSubviews()
        videoView?.frame = self.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
