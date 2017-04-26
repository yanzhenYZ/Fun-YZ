//
//  YZRootViewController.swift
//  Funny
//
//  Created by yanzhen on 16/12/22.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

//@objc protocol PersonProtocol {
//    func eating()
//    @objc optional func sleeping()
//    //可选方法通过下面这种方式调用
//    //delegate?.sleeping?()
//}

class YZRootViewController: UIViewController {

    private var scrollView: UIScrollView!
    private var firstVC: YZRootFirstViewController!
    private var secondVC: YZRootSecondViewController!
    private var faceView: YZFaceView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Funny"
        automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.gray
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "weibo_profile_s"), style: .plain, target: self, action: #selector(self.aboutFunny(_:)))
        unowned let blockSelf = self
        YZFunnyManager.requestAccessForVideo { (authorized) in
            if authorized {
                DispatchQueue.main.async(execute: { 
                    blockSelf.faceView = YZFaceView(frame: CGRectScreen)
                    blockSelf.faceView?.backgroundColor = UIColor.red
                    blockSelf.view.insertSubview(blockSelf.faceView!, at: 0)
                    blockSelf.faceView?.startRunning()
                })
            }
        }
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 64, width: WIDTH, height: HEIGHT - 64))
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        self.view.addSubview(scrollView)
        
        firstVC  = YZRootFirstViewController()
        secondVC = YZRootSecondViewController()
        self.addChildViewController(firstVC)
        self.addChildViewController(secondVC)
        let childVCHeight = HEIGHT - 64
        firstVC.view.frame = CGRect(x: 0, y: 0, width: WIDTH, height: childVCHeight)
        secondVC.view.frame = CGRect(x: 0, y: childVCHeight, width: WIDTH, height: childVCHeight)
        scrollView.addSubview(firstVC.view)
        scrollView.addSubview(secondVC.view)
        scrollView.contentSize = CGSize(width: 0, height: childVCHeight * 2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.faceView?.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.faceView?.stopRunning()
    }

    public func widgetIntoViewController(_ tag: Int) {
        ///程序直接通过-3DTouch-或者-Widget-启动--viewDidLoad()没有被调用，需要手动调用一下
        if !self.isViewLoaded {
            viewDidLoad()
        }
        ///只考虑push和present一级的情况
        if self.navigationController?.presentedViewController != nil {
            self.navigationController?.presentedViewController?.dismiss(animated: true, completion: nil)
        }else if (self.navigationController!.viewControllers.count > 1) {
            self.navigationController?.popToRootViewController(animated: true)
        }
        if tag < YZAPPNAME.Draw.rawValue {
            firstVC.widgetIntoViewController(tag)
        }else{
            if tag == 109 {
                let vc = YZQRScanningViewController(touch3D: true)
                self.navigationController?.present(vc, animated: true, completion: nil)
            }else{
                secondVC.widgetIntoViewController(tag)
            }
        }
    }
    
    @objc private func aboutFunny(_ sender: UIBarButtonItem) {
        let vc = YZAboutInfoTableViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
