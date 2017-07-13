//
//  FunnyExtension.swift
//  Funny
//
//  Created by yanzhen on 16/12/22.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit
import Kingfisher

extension UIView {
    
    public var x: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    public var y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    public var width: CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    public var height: CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    public var centerX: CGFloat{
        get{
            return self.center.x
        }
        set{
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    public var centerY: CGFloat{
        get{
            return self.center.y
        }
        set{
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }
    
    public var size: CGSize{
        get{
            return self.frame.size;
        }
        set{
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
//MARK: UIView XIB属性
    @IBInspectable var borderWidth: CGFloat{
        get {
            return 0.0;
        }
        set{
            self.layer.borderWidth = newValue;
        }
    }
    
    @IBInspectable var borderColor: UIColor{
        get {
            return UIColor();
        }
        set{
            self.layer.borderColor = newValue.cgColor;
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat{
        get {
            return 0.0;
        }
        set{
            self.layer.masksToBounds = true;
            self.layer.cornerRadius = newValue;
        }
    }
//MARK: UIView 只读属性
    public var maxX: CGFloat{
        get{
            return self.frame.maxX
        }
    }
    
    public var maxY: CGFloat{
        get{
            return self.frame.maxY
        }
    }
//MARK: UIView--Method    
    func corner() {
        self.layoutIfNeeded();
        self.layer.masksToBounds = true;
        self.layer.cornerRadius  = self.frame.size.width / 2;
    }
    
    public func getRenderImage() ->UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        self.layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    public func snapshotScreenInView() -> UIImage {
        let size = self.bounds.size
        let rect = self.frame
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        self .drawHierarchy(in: rect, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension String {
    public var length: Int {
        get{
            return self.characters.count;
        }
    }
    
    public var isURL: Bool {
        get{
            let regulaStr = "(((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%@^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%@^&*+?:_/=<>]*)?))'>((?!<\\/a>).)*<\\/a>|(((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%@^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%@^&*+?:_/=<>]*)?))"
            let range = self.range(of: regulaStr, options: .regularExpression, range: nil, locale: nil)
//            range?.isEmpty
            return range != nil
        }
    }
    
    public func boundingHeight(fontSize: CGFloat, maxWidth: CGFloat) ->CGFloat {
        let size = CGSize(width: maxWidth, height: 9999.0)
        return self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: fontSize)], context: nil).size.height
    }
    
    public func removeLast(length: Int) ->String {
        let index = self.index(self.endIndex, offsetBy: -length)
        return self.substring(to: index)
    }
    
}

extension UIImageView {
    public func yz_setImage(_ urlString: String, placeholder imageName: String = "Y&Z") {
        let image = UIImage(named: imageName)
        self.kf.setImage(with: URL(string: urlString), placeholder: image)
    }
}
//extension UIImage {
//    public func imageWithCaptureView(view: UIView) ->UIImage {
//        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
//        let context = UIGraphicsGetCurrentContext()
//        view.layer.render(in: context!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image!
//    }
//}

extension Array {
    public mutating func add(_ element: Element, add: Bool) {
        if add {
            self.append(element)
        }else{
            self.insert(element, at: 0)
        }
    }
}
