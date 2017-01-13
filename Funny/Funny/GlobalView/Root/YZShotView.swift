//
//  YZShotView.swift
//  Funny
//
//  Created by yanzhen on 16/12/26.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit
import CoreGraphics

protocol YZShotViewDelegate: NSObjectProtocol {
    func shotPart(isShot: Bool, shotFrame frame:CGRect)
}

class YZShotView: UIView {

    weak var delegate: YZShotViewDelegate?
    
    fileprivate var shapeLayer: CAShapeLayer!
    fileprivate var shotRect: CGRect!
    fileprivate var startPoint:CGPoint!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 2
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.gray.withAlphaComponent(0.15).cgColor
        shapeLayer.lineDashPattern = [5,5]
        shotRect = self.bounds.insetBy(dx: 20.0, dy: 150.0);
        shapeLayer.path = CGPath(rect: shotRect, transform: nil)
        self.layer.addSublayer(shapeLayer)
        
        let block = {(view: UIView) ->Void in
            view.cornerRadius  = view.width / 2
            view.borderColor = FunnyColor
            view.borderWidth = 1.0
            view.backgroundColor = UIColor.clear
        }
        
        let cancelBtn = UIButton(type: .custom)
        let btnWH: CGFloat = 30
        let btnY: CGFloat = self.height - btnWH - 10
        cancelBtn.frame = CGRect(x: self.width - 40, y: btnY, width: btnWH, height: btnWH)
        block(cancelBtn)
        cancelBtn.setBackgroundImage(UIImage(named: "closeWindowView"), for: .normal)
        cancelBtn.addTarget(self, action: #selector(self.cancelBtnClick), for: .touchUpInside)
        self.addSubview(cancelBtn)
        
        let sureBtn = UIButton(type: .custom)
        sureBtn.frame = CGRect(x: self.width - 80, y: btnY, width: btnWH, height: btnWH)
        block(sureBtn)
        sureBtn.setTitle("OK", for: .normal)
        sureBtn.setTitleColor(FunnyColor, for: .normal)
        sureBtn.addTarget(self, action: #selector(self.sureBtnClick), for: .touchUpInside)
        self.addSubview(sureBtn)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.panAction(pan:)))
        self.addGestureRecognizer(pan)
    }
    
    @objc fileprivate func cancelBtnClick() {
        delegate?.shotPart(isShot: false, shotFrame: shotRect)
    }
    
    @objc fileprivate func sureBtnClick() {
        delegate?.shotPart(isShot: true, shotFrame: shotRect)
    }
    
    @objc fileprivate func panAction(pan: UIPanGestureRecognizer) {
        if pan.state == UIGestureRecognizerState.began {
            shapeLayer.path = nil
            startPoint = pan.location(in: self)
            if startPoint.x <= 20 {
                startPoint.x = 0
            }
        }else if pan.state == UIGestureRecognizerState.changed {
            let currentPoint = pan.location(in: self)
            let x: CGFloat = startPoint.x;
            let y: CGFloat = startPoint.y;
            shotRect = CGRect(x: x, y: y, width: CGFloat(currentPoint.x) - x, height: CGFloat(currentPoint.y) - y);
            let path=CGPath(rect: shotRect!, transform: nil);
            shapeLayer?.path=path;
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
