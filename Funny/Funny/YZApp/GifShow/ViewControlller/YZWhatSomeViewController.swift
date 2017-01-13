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
            
            let models = YZWhatSomeModel.mj_objectArray(withKeyValuesArray: dataArray)
            var modelArray = [YZSuperFrame]()
            for (_,value) in models!.enumerated() {
                let model = value as! YZWhatSomeModel
                if model.group != nil && model.group?.middle_image != nil {
                    let pictureFrame = YZWhatSomeFrame()
                    pictureFrame.model = model
                    modelArray.append(pictureFrame)
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
            print(error?.localizedDescription ?? "YZWhatSomeVC---Fail")
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
