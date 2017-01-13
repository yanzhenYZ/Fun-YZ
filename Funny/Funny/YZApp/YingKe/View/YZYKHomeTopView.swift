//
//  YZYKHomeTopView.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

enum YZYKHomeTopViewType: Int {
    case hot = 100
    case near
}

protocol YZYKHomeTopViewDelegate: NSObjectProtocol {
    func homeTopViewBtnClick(_ type: YZYKHomeTopViewType)
}

class YZYKHomeTopView: UIView {

    weak var delegate: YZYKHomeTopViewDelegate?
    private var hotBtn: UIButton!
    private var nearBtn: UIButton!
    private var markIV: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        let btnBlock = { (tag: YZYKHomeTopViewType,title: String) ->UIButton in
            let btn = UIButton()
            btn.setTitle(title, for: .normal)
            btn.tag = tag.rawValue
            btn.titleLabel?.sizeToFit()
            btn.addTarget(self, action: #selector(self.homeTopBtnClick(_:)), for: .touchUpInside)
            self.addSubview(btn)
            return btn
        }
        hotBtn = btnBlock(.hot, "热门")
        hotBtn.frame = CGRect(x: 0, y: 0, width: self.width * 0.5, height: self.height)
        nearBtn = btnBlock(.near, "附近")
        nearBtn.frame = CGRect(x: self.width * 0.5, y: 0, width: self.width * 0.5, height: self.height)
        ///
        markIV = UIImageView(frame: CGRect(x: 0, y: 0, width: hotBtn.titleLabel!.width, height: 2))
        markIV.center = CGPoint(x: hotBtn.center.x, y: 36)
        markIV.backgroundColor = UIColor.white
        addSubview(markIV)
    }
    
    public func scroll(_ tag: Int) {
        let btn = viewWithTag(tag) as! UIButton
        UIView.animate(withDuration: 0.15) { 
            self.markIV.centerX = btn.centerX
        }
    }
    
    @objc private func homeTopBtnClick(_ btn: UIButton) {
        delegate?.homeTopViewBtnClick(YZYKHomeTopViewType(rawValue: btn.tag)!)
        scroll(btn.tag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
