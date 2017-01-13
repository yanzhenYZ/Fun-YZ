//
//  YZYKHomeViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZYKHomeViewController: YZSuperViewController, UIScrollViewDelegate, YZYKHomeTopViewDelegate {

    private var timer: Timer!
    private var scrollView: UIScrollView!
    private var topView: YZYKHomeTopView!
    private var hotVC: YZYKHotTableViewController!
    private var nearVC: YZYKNearCollectionViewController!
    private var hot_offsetY: CGFloat = 0
    private var near_offsetY: CGFloat = 0
    private var up: Bool = false
    deinit {
        timer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.layoutIfNeeded()
        scrollView = UIScrollView(frame: CGRectScreen)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.view.insertSubview(scrollView, at: 0)
        ///
        hotVC = YZYKHotTableViewController()
        self.addChildViewController(hotVC)
        hotVC.view.frame = CGRectScreen
        scrollView.addSubview(hotVC.view)
        
        nearVC = YZYKNearCollectionViewController()
        self.addChildViewController(nearVC)
        scrollView.contentSize = CGSize(width: WIDTH * 2, height: 0)
        ///
        topView = YZYKHomeTopView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        topView.delegate = self
        self.navigationItem.titleView = topView
        ///
        timer = Timer(timeInterval: 150, repeats: true, block: { [weak self] (timer) in
            self?.reloadData()
        })
        RunLoop.current.add(timer, forMode: .commonModes)
        ///
        YZYKLocationManager.share.startUpdatingLocation()
    }
    
    public func push() {
        var inset = scrollView.contentInset
        inset.top = 64
        scrollView.contentInset = inset
    }
    
    public func childVCDidEndDragging(_ offsetY: CGFloat) {
        let tabBar = self.tabBarController?.tabBar
        let navigationBar = self.navigationController?.navigationBar
        let IdentityBlock = { () ->Void in
            UIView.animate(withDuration: 0.25, animations: {
                var inset = self.scrollView.contentInset
                tabBar?.y = HEIGHT - 49
                navigationBar?.y = 20
                inset.top = 64
                self.scrollView.contentInset = inset
            })
        }
        let HiddenBlock = {
            UIView.animate(withDuration: 0.25, animations: {
                var inset = self.scrollView.contentInset
                tabBar?.y = HEIGHT + 39
                navigationBar?.y = -44
                inset.top = 0
                self.scrollView.contentInset = inset
            })
        }
        if up {
            if tabBar!.y >= HEIGHT - 19 {
                HiddenBlock()
            }else{
                IdentityBlock()
            }
        }else{
            if tabBar!.y <= HEIGHT - 19 {
                IdentityBlock()
            }else{
                HiddenBlock()
            }
        }
    }
    
    public func childVCDidScroll(_ offsetY: CGFloat,isHot: Bool) {
        let space = isHot ? hot_offsetY - offsetY : near_offsetY - offsetY
        let tabBar = self.tabBarController?.tabBar
        let navigationBar = self.navigationController?.navigationBar
        let maxY = isHot ? hot_offsetY : near_offsetY
        if offsetY > maxY {
            ///⬆️
            up = true
            if navigationBar!.y <= 20 {
                var inset = self.scrollView.contentInset
                if navigationBar!.y + space < -44 {
                    navigationBar!.y = -44
                }else{
                    navigationBar!.y += space
                }
                inset.top = navigationBar!.y + 44
                scrollView.contentInset = inset
            }
            
            if tabBar!.y >= HEIGHT - 49 {
                if tabBar!.y - space > HEIGHT + 39 {
                    tabBar!.y = HEIGHT + 39
                }else{
                    tabBar!.y -= space
                }
            }
        }else{
            ///⤵️
            up = false
            if navigationBar!.y < 20 {
                var inset = self.scrollView.contentInset
                if navigationBar!.y + space >= 20 {
                    navigationBar!.y = 20
                }else{
                    navigationBar!.y += space
                }
                inset.top = navigationBar!.y + 44
                scrollView.contentInset = inset
            }
            
            if tabBar!.y > HEIGHT - 49 {
                if tabBar!.y - space < HEIGHT - 49 {
                    tabBar!.y = HEIGHT - 49
                }else{
                    tabBar!.y -= space
                }
            }
        }
        if isHot {
            hot_offsetY = offsetY
        }else{
            near_offsetY = offsetY
        }
    }
    
    private func reloadData() {
        hotVC.reloadData()
        if nearVC.isViewLoaded {
            nearVC.reloadData()
        }
    }
//MARK: - YZYKHomeTopViewDelegate
    func homeTopViewBtnClick(_ type: YZYKHomeTopViewType) {
        let offset = CGPoint(x: CGFloat(type.rawValue - YZYKHomeTopViewType.hot.rawValue) * WIDTH, y: scrollView.contentOffset.y)
        scrollView.setContentOffset(offset, animated: true)
    }
//MARK: - UIScrollViewDelegate
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let index = Int(offsetX / WIDTH)
        topView.scroll(YZYKHomeTopViewType.hot.rawValue + index)
        ///
        let childVC = self.childViewControllers[index]
        if childVC.isViewLoaded || index != 1 {
            return
        }
        childVC.view.frame = CGRect(x: WIDTH, y: 0, width: WIDTH, height: HEIGHT)
        scrollView.addSubview(childVC.view)
    }
    
}
