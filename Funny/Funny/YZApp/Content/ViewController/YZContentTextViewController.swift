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
                if model.group != nil {
                    let textFrame = YZContentTextFrame()
                    textFrame.contentModel = model
                    modelArray.append(textFrame)
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
            print(error?.localizedDescription ?? "YZContentTextVC---Fail")
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
