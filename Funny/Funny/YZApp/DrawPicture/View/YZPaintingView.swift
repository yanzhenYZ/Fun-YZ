//
//  YZPaintingView.swift
//  Funny
//
//  Created by yanzhen on 17/1/4.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZPaintingView: UIView {

    var lineWidth: CGFloat = 2.0
    var lineColor = UIColor.black
    var image: UIImage! {
        didSet {
            let imgLayer = CAShapeLayer()
            imgLayer.contents = image.cgImage
            imgLayer.frame = self.bounds
            self.layer.addSublayer(imgLayer)
            self.layers.append(imgLayer)
        }
    }
    fileprivate var path: YZBezierPath!
    fileprivate var shapeLayer: CAShapeLayer!
    fileprivate var layers = [CAShapeLayer]()
    
    public func clearScreen() {
        for subLayer in layers {
            subLayer.removeFromSuperlayer()
        }
        layers.removeAll()
        setNeedsDisplay()
    }
    
    public func undo() {
        if layers.count > 0 {
            self.layers.last?.removeFromSuperlayer()
            layers.removeLast()
        }
    }
    
    public func isDrawInView() ->Bool{
        return layers.count > 0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
    }
}

extension YZPaintingView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = ((touches as NSSet).anyObject()! as! UITouch).location(in: self)
        let startPath = YZBezierPath(pathLineWidth: lineWidth, pathColor: lineColor, startPoint: point)
        
        let sLayer = CAShapeLayer()
        sLayer.path = startPath.cgPath
        sLayer.backgroundColor = UIColor.clear.cgColor
        sLayer.fillColor = UIColor.clear.cgColor
        sLayer.lineCap = kCALineCapRound
        sLayer.lineJoin = kCALineJoinRound
        sLayer.strokeColor = startPath.color?.cgColor
        sLayer.lineWidth = startPath.lineWidth
        self.layer.addSublayer(sLayer)
        
        shapeLayer = sLayer
        path = startPath
        layers.append(sLayer)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = ((touches as NSSet).anyObject()! as! UITouch).location(in: self)
        path.addLine(to: point)
        shapeLayer.path = path.cgPath
    }
}
