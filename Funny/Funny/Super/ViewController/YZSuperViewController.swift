//
//  YZSuperViewController.swift
//  Funny
//
//  Created by yanzhen on 16/12/22.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit
import YZUIKit
import CoreGraphics

class YZSuperViewController: UIViewController, YZCircularMenuDelegate, YZActionSheetDelegate, YZShotViewDelegate {

    private lazy var sheet: YZActionSheet = {
        let titleItem = YZActionSheetItem(title: "退出程序", titleColor: UIColor.gray)
        let item = YZActionSheetItem(title: "确定")
        return YZActionSheet(titleItem: titleItem, delegate: self, actions: [item])
    }()
    
    private lazy var shotView: YZShotView = {
        let shotView = YZShotView(frame: CGRect(x: 0.0, y: 64.0, width: WIDTH, height: HEIGHT - 64.0 - 49.0))
        shotView.delegate = self
        return shotView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let block = {(image: UIImage) -> YZCircularItem in
            return YZCircularItem(image: #imageLiteral(resourceName: "menu_bg"), highlightedImage: nil, contentImage: image, highlightedContentImage: nil)
        }
        let menuItems = [block(#imageLiteral(resourceName: "shotPart")),block(#imageLiteral(resourceName: "home")),block(#imageLiteral(resourceName: "exit")),block(#imageLiteral(resourceName: "my"))]
        
        let startItem =  YZCircularItem(image: #imageLiteral(resourceName: "menu"), highlightedImage: nil, contentImage: #imageLiteral(resourceName: "plus"), highlightedContentImage: #imageLiteral(resourceName: "plusHL"));
        
        let menu = YZCircularMenu(frame: CGRect(x: 0, y: HEIGHT - 200 - 49, width: 200, height: 200), startItem: startItem, startPoint: CGPoint(x: 20, y: 180), menuWholeAngle: Double.pi / 2, items: menuItems)
        menu.delegate = self
        menu.alpha = 0.5
        self.view.addSubview(menu)
    }

//MARK: YZCircularMenuDelegate
    func yz_CircularMenu(_ menu: YZCircularMenu, didSelect index: Int) {
        menu.alpha = 0.5
        if index == 0 {
            self.view.addSubview(self.shotView)
        }else if index == 1 {
            self.dismiss(animated: true, completion: nil)
        }else if index == 2 {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            self.sheet.showInView(appDelegate.window)
        }else if index == 3 {
            let vc = YZAboutInfoTableViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func yz_CircularMenuWillAnimateOpen(menu: YZCircularMenu) {
        menu.alpha = 1.0
    }
    
    func yz_CircularMenuWillAnimateClose(menu: YZCircularMenu) {
        menu.alpha = 0.5
    }
//MARK: YZActionSheetDelegate
    func yz_actionSheet(_ actionSheet: YZActionSheet, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == 1 {
            exit(0)
        }
    }
//MARK: YZShotViewDelegate
    func shotPart(isShot: Bool, shotFrame frame: CGRect) {
        shotView.removeFromSuperview()
        if isShot {
            var image = self.view.getRenderImage()
            image = self.clipImage(image, rect: frame)
            YZFunnyManager.saveImage(image)
        }
    }
}

extension YZSuperViewController {
    fileprivate func clipImage(_ image: UIImage, rect: CGRect) ->UIImage {
        let scale = UIScreen.main.scale
        let frame = CGRect(x: rect.origin.x * scale, y: rect.origin.y * scale, width: rect.size.width * scale, height: rect.size.height * scale)
        let imageRef = image.cgImage
        //考虑navigationBar
        let subImageRef = imageRef?.cropping(to: CGRect(x: frame.origin.x, y: frame.origin.y + 64 * scale, width: frame.size.width, height: frame.size.height))
        //        let subImageRef = imageRef?.cropping(to: frame)
        UIGraphicsBeginImageContext(frame.size)
        let context = UIGraphicsGetCurrentContext()
        context?.draw(subImageRef!, in: frame)
        let newImage = UIImage(cgImage: subImageRef!)
        UIGraphicsEndImageContext()
        return newImage
    }
}
