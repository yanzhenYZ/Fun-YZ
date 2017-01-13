//
//  YZYKTabBar.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

enum YKTabBarBtnType: Int {
    case home = 100
    case my
    case launch
}

protocol YKTabBarDelegate: NSObjectProtocol {
    func ykTabBarBtnClick(_ type: YKTabBarBtnType)
}

class YZYKTabBar: UIView {

    weak var delegate: YKTabBarDelegate?
    private var homeBtn: UIButton!
    private var myBtn: UIButton!
    private var launchBtn: UIButton!
    private var selectedBtn: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        let btnBlock = { (tag: YKTabBarBtnType,imageName: String) ->UIButton in
            let btn = UIButton()
            btn.adjustsImageWhenHighlighted = false
            btn.setImage(UIImage(named: imageName), for: .normal)
            btn.setImage(UIImage(named: imageName + "_p"), for: .selected)
            btn.tag = tag.rawValue
            btn.addTarget(self, action: #selector(self.itemBtnClick(_:)), for: .touchUpInside)
            self.addSubview(btn)
            return btn
        }
        homeBtn = btnBlock(.home,"tab_live")
        myBtn = btnBlock(.my,"tab_me")
        homeBtn.isSelected = true
        selectedBtn = homeBtn
        ///
        launchBtn = UIButton()
        launchBtn.setImage(UIImage(named: "tab_launch"), for: .normal)
        launchBtn.sizeToFit()
        launchBtn.tag = YKTabBarBtnType.launch.rawValue
        launchBtn.addTarget(self, action: #selector(self.itemBtnClick(_:)), for: .touchUpInside)
        addSubview(launchBtn)
    }
    
    @objc private func itemBtnClick(_ btn: UIButton) {
        if btn == selectedBtn {
            return
        }
        delegate?.ykTabBarBtnClick(YKTabBarBtnType(rawValue: btn.tag)!)
        if btn.tag == YKTabBarBtnType.launch.rawValue {
            return
        }
        selectedBtn.isSelected = false
        btn.isSelected = true
        selectedBtn = btn
        UIView.animate(withDuration: 0.2, animations: { 
            btn.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { (finished) in
            UIView.animate(withDuration: 0.2, animations: { 
                btn.transform = .identity
            })
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        ///87
        ///(87/2 - (self.height * 0.5 - 20) + 49) = 88(tabBar最高)
        launchBtn.center = CGPoint(x: self.width * 0.5, y: self.height * 0.5 - 20)
        homeBtn.frame = CGRect(x: 0, y: 0, width: self.width * 0.5, height: self.height)
        myBtn.frame = CGRect(x: self.width * 0.5, y: 0, width: self.width * 0.5, height: self.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
