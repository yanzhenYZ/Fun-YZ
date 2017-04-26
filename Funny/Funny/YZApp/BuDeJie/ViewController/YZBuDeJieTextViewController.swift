//
//  YZBuDeJieTextViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZBuDeJieTextViewController: YZBuDeJieViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func budejieURL(_ refreshType: MJRefresh) -> String {
        if refreshType == .push {
            return BuDeJieTextPushHeaderURL + maxid + BuDeJieTextPushFooterURL
        }else{
            return BuDeJieTextUrl
        }
    }
    
    override func netRequestWithMJRefresh(_ refreshType: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = budejieURL(refreshType)
        YZHttpManager.get(urlString, success: { (response) in
//            let responseDict = response as! [String : AnyObject]
            let infoDict = response["info"] as! [String : AnyObject]
            self.maxid = infoDict["maxid"] as! String!
            ///
            let listArray = response["list"] as! Array<[String:AnyObject]>
            let models = YZBuDeJieTextModel.mj_objectArray(withKeyValuesArray: listArray)
            for (_,value) in models!.enumerated() {
                let model = value as! YZBuDeJieTextModel
                let textFrame = YZBuDeJieTextFrame()
                textFrame.textModel = model
                self.dataSource.append(textFrame)
            }
            baseView?.endRefreshing()
            self.tableView.reloadData()
        }) { (error) in
            baseView?.endRefreshing()
            YZLog(error?.localizedDescription ?? "YZBuDeJieTextVV---Fail")
        }
    }
//MARK: - tableView
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "YZBuDeJieTextTableViewCell") as? YZBuDeJieTextTableViewCell
        if cell == nil {
            cell = YZBuDeJieTextTableViewCell(style:.default, reuseIdentifier:"YZBuDeJieTextTableViewCell")
        }
        cell?.configureCell(dataSource[indexPath.row] as! YZBuDeJieTextFrame)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let textFrame = dataSource[indexPath.row] as! YZBuDeJieTextFrame
        let wvc = YZBuDeJieWebViewController(urlString: textFrame.textModel.weixin_url)
        self.navigationController?.pushViewController(wvc, animated: true)
    }
}
