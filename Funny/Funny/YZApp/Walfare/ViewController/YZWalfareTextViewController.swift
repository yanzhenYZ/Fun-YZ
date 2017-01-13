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
            let models = YZWalfareTextModel.mj_objectArray(withKeyValuesArray: items)
            for (_,value) in models!.enumerated() {
                let model = value as! YZWalfareTextModel
                let textFrame = YZWalfareTextFrame()
                textFrame.textModel = model
                self.dataSource.append(textFrame)
            }
            let textFrame = self.dataSource.last as! YZWalfareTextFrame
            self.max_timestamp = textFrame.textModel.update_time
            baseView?.endRefreshing()
            self.tableView.reloadData()
        }) { (error) in
            baseView?.endRefreshing()
            print(error?.localizedDescription ?? "YZWalfareTextVC---Fail")
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
