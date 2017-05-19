//
//  YZMPSettingView.swift
//  Funny
//
//  Created by yanzhen on 2017/5/9.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

protocol YZMPSettingViewDelegate : NSObjectProtocol {
    func beautyValueChanged(value: CGFloat)
    func brightValueChanged(value: CGFloat)
}

class YZMPSettingView: UIView {

    weak var delegate: YZMPSettingViewDelegate?
    private var beautyLevel: UISlider!
    private var brightLevel: UISlider!
    override init(frame: CGRect) {
        super.init(frame: frame)
        let effect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = self.bounds
        self.addSubview(effectView)
        
        beautyLevel = UISlider(frame: CGRect(x: 0, y: 20, width: frame.size.width, height: 30))
        beautyLevel.value = 0.5
        beautyLevel.setMinimumTrackImage(#imageLiteral(resourceName: "mp_slider_background"), for: .normal)
        beautyLevel.addTarget(self, action: #selector(self.beautyLevelValueChanged(slider:)), for: .valueChanged)
        self.addSubview(beautyLevel)
        
        brightLevel = UISlider(frame: CGRect(x: 0, y: 60, width: frame.size.width, height: 30))
        brightLevel.value = 0.5
        brightLevel.setMinimumTrackImage(#imageLiteral(resourceName: "mp_slider_background"), for: .normal)
        brightLevel.addTarget(self, action: #selector(self.brightLevelValueChanged(slider:)), for: .valueChanged)
        self.addSubview(brightLevel)
        
    }
    
    @objc private func beautyLevelValueChanged(slider: UISlider) {
        delegate?.beautyValueChanged(value: CGFloat(slider.value))
    }
    
    @objc private func brightLevelValueChanged(slider: UISlider) {
        delegate?.brightValueChanged(value: CGFloat(slider.value))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
