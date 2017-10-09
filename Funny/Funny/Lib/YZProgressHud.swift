//
//  YZProgressHud.swift
//  test1
//
//  Created by yanzhen on 2017/9/24.
//  Copyright © 2017年 yanzhen. All rights reserved.
//

import UIKit

private let YZHudWhite = true
private let YZHudMinWH: CGFloat = 80
private let YZHudTakeMax: CGFloat = 0.7
private let YZHudPadding: CGFloat = 15
private let YZHudShowViewCornerRadius: CGFloat = 5
private let YZhudHideDelay: TimeInterval = 1
private let YZHudTitleFontSize: CGFloat = 16

class YZProgressHud: UIView {
    
    fileprivate var showView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        showView = UIView()
        showView.backgroundColor = YZHudWhite ? UIColor(white: 0.8, alpha: 0.6) : UIColor.black
        showView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        showView.layer.cornerRadius = YZHudShowViewCornerRadius
        addSubview(showView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        showView.center = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YZProgressHud {
    class func showHud(_ view: UIView, message: String = "", color: UIColor? = nil) {
        hideHud(for: view)
        let hud = YZProgressHud(frame: view.bounds)
        hud.create(message, color: color)
        view.addSubview(hud)
    }
    
    class func showHud(_ view: UIView, imgName: String, hideDelay delay: TimeInterval = YZhudHideDelay) {
        hideHud(for: view)
        let hud = YZProgressHud(frame: view.bounds)
        hud.create(imgName)
        view.addSubview(hud)
        hud.perform(#selector(removeFromSuperview), with: nil, afterDelay: delay)
    }
    
    class func showHud(_ view: UIView, imgName: String, message: String, textColor color: UIColor? = nil, hideDelay delay: TimeInterval = YZhudHideDelay) {
        hideHud(for: view)
        let hud = YZProgressHud(frame: view.bounds)
        hud.create(imgName, message: message, textColor: color)
        view.addSubview(hud)
        hud.perform(#selector(removeFromSuperview), with: nil, afterDelay: delay)
    }
    
    class func hideHud(for view: UIView, animated: Bool = false) {
        for subView in view.subviews {
            if subView is YZProgressHud {
                if animated {
                    UIView.animate(withDuration: 1, animations: {
                        subView.alpha = 0
                    }, completion: { (finished) in
                        subView.removeFromSuperview()
                    })
                }else{
                    subView.removeFromSuperview()
                }
            }
        }
    }
}
//MARK: - fileprivate
extension YZProgressHud {
    fileprivate func create(_ imageName: String) {
        let imageView = createImgView(imageName)
        showView.frame = CGRect(x: 0, y: 0, width: YZHudMinWH, height: YZHudMinWH)
        imageView.center = CGPoint(x: YZHudMinWH * 0.5, y: YZHudMinWH * 0.5)
    }
    
    fileprivate func create(_ imageName: String, message: String, textColor: UIColor?) {
        let imageView = createImgView(imageName)
        adjustViewAndAddTitleLabel(imageView, message: message, textColor: textColor)
    }
    
    fileprivate func create(_ message: String, color: UIColor?) {
        if message == "" {
            let indicatorView = createActivityIndicatorView()
            showView.frame = CGRect(x: 0, y: 0, width: YZHudMinWH, height: YZHudMinWH)
            indicatorView.center = CGPoint(x: YZHudMinWH / 2, y: YZHudMinWH / 2)
            return
        }
        
        let indicatorView = createActivityIndicatorView()
        adjustViewAndAddTitleLabel(indicatorView, message: message, textColor: color)
    }
    
    fileprivate func adjustViewAndAddTitleLabel(_ view: UIView, message: String, textColor: UIColor?) {
        let titleLabel = createTitleLabel()
        titleLabel.text = message
        if let textColor = textColor {
            titleLabel.textColor = textColor
        }
        let maxSize = CGSize(width: bounds.size.width * YZHudTakeMax, height: bounds.size.height * YZHudTakeMax)
        let textSize = message.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : titleLabel.font], context: nil).size
        var showW = textSize.width + YZHudPadding * 2;
        if showW < YZHudMinWH {
            showW = YZHudMinWH
        }
        let showH = YZHudPadding + view.frame.size.height + YZHudPadding * 2.33
        showView.frame = CGRect(x: 0, y: 0, width: showW, height: showH)
        view.center = CGPoint(x: showW * 0.5, y: view.frame.size.height * 0.5 + YZHudPadding)
        titleLabel.frame = CGRect(x: YZHudPadding, y: view.frame.maxY + YZHudPadding / 3, width: showW - YZHudPadding * 2, height: YZHudPadding)
    }
}

extension YZProgressHud {
    fileprivate func createActivityIndicatorView() -> UIActivityIndicatorView {
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicatorView.color = YZHudWhite ? UIColor.black : UIColor.white
        indicatorView.startAnimating()
        showView.addSubview(indicatorView)
        return indicatorView
    }
    
    fileprivate func createTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = YZHudWhite ? UIColor.black : UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: YZHudTitleFontSize)
        titleLabel.backgroundColor = UIColor.clear
        showView.addSubview(titleLabel)
        return titleLabel
    }
    
    fileprivate func createImgView(_ imageName: String) -> UIImageView {
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        showView.addSubview(imageView)
        return imageView
    }
}
