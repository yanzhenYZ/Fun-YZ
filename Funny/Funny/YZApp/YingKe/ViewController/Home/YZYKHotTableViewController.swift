//
//  YZYKHotTableViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZYKHotTableViewController: UITableViewController {

    private var dataSource = [YZYingKeModel]()
    private var header: MJRefreshHeaderView!
    private var homeVC: YZYKHomeViewController! {
        get{
            return self.parent as! YZYKHomeViewController!
        }
    }
    
    deinit {
        header.free()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = ISIPAD ? 644 : 420
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "YZYKHotTableViewCell", bundle: nil), forCellReuseIdentifier: "YZYKHotTableViewCell")
        
        header = MJRefreshHeaderView.header()
        header.scrollView = tableView
        unowned let blockSelf = self
        header.beginRefreshingBlock = { (footerView) ->Void in
            blockSelf.reloadData()
        }
        reloadData()
    }

    public func reloadData() {
        YZHttpManager.get(YK_Hot_URL, success: { (response) in
            let lives = response["lives"] as! Array<[String : AnyObject]>
            let models = YZYingKeModel.mj_objectArray(withKeyValuesArray: lives)
            self.dataSource.removeAll()
            for (_,value) in models!.enumerated() {
                let model = value as! YZYingKeModel
                self.dataSource.append(model)
            }
            self.header.endRefreshing()
            self.tableView.reloadData()
        }) { (error) in
            self.header.endRefreshing()
            YZLog(error?.localizedDescription ?? "YZYKHotTableVC--Fail")
        }
        
    }

// MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YZYKHotTableViewCell", for: indexPath) as! YZYKHotTableViewCell
        cell.configureCell(dataSource[indexPath.row])
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
