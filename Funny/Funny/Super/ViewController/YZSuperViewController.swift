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

    override func viewDidLoad() {
        super.viewDidLoad()

        let block = {(imageName: String) -> YZCircularMenuItem in
            let menuItemImage = UIImage(named: "menu_bg")
            return YZCircularMenuItem(image: menuItemImage, highlightedImage: nil, contentImage: UIImage(named: imageName), highlightedContentImage: nil)
        }
        let menuItems = [block("shotPart"),block("home"),block("exit"),block("my")]
        let startItem =  YZCircularMenuItem(image: UIImage(named: "menu"), highlightedImage: nil, contentImage: UIImage(named: "plus"), highlightedContentImage: UIImage(named: "plusHL"));
        
        let menu = YZCircularMenu(frame: CGRect(x: 0, y: HEIGHT - 200 - 49, width: 200, height: 200), start: startItem, start: CGPoint(x: 20, y: 180), menuWholeAngle: CGFloat(M_PI_2), menuItems: menuItems)
        menu?.delegate = self
        menu?.alpha = 0.5
        self.view.addSubview(menu!)
    }

//MARK: YZCircularMenuDelegate
    func yz_CircularMenu(_ menu: YZCircularMenu!, didSelect index: Int) {
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
    
    func yz_CircularMenuWillAnimateOpen(_ menu: YZCircularMenu!) {
        menu.alpha = 1.0
    }
    
    func yz_CircularMenuWillAnimateClose(_ menu: YZCircularMenu!) {
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
        var image = self.view.getRenderImage()
        image = clipImage(image, rect: frame)
        YZFunnyManager.saveImage(image)
    }
    
    private func clipImage(_ image: UIImage, rect: CGRect) ->UIImage {
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
//MARK: lazy var
    lazy var sheet: YZActionSheet = {
        let titleItem = YZActionSheetItem(title: "退出程序", titleColor: nil, titleFont: nil)
        let item = YZActionSheetItem(title: "确定", titleColor: nil, titleFont: nil);
        return YZActionSheet(titleItem: titleItem, cancelItem: nil, delegate: self, actions: [item])
    }()
    
    lazy var shotView: YZShotView = {
        let shotView = YZShotView(frame: CGRect(x: 0.0, y: 64.0, width: WIDTH, height: HEIGHT - 64.0 - 49.0))
        shotView.delegate = self
        return shotView
    }()
}
