//
//  YZWalfareGirlViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZWalfareGirlViewController: YZWalfareViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func netRequestWithMJRefresh(_ refreshType: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = walfareURL(refreshType)
        YZHttpManager.get(urlString, success: { (response) in
            let items = response["items"] as! Array<[String : AnyObject]>
            let models = YZWalfareGirlModel.mj_objectArray(withKeyValuesArray: items) as! [YZWalfareGirlModel]
            for value in models{
                self.dataSource.append(YZWalfareGirlFrame(value))
            }
            let girlFrame = self.dataSource.last as! YZWalfareGirlFrame
            self.max_timestamp = girlFrame.girlModel.update_time
            baseView?.endRefreshing()
            self.tableView.reloadData()
        }) { (error) in
            baseView?.endRefreshing()
            YZLog(error?.localizedDescription ?? "YZWalfareGirlVC---Fail")
        }
    }
//MARK: - tableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "YZWalfareGirlTableViewCell") as? YZWalfareGirlTableViewCell
        if cell == nil {
            cell = YZWalfareGirlTableViewCell(style:.default, reuseIdentifier:"YZWalfareGirlTableViewCell")
        }
        cell?.configureCell(dataSource[indexPath.row] as! YZWalfareGirlFrame)
        return cell!
    }

}
