//
//  YZClipImageMaskView.swift
//  Funny
//
//  Created by yanzhen on 17/1/7.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZClipImageMaskView: UIView {

    init(frame: CGRect, clipFrame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = false
        createMaskLayer(clipFrame)
        ///边框
        let view = UIView(frame: clipFrame)
        view.backgroundColor = UIColor.clear
        view.layer.borderWidth = 1.0
        view.layer.borderColor = FunnyColor.cgColor
        addSubview(view)
    }
    
    private func createMaskLayer(_ clipFrame: CGRect) {
        let maskLayer = creatMaskLayer(exceptRect: clipFrame)
        maskLayer.fillColor = UIColor(white: 0, alpha: 0.5).cgColor
        self.layer.addSublayer(maskLayer)
    }
    
    private func creatMaskLayer(exceptRect: CGRect) ->CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        let exceptX = exceptRect.origin.x
        let exceptY = exceptRect.origin.y
        let exceptW = exceptRect.size.width
        let exceptH = exceptRect.size.height
        
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.width, height: exceptY))
        path.append(UIBezierPath(rect: CGRect(x: 0, y: exceptY, width: exceptX, height: exceptH)))
        path.append(UIBezierPath(rect: CGRect(x: 0, y: exceptY + exceptH, width: self.width, height: exceptY)))
        path.append(UIBezierPath(rect: CGRect(x: exceptX + exceptW, y: exceptY, width: exceptX, height: exceptH)))
        shapeLayer.path = path.cgPath
        return shapeLayer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
