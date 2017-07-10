//
//  YZGifShowViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZGifShowViewController: YZSuperSecondViewController {

    var dataSource = [YZGifShowModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        tableView.rowHeight = (WIDTH - 100) / 3 * 4 + 77
        gifShowRefresh()
        netRequestWithMJRefresh(.push, baseView: nil)
    }

    private func gifShowRefresh() {
        header = MJRefreshHeaderView.header()
        footer = MJRefreshFooterView.footer()
        header?.scrollView = tableView
        footer?.scrollView = tableView
        weak var weakSelf = self
        header?.beginRefreshingBlock = {(baseView) ->Void in
            weakSelf?.netRequestWithMJRefresh(.pull, baseView: baseView)
        }
        footer?.beginRefreshingBlock = {(baseView) ->Void in
            weakSelf?.netRequestWithMJRefresh(.push, baseView: baseView)
        }
    }

    private func netRequestWithMJRefresh(_ refreshType: MJRefresh, baseView: MJRefreshBaseView?) {
        let parameters = [
            "os"         : "android",
            "client_key" : "3c2cd3f3",
            "last"       : "62",
            "count"      : "20",
            "token"      : "",
            "page"       : "1",
            "pcursor"    : "",
            "pv"         : "false",
            "mtype"      : "2",
            "type"       : "7",
            "sig"        : "030d2819371a88871dfdcef832f8d553",
            ]
        YZHttpManager.post(GifShowHeadURL, parameters: parameters, success: { (response) in
            let feeds = response["feeds"] as! Array<[String : AnyObject]>
            let models = YZGifShowModel.mj_objectArray(withKeyValuesArray: feeds) as! [YZGifShowModel]
            if refreshType == .pull {
                self.dataSource.insert(contentsOf: models, at: 0)
            }else{
                self.dataSource.append(contentsOf: models)
            }
            baseView?.endRefreshing()
            self.tableView.reloadData()
        }) { (error) in
            baseView?.endRefreshing()
            YZLog(error?.localizedDescription ?? "YZGifShowVC-Fail")
        }
    }
//MARK: - tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "YZGifShowTableViewCell") as? YZGifShowTableViewCell
        if cell == nil {
            cell = YZGifShowTableViewCell(style:.default, reuseIdentifier:"YZGifShowTableViewCell")
        }
        cell?.configCell(dataSource[indexPath.row])
        cell?.tableViewReloadData()
        return cell!
    }
}
