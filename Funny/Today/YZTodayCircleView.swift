//
//  YZTodayCircleView.swift
//  Funny
//
//  Created by yanzhen on 17/1/13.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZTodayCircleView: UIView {

    private var progressLayer: CAShapeLayer!
    private var subTitleLabel: UILabel!
    private var titleLabel: UILabel!
    init(frame: CGRect, radius: CGFloat,title: String, titleFontSize: CGFloat, subTitle: String, subTitleFontSize: CGFloat) {
        super.init(frame: frame)
        self.clipsToBounds = true
        let width = frame.size.width
        let height = frame.size.height
        let lineWidth: CGFloat = 2
        ///
        let circleLayer = CAShapeLayer()
        circleLayer.frame = self.bounds
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.gray.cgColor
        circleLayer.opacity = 0.25
        circleLayer.lineCap = kCALineCapRound
        circleLayer.lineWidth = lineWidth
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: width / 2, y: height / 2), radius: radius, startAngle: -CGFloat(M_PI_2), endAngle: CGFloat(M_PI_2) * 3, clockwise: true)
        circleLayer.path = circlePath.cgPath
        self.layer.addSublayer(circleLayer)
        ///
        progressLayer = CAShapeLayer()
        progressLayer.frame = self.bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor(colorLiteralRed: 1.0, green: 133/255.0, blue: 25/255.0, alpha: 1.0).cgColor
        progressLayer.lineCap = kCAFillRuleNonZero
        progressLayer.strokeEnd = 0.0
        progressLayer.lineWidth = lineWidth
        let progressPath = UIBezierPath(arcCenter: CGPoint(x: width * 0.5, y: height * 0.5), radius: radius, startAngle: -CGFloat(M_PI_2), endAngle: CGFloat(M_PI_2) * 3 , clockwise: true)
        progressLayer.path = progressPath.cgPath
        self.layer.addSublayer(progressLayer)
        ///
        var labelHeight: CGFloat = 25.0
        if radius < (labelHeight + lineWidth) {
            labelHeight = radius - lineWidth
        }
        titleLabel = UILabel(frame: CGRect(x: width * 0.5 - radius + lineWidth, y: height * 0.5 - labelHeight, width: 2 * radius - 2 * lineWidth, height: labelHeight))
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: titleFontSize)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor(colorLiteralRed: 104/255.0, green: 99/255.0, blue: 107/255.0, alpha: 1.0)
        self.addSubview(titleLabel)
        ///
        subTitleLabel = UILabel(frame: CGRect(x: width * 0.5 - radius + lineWidth, y: height * 0.5, width: 2 * radius - 2 * lineWidth, height: labelHeight))
        subTitleLabel.text = subTitle
        subTitleLabel.font = UIFont.systemFont(ofSize: subTitleFontSize)
        subTitleLabel.textAlignment = .center
        subTitleLabel.textColor = UIColor(colorLiteralRed: 14/255.0, green: 110/255.0, blue: 251/255.0, alpha: 1.0)
        self.addSubview(subTitleLabel)
    }
    
    public func setProgress(_ progress: CGFloat, subTitle: String?) {
        subTitleLabel.text = subTitle
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn))
        CATransaction.setAnimationDuration(1.0)
        var strokeEnd = progress < 0.0 ? 0.0 : progress
        strokeEnd = progress > 1.0 ? 1.0 : progress
        progressLayer.strokeEnd = strokeEnd
        CATransaction.commit()
    }
    
    public func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
