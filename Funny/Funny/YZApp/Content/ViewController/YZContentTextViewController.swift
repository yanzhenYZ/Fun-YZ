//
//  YZContentTextViewController.swift
//  Funny
//
//  Created by yanzhen on 16/12/26.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZContentTextViewController: YZContentSuperViewController {

    override var normalURLStr: String {
        get {
            return ContextTextHeadURL + currentTime() + ContextTextTailUrl
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
            let minTime = dataDict["min_time"] as! NSNumber
            let maxTime = dataDict["max_time"] as! NSNumber
            if refreshType == .normal {
                self.min_Time = String(minTime.intValue)
                self.max_Time = String(maxTime.intValue)
            }else if refreshType == .pull {
                self.max_Time = String(maxTime.intValue)
            }else{
                self.min_Time = String(minTime.intValue)
            }
            ///
            let dataArray = dataDict["data"] as! Array<[String : AnyObject]>
            
            let models = YZContentModel.mj_objectArray(withKeyValuesArray: dataArray) as! [YZContentModel]
            var modelArray = [YZSuperFrame]()
            for value in models {
                if value.group~~ {
                    modelArray.append(YZContentTextFrame(value))
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
            YZLog(error?.localizedDescription ?? "YZContentTextVC---Fail")
            baseView?.endRefreshing()
        }
    }
///MARK: tableView-
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "YZContentTextTableViewCell") as? YZContentTextTableViewCell
        if cell == nil {
            cell = YZContentTextTableViewCell(style:.default, reuseIdentifier:"YZContentTextTableViewCell")
            //            cell!.delegate = self
        }
        cell?.configureCell(textFrame: dataSource[indexPath.row] as! YZContentTextFrame)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let textFrame = dataSource[indexPath.row] as! YZContentTextFrame
        let wvc = YZContentWebViewController(urlString: textFrame.contentModel.group!.share_url!)
        self.navigationController?.pushViewController(wvc, animated: true)
    }
}
