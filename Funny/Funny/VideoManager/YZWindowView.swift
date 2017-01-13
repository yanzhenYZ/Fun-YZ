//
//  YZWindowView.swift
//  Funny
//
//  Created by yanzhen on 16/12/29.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

protocol WindowViewProtocol: NSObjectProtocol{
    func closeWindowView()
    func videoPlayOrPause(_ playBtn: UIButton)
    func loadingViewDismissForFail()
}


class YZWindowView: UIView, WindowLoadingViewProtocol {
    
    weak var delegate: WindowViewProtocol?
    var mainImageView: UIImageView!
    var progressView: UIProgressView!
    var playBtn: UIButton!
    var loadingView: YZWindowLoadingView!
    private var effectView: UIVisualEffectView!
    private var closeBtn: UIButton!
    private var topLineView: UIView!
    private var yzView: UIView!
    private var yzLayer: CALayer!
    private var layerDelegate: YZLayerDelegate!
    private var beginPoint: CGPoint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @objc private func closeBtnAction(_ btn: UIButton) {
        delegate?.closeWindowView();
    }
    
    @objc private func playBtnAction(_ btn: UIButton) {
        delegate?.videoPlayOrPause(btn);
    }
    
//MARK: WindowLoadingViewProtocol
    func windowLoadingViewDismiss() {
        delegate?.loadingViewDismissForFail()
    }
//MARK: UI
    private func configureUI() {
        let effect = UIBlurEffect(style: .light)
        effectView = UIVisualEffectView(effect: effect)
        effectView.isUserInteractionEnabled = false
        addSubview(effectView)

        topLineView = UIView()
        topLineView.backgroundColor = FunnyColor
        addSubview(topLineView)
        
        mainImageView = UIImageView()
        addSubview(mainImageView)
        
        progressView = UIProgressView()
        progressView.progressTintColor = FunnyColor
        addSubview(progressView)
        
        yzView = UIView()
        yzView.backgroundColor = UIColor.clear
        yzLayer = CALayer()
        yzLayer.backgroundColor = UIColor.clear.cgColor
        layerDelegate = YZLayerDelegate()
        layerDelegate.left = true
        yzLayer.delegate = layerDelegate
        yzView.layer.addSublayer(yzLayer)
        yzLayer.setNeedsDisplay()
        addSubview(yzView)
        
        closeBtn = UIButton(type: .custom)
        closeBtn.backgroundColor = UIColor.clear
        closeBtn.setBackgroundImage(UIImage(named: "closeWindowView"), for: .normal)
        closeBtn.addTarget(self, action: #selector(self.closeBtnAction(_:)), for: .touchUpInside)
        addSubview(closeBtn)
        
        playBtn = UIButton(type: .custom)
        playBtn.setImage(UIImage(named: "WindowViewPause"), for: .selected)
        playBtn.addTarget(self, action: #selector(self.playBtnAction(_:)), for: .touchUpInside)
        addSubview(playBtn)
        
        loadingView = YZWindowLoadingView(frame: CGRectZero);
        loadingView.delegate = self
        loadingView.isHidden = true
        addSubview(loadingView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        effectView.frame = self.bounds
        topLineView.frame = CGRect(x: 0, y: 0, width: width, height: 2)
        progressView.frame = CGRect(x: 0, y: height - 2, width: width, height: 2)
        mainImageView.frame = CGRect(x: 0, y: 2, width: width, height: height - 4)
        yzView.frame = CGRect(x: 0, y: 2, width: width, height: height - 4)
        yzLayer.frame = yzView.bounds
        
        
        closeBtn.frame = CGRect(x: width - 30.0, y: 2 , width: 30.0, height: 30.0)
        playBtn.frame = CGRect(x: 0, y: 0, width: 70 * 1.5, height: 70 * 1.5)
        playBtn.center = CGPoint(x: width * 0.5, y: height * 0.5)
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        loadingView.center = CGPoint(x: width * 0.5, y: height * 0.5)
        if mainImageView.layer.sublayers != nil {
            for (_,value) in mainImageView.layer.sublayers!.enumerated() {
                value.frame = mainImageView.bounds
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
