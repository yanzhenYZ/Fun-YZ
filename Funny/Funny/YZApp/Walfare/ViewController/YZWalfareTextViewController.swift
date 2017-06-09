//
//  YZWalfareTextViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZWalfareTextViewController: YZWalfareViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func netRequestWithMJRefresh(_ refreshType: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = walfareURL(refreshType)
        YZHttpManager.get(urlString, success: { (response) in
            let items = response["items"] as! Array<[String : AnyObject]>
            let models = YZWalfareTextModel.mj_objectArray(withKeyValuesArray: items) as! [YZWalfareTextModel]
            for value in models {
                self.dataSource.append(YZWalfareTextFrame(value))
            }
            let textFrame = self.dataSource.last as! YZWalfareTextFrame
            self.max_timestamp = textFrame.textModel.update_time
            baseView?.endRefreshing()
            self.tableView.reloadData()
        }) { (error) in
            baseView?.endRefreshing()
            YZLog(error?.localizedDescription ?? "YZWalfareTextVC---Fail")
        }
    }
//MARK: - tableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "YZWalfareTextTableViewCell") as? YZWalfareTextTableViewCell
        if cell == nil {
            cell = YZWalfareTextTableViewCell(style:.default, reuseIdentifier:"YZWalfareTextTableViewCell")
        }
        cell?.configureCell(dataSource[indexPath.row] as! YZWalfareTextFrame)
        return cell!
    }

}
