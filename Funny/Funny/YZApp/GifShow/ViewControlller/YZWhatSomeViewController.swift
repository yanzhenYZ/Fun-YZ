//
//  YZWhatSomeViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZWhatSomeViewController: YZContentSuperViewController {

    override var normalURLStr: String {
        get {
            return SomeWhatDefaultPictureURL
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
                self.min_Time = String(minTime.intValue - 200)
            }
            ///
            let dataArray = dataDict["data"] as! Array<[String : AnyObject]>
            
            let models = YZWhatSomeModel.mj_objectArray(withKeyValuesArray: dataArray) as! [YZWhatSomeModel]
            var modelArray = [YZSuperFrame]()
            for value in models {
                if value.group~~ && value.group?.middle_image != nil {
                    modelArray.append(YZWhatSomeFrame(value))
                }
            }
            
            if modelArray.count > 0 {
                if refreshType == .pull {
                    //最后一个重复
                    modelArray.removeLast()
                    self.dataSource.insert(contentsOf: modelArray, at: 0)
                }else{
                    self.dataSource += modelArray
                }
            }
            
            baseView?.endRefreshing()
            self.tableView.reloadData()
        }) { (error) in
            baseView?.endRefreshing()
            YZLog(error?.localizedDescription ?? "YZWhatSomeVC---Fail")
        }
    }
//MARK: tableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "YZWhatSomeTableViewCell") as? YZWhatSomeTableViewCell
        if cell == nil {
            cell = YZWhatSomeTableViewCell(style:.default, reuseIdentifier:"YZWhatSomeTableViewCell")
        }
        cell?.configureCell(dataSource[indexPath.row] as! YZWhatSomeFrame)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pictureFrame = dataSource[indexPath.row] as! YZWhatSomeFrame
        let wvc = YZContentWebViewController(urlString: pictureFrame.model.group!.share_url!)
        self.navigationController?.pushViewController(wvc, animated: true)
    }

}
