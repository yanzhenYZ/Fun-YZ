//
//  YZLockedView.swift
//  Funny
//
//  Created by yanzhen on 17/1/5.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

protocol YZLockedViewDelegate : NSObjectProtocol {
    func passwordIsRight(password: String) ->Bool
}

class YZLockedView: UIView {

    weak var delegate: YZLockedViewDelegate?
    private var titleLabel: UILabel!
    private var topView: UIView!
    private var lockView: UIView!
    private var cancelBtn: UIButton!
    private var password: String! = ""
    private var views = [UIView]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureUI()
    }

    @objc private func lockBtnClick(btn: UIButton) {
        UIView.animate(withDuration: 0.05, animations: {
            btn.backgroundColor = YZColor(43, 134, 182)
        }) { (finished) in
            btn.backgroundColor = UIColor.clear
        }
        addCode(btn.titleLabel!.text!)
    }
    
    private func addCode(_ code: String) {
        if views.count == 4 {
            return
        }
        
        let view = topView.viewWithTag(views.count + 100)
        view?.backgroundColor = YZColor(43, 134, 182)
        password = password + code
        views.append(view!)
        if views.count == 4 {
            if delegate != nil {
                if !delegate!.passwordIsRight(password: password) {
                    UIView.animate(withDuration: 0.1, animations: { 
                        self.topView.transform = self.topView.transform.translatedBy(x: 20, y: 0)
                    }, completion: { (finish) in
                        UIView.animate(withDuration: 0.1, animations: { 
                            self.topView.transform = self.topView.transform.translatedBy(x: -40, y: 0)
                        }, completion: { (finished) in
                            self.topView.transform = .identity
                        })
                    })
                }
                resetAll()
            }
            
        }
    }
    
    @objc private func cancelBtnClick() {
        if views.count == 0 {
            return
        }
        let view = views.last
        view?.backgroundColor = UIColor.clear
        views.removeLast()
        password = password.removeLast(length: 1)
    }
    
    private func resetAll() {
        password = ""
        for (_,view) in views.enumerated() {
            view.backgroundColor = UIColor.clear
        }
        views.removeAll()
    }
//MARK: - UI
    private func configureUI() {
        titleLabel = UILabel()
        titleLabel.text = "输入密码"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textColor = UIColor.white
        addSubview(titleLabel)
        ///
        topView = UIView()
        topView.backgroundColor = UIColor.clear
        for i in 0..<4 {
            let view = UIView()
            view.tag = 100 + i
            view.layer.masksToBounds = true
            view.layer.cornerRadius = 7.5
            view.layer.borderWidth = 1
            view.layer.borderColor = YZColor(43, 134, 182).cgColor
            topView.addSubview(view)
        }
        addSubview(topView)
        ///
        lockView = UIView()
        lockView.backgroundColor = UIColor.clear
        let lockBtnWH: CGFloat = ISIPAD ? 80 : 75
        for i in 0..<10 {
            let btn = UIButton()
            btn.tag = i
            btn.layer.masksToBounds = true
            btn.layer.cornerRadius = lockBtnWH / 2
            btn.layer.borderWidth = 2
            btn.layer.borderColor = YZColor(43, 134, 182).cgColor
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 27)
            if i == 9 {
                btn.setTitle("0", for: .normal)
            }else{
                btn.setTitle(String(i+1), for: .normal)
            }
            btn.addTarget(self, action: #selector(self.lockBtnClick(btn:)), for: .touchUpInside)
            lockView.addSubview(btn)
        }
        addSubview(lockView)
        ///
        cancelBtn = UIButton()
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.addTarget(self, action: #selector(self.cancelBtnClick), for: .touchUpInside)
        addSubview(cancelBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let lockBtnWH: CGFloat = ISIPAD ? 80 : 75
        let lockSpace: CGFloat = 25
        let lockW = lockBtnWH * 3 + lockSpace * 4
        let lockH = lockBtnWH * 4 + lockSpace * 5
        ///
        lockView.frame = CGRect(x: 0, y: 0, width: lockW, height: lockH)
        lockView.center = CGPoint(x: self.width * 0.5, y: self.height * 0.5 + (lockBtnWH + lockSpace) * 0.5)
        for (_,btn) in lockView.subviews.enumerated() {
            let row = btn.tag / 3
            let col = btn.tag % 3
            if btn.tag == 9 {
                btn.frame = CGRect(x: 0, y: lockSpace + (lockBtnWH + lockSpace) * CGFloat(row), width: lockBtnWH, height: lockBtnWH)
                btn.centerX = lockView.width * 0.5
            }else{
                btn.frame = CGRect(x: lockSpace + (lockBtnWH + lockSpace) * CGFloat(col), y: lockSpace + (lockBtnWH + lockSpace) * CGFloat(row), width: lockBtnWH, height: lockBtnWH)
            }
        }
        ///
        let space: CGFloat = 25
        let viewWH: CGFloat = 15;
        let topW = viewWH * 4 + space * 5
        let topH = viewWH + 5 * 2
        topView.frame = CGRect(x: 0, y: 0, width: topW, height: topH)
        topView.center = CGPoint(x: self.width * 0.5, y: lockView.y - 30)
        for (_,view) in topView.subviews.enumerated() {
            view.frame = CGRect(x: space + (space + viewWH) * CGFloat(view.tag - 100), y: 5, width: viewWH, height: viewWH)
        }
        ///
        cancelBtn.frame = CGRect(x: 0, y: 0, width: lockBtnWH, height: lockBtnWH)
        cancelBtn.center = CGPoint(x: self.width * 0.5 + lockBtnWH + lockSpace, y: self.centerY + (lockBtnWH + lockSpace) * 2)
        ///
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 25)
        titleLabel.center = CGPoint(x: self.width * 0.5, y: topView.y - 25)
    }
}
