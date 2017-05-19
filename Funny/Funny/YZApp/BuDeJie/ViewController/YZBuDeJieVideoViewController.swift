//
//  YZBuDeJieVideoViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZBuDeJieVideoViewController: YZBuDeJieViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func budejieURL(_ refreshType: MJRefresh) -> String {
        if refreshType == .push {
            return BuDeJieVideoPushHeadURL + maxtime + BuDeJieVideoPushFootURL
        }else{
            return BuDeJieVideoDefaultURL
        }
    }
    
    override func netRequestWithMJRefresh(_ refreshType: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = budejieURL(refreshType)
        YZHttpManager.get(urlString, success: { (response) in
            let infoDict = response["info"] as! [String : AnyObject]
            self.maxtime = infoDict["maxtime"] as! String!
            ///
            let listArray = response["list"] as! Array<[String:AnyObject]>
            let models = YZBuDeJieVideoModel.mj_objectArray(withKeyValuesArray: listArray)
            for (_,value) in models!.enumerated() {
                let model = value as! YZBuDeJieVideoModel
                let videoFrame = YZBuDeJieVideoFrame()
                videoFrame.videoModel = model
                self.dataSource.append(videoFrame)
            }
            baseView?.endRefreshing()
            self.tableView.reloadData()
        }) { (error) in
            baseView?.endRefreshing()
            YZLog(error?.localizedDescription ?? "YZBuDeJieVideoVC---Fail")
        }
    }
//MARK: - tableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "YZBuDeJieVideoTableViewCell") as? YZBuDeJieVideoTableViewCell
        if cell == nil {
            cell = YZBuDeJieVideoTableViewCell(style:.default, reuseIdentifier:"YZBuDeJieVideoTableViewCell")
        }
        cell?.configureCell(dataSource[indexPath.row] as! YZBuDeJieVideoFrame)
        cell?.tableViewReloadData()
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoFrame = dataSource[indexPath.row] as! YZBuDeJieVideoFrame
        let wvc = YZBuDeJieWebViewController(urlString: videoFrame.videoModel.weixin_url)
        self.navigationController?.pushViewController(wvc, animated: true)
    }
}
