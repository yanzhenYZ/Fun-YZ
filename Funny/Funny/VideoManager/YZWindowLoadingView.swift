//
//  YZWindowLoadingView.swift
//  Funny
//
//  Created by yanzhen on 16/12/29.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

protocol WindowLoadingViewProtocol : NSObjectProtocol {
    func windowLoadingViewDismiss()
}

class YZWindowLoadingView: UIView {

    weak var delegate: WindowLoadingViewProtocol?
    private var indicator: UIActivityIndicatorView!
    private var tipLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        indicator.color = FunnyColor
        indicator.hidesWhenStopped = true
        addSubview(indicator)
        ///
        tipLabel = UILabel()
        tipLabel.text = "加载失败"
        tipLabel.textAlignment = .center
        tipLabel.textColor = FunnyColor
        tipLabel.font = UIFont.systemFont(ofSize: 15)
        tipLabel.isHidden = true
        addSubview(tipLabel)
    }
    
    public func showLoadingView() {
        self.isHidden = false
        tipLabel.isHidden = true
        indicator.startAnimating()
    }
    
    public func stopAnimating() {
        indicator.stopAnimating()
    }
    
    public func loadingFail() {
        tipLabel.isHidden = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !tipLabel.isHidden {
            self.isHidden = true
            delegate?.windowLoadingViewDismiss()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        indicator.center = CGPoint(x: self.width * 0.5, y: self.height * 0.5 - 7)
        tipLabel.frame = CGRect(x: 0, y: self.height - 25, width: self.width, height: 25)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
