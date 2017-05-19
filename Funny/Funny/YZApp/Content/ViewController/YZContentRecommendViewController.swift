//
//  YZContentRecommendViewController.swift
//  Funny
//
//  Created by yanzhen on 16/12/26.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZContentRecommendViewController: YZContentSuperViewController {

    override var normalURLStr: String {
        get {
            return ContentRecommendDefaultURL
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func netRequestWithMJRefresh(_ refreshType: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = getNetURLString(refreshType)
        
        YZHttpManager.get(urlString, success: { (response) in
            let dataDict = response["data"] as! [String : AnyObject]
            let minTime = dataDict["min_time"] as! Int
            let maxTime = dataDict["max_time"] as! Int
            if refreshType == .normal {
                self.min_Time = String(minTime)
                self.max_Time = String(maxTime)
            }else if refreshType == .pull {
                self.max_Time = String(maxTime)
            }else{
                self.min_Time = String(minTime)
            }
            ///
            let dataArray = dataDict["data"] as! Array<[String : AnyObject]>
            
            let models = YZContentModel.mj_objectArray(withKeyValuesArray: dataArray)
            var modelArray = [YZSuperFrame]()
            for (_,value) in models!.enumerated() {
                let model = value as! YZContentModel
                if model.group?.category_name == "搞笑视频" {
                    let videoFrame = YZContentVideoFrame()
                    videoFrame.contentModel = model
                    modelArray.append(videoFrame)
                }
            }
            if refreshType == .pull {
                self.dataSource.insert(contentsOf: modelArray, at: 0)
            }else{
                self.dataSource += modelArray
            }
            baseView?.endRefreshing()
            self.tableView.reloadData()
        }) { (error) in
            baseView?.endRefreshing()
            YZLog(error?.localizedDescription ?? "Fail")
        }
    }
///MARK: tableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "YZContentVideoTableViewCell") as? YZContentVideoTableViewCell
        if cell == nil {
            cell = YZContentVideoTableViewCell(style:.default, reuseIdentifier:"YZContentVideoTableViewCell")
        }
        cell?.configureCell(dataSource[indexPath.row] as! YZContentVideoFrame)
        cell?.tableViewReloadData()
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let videoFrame = dataSource[indexPath.row] as! YZContentVideoFrame
        let wvc = YZContentWebViewController(urlString: videoFrame.contentModel.group!.share_url!)
        self.navigationController?.pushViewController(wvc, animated: true)
    }
}
