//
//  YZYKNearCollectionViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZYKNearCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var dataSource = [YZYingKeModel]()
    private var header: MJRefreshHeaderView?
    private var homeVC: YZYKHomeViewController! {
        get{
            return self.parent as! YZYKHomeViewController!
        }
    }
    
    deinit {
        header?.free()
    }
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let itemW = (WIDTH - 20) / 3
        layout.itemSize = CGSize(width: itemW, height: itemW * 1.25)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = YZColor(235, 246, 252)
        collectionView?.register(UINib(nibName: "YZYKNearCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "YZYKNearCollectionViewCell")
        header = MJRefreshHeaderView.header()
        header?.scrollView = collectionView
        unowned let blockSelf = self
        header?.beginRefreshingBlock = { (footerView) ->Void in
            blockSelf.reloadData()
        }
        reloadData()
    }

    public func reloadData() {
        var urlString = YK_Near_URL
        YZYKLocationManager.share.getLocationCoordinate2D { (locationServicesEnabled, latitude, longitude) in
            if locationServicesEnabled {
                urlString = "http://116.211.167.106/api/live/near_recommend?uid=133825214&latitude=" + latitude + "&longitude=" + longitude
            }
        }
        YZHttpManager.get(urlString, success: { (response) in
            let lives = response["lives"] as! Array<[String : AnyObject]>
            let models = YZYingKeModel.mj_objectArray(withKeyValuesArray: lives)
            self.dataSource.removeAll()
            for (_,value) in models!.enumerated() {
                let model = value as! YZYingKeModel
                self.dataSource.append(model)
            }
            self.header?.endRefreshing()
            self.collectionView?.reloadData()
        }) { (error) in
            self.header?.endRefreshing()
            print(error?.localizedDescription ?? "YZYKHotTableVC--Fail")
        }
    }


// MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YZYKNearCollectionViewCell", for: indexPath) as! YZYKNearCollectionViewCell
        cell.model = dataSource[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let ykCell = cell as! YZYKNearCollectionViewCell
        ykCell.animation()
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let player = YZYKPlayerViewController(dataSource[indexPath.row])
        homeVC.push()
        player.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(player, animated: true)
    }
    
//MARK: - UIScrollViewDelegate
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < 0 {
            return
        }
        homeVC.childVCDidEndDragging(scrollView.contentOffset.y)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            return
        }
        homeVC.childVCDidScroll(scrollView.contentOffset.y, isHot: true)
    }
}
