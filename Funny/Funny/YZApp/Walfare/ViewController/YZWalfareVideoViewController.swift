//
//  YZWalfareVideoViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZWalfareVideoViewController: YZWalfareViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func netRequestWithMJRefresh(_ refreshType: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = walfareURL(refreshType)
        YZHttpManager.get(urlString, success: { (response) in
            let items = response["items"] as! Array<[String : AnyObject]>
            let models = YZWalfareVideoModel.mj_objectArray(withKeyValuesArray: items)
            for (_,value) in models!.enumerated() {
                let model = value as! YZWalfareVideoModel
                let videoFrame = YZWalfareVideoFrame()
                videoFrame.videoModel = model
                self.dataSource.append(videoFrame)
            }
            let videoFrame = self.dataSource.last as! YZWalfareVideoFrame
            self.max_timestamp = videoFrame.videoModel.update_time
            baseView?.endRefreshing()
            self.tableView.reloadData()
        }) { (error) in
            baseView?.endRefreshing()
            YZLog(error?.localizedDescription ?? "YZWalfareVideoVC---Fail")
        }
    }
//MARK: - tableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "YZWalfareVideoTableViewCell") as? YZWalfareVideoTableViewCell
        if cell == nil {
            cell = YZWalfareVideoTableViewCell(style:.default, reuseIdentifier:"YZWalfareVideoTableViewCell")
        }
        cell?.tableViewReloadData()
        cell?.configureCell(dataSource[indexPath.row] as! YZWalfareVideoFrame)
        return cell!
    }
}
