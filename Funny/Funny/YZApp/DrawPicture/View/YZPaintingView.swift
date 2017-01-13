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
            paths.append(image)
            setNeedsDisplay()
        }
    }
    private var path: YZBezierPath!
    private var paths = [AnyObject]()
    
    public func clearScreen() {
        paths.removeAll()
        setNeedsDisplay()
    }
    
    public func undo() {
        if paths.count > 0 {
            paths.removeLast()
            setNeedsDisplay()
        }
    }
    
    public func isDrawInView() ->Bool{
        return paths.count > 0
    }
    ///
    override func draw(_ rect: CGRect) {
        if paths.count <= 0 {
            return
        }
        for (_,value) in paths.enumerated() {
            if value is UIImage {
                let image = value as! UIImage
                image.draw(at: CGPointZero)
            }else{
                let onePath = value as! YZBezierPath
                onePath.color?.set()
                onePath.stroke()
            }
        }
    }
    
//MARK: - touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = ((touches as NSSet).anyObject()! as! UITouch).location(in: self)
        let startPath = YZBezierPath(pathLineWidth: lineWidth, pathColor: lineColor, startPoint: point)
        path = startPath
        paths.append(startPath)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = ((touches as NSSet).anyObject()! as! UITouch).location(in: self)
        path.addLine(to: point)
        setNeedsDisplay()
    }
}
