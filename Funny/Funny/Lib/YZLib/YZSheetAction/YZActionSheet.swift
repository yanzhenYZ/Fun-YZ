//
//  YZActionSheet.swift
//  Funny
//
//  Created by yanzhen on 16/12/26.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

protocol YZActionSheetDelegate: NSObjectProtocol {
    func yz_actionSheet(_ actionSheet: YZActionSheet, clickedButtonAt buttonIndex: Int)
}

class YZActionSheet: UIView {

    /**     动画显示的时间(默认0.5)     */
    var showDuration: Float = 0.5
    /**     动画消失的时间(默认0.25)     */
    var dismissDuration: Float = 0.25
    
    fileprivate weak var delegate: YZActionSheetDelegate?
    fileprivate var titleItem: YZActionSheetItem?
    fileprivate var cancelItem: YZActionSheetItem?
    fileprivate var itemsArray: [YZActionSheetItem]?
    fileprivate var backView: UIView!
    
    public init(titleItem: YZActionSheetItem?,cancelItem: YZActionSheetItem?,delegate: YZActionSheetDelegate?,actions: [YZActionSheetItem]?){
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.titleItem  = titleItem
        self.cancelItem = cancelItem
        self.delegate   = delegate
        self.itemsArray = actions
        configureUI()
    }
    
    public func showInView(_ view: UIView?) {
        self.backgroundColor = UIColor.clear
        self.removeFromSuperview()
        var showView: UIView = UIApplication.shared.windows.last!
        if view != nil {
            showView = view!
        }
        showView.addSubview(self)
        self.frame = showView.bounds
        backView.frame = CGRect(x: 0, y: self.frame.size.height, width: 0, height: 0)
        //
        let width = self.frame.size.width
        var itemHeight: CGFloat = 0
        if itemsArray != nil {
            itemHeight = 50.5 * CGFloat(itemsArray!.count)
        }
        var backViewHeight = 50 + 5 + itemHeight
        if titleItem != nil {
            backViewHeight += (1 + 60)
            let label = backView.viewWithTag(1000)
            label!.frame = CGRect(x: 0, y: 0, width: width, height: 60)
        }else{
            if itemHeight < 1 {
                backViewHeight -= 5
            }
        }
        backView.frame = CGRect(x: 0, y: backView.frame.origin.y, width: width, height: backViewHeight)
        let cancel = backView.viewWithTag(100)
        cancel!.frame = CGRect(x: 0, y: backViewHeight - 50, width: width, height: 50)
        if itemsArray != nil {
            for (index,_) in itemsArray!.enumerated() {
                let itemBtn = backView.viewWithTag(101 + index)
                itemBtn!.frame = CGRect(x: 0, y: backViewHeight - 55 - 50.5 * CGFloat(index + 1), width: width, height: 50)
            }
        }

        let height = backView.frame.size.height
        UIView.animate(withDuration: TimeInterval(showDuration), animations: {
            self.backView.frame = CGRect(x: 0, y: self.frame.size.height - height, width: width, height: height)
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        })
    }
    
    fileprivate func configureUI() {
        self.backgroundColor = UIColor.clear
        backView = UIView()
        backView.clipsToBounds = true
        backView.backgroundColor = YZColor(229, 229, 231)
        self.addSubview(backView)
        //
        let cancel = UIButton(type: .system)
        cancel.backgroundColor = UIColor.white
        cancel.tag = 100
        var cancelTitle = "取消"
        var cancelColor = UIColor(red: 22/255.0, green: 22/255.0, blue: 22/255.0, alpha: 1.0)
        var cancelFont: CGFloat  = 18.0
        if cancelItem != nil {
            cancelTitle = cancelItem!.title
            if cancelItem!.titleColor != nil {
                cancelColor = cancelItem!.titleColor!
            }
            if cancelItem!.titleFont != nil {
                cancelFont = cancelItem!.titleFont!
            }
        }
        cancel.setTitle(cancelTitle, for: .normal)
        cancel.setTitleColor(cancelColor, for: .normal)
        cancel.titleLabel?.font = UIFont.systemFont(ofSize: cancelFont)
        cancel.addTarget(self, action: #selector(self.action(btn:)), for: .touchUpInside)
        backView.addSubview(cancel)
        //item
        if let items = itemsArray {
            for (index,value) in items.enumerated() {
                let itemBtn = UIButton(type: .system)
                itemBtn.backgroundColor = UIColor.white
                itemBtn.tag = 101 + index
                itemBtn.setTitle(value.title, for: .normal)
                
                var itemColor = UIColor(red: 222/255.0, green: 63/255.0, blue: 65/255.0, alpha: 1.0)
                var itemFont: CGFloat = 18
                if value.titleColor != nil {
                    itemColor = value.titleColor!
                }
                if value.titleFont != nil {
                    itemFont = value.titleFont!
                }

                itemBtn.setTitleColor(itemColor, for: .normal)
                itemBtn.titleLabel?.font = UIFont.systemFont(ofSize: itemFont)
                itemBtn.addTarget(self, action: #selector(self.action(btn:)), for: .touchUpInside)
                backView.addSubview(itemBtn)
            }
        }
        //title
        if titleItem != nil {
            let label = UILabel()
            label.tag = 1000
            label.backgroundColor = UIColor.white
            label.textAlignment = .center
            label.text = titleItem!.title
            var labelColor = UIColor(red: 147/255.0, green: 148/255.0, blue: 149/255.0, alpha: 1.0)
            var labelFont: CGFloat = 15
            if titleItem!.titleColor != nil {
                labelColor = titleItem!.titleColor!
            }
            if titleItem!.titleFont != nil {
                labelFont = titleItem!.titleFont!
            }
            label.textColor  = labelColor
            label.font = UIFont.systemFont(ofSize: labelFont)
            backView.addSubview(label)
        }
    }
    
    fileprivate func dismiss() {
        self.backgroundColor = UIColor.clear
        UIView.animate(withDuration: TimeInterval(dismissDuration), animations: {
            self.backView.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: self.backView.frame.size.height)
        }, completion: { (finished) in
            self.removeFromSuperview()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss()
    }
    
    @objc fileprivate func action(btn: UIButton) {
        delegate?.yz_actionSheet(self, clickedButtonAt: btn.tag - 100)
        dismiss()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
