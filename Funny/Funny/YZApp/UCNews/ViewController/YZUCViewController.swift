//
//  YZUCViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZUCViewController: YZSuperSecondViewController {

    var headerURL: String!
    var middleURL: String!
    var footerURL: String!
    private var dataSource = [YZUCNewsModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        ucRefresh()
        netRequestWithMJRefresh(.normal, baseView: nil)
    }

    private func netRequestWithMJRefresh(_ refreshType: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = ucURL(refreshType)
        YZHttpManager.get(urlString, success: { (response) in
            let dataDict = response["data"] as! [String : AnyObject]
            let articles = dataDict["articles"] as! [String : [String : AnyObject]]
            var models = [YZUCNewsModel]()
            for value in articles {
                let model = YZUCNewsModel.mj_object(withKeyValues: value)
                if (model?.thumbnails?.count)! > 0 {
                    models.append(model!)
                }
            }
            
            if refreshType == .pull {
                self.dataSource.insert(contentsOf: models, at: 0)
            }else{
                self.dataSource.append(contentsOf: models)
            }
            baseView?.endRefreshing()
            self.tableView.reloadData()
        }) { (error) in
            baseView?.endRefreshing()
            YZLog(error?.localizedDescription ?? "YZUCViewController-Fail")
        }
    }
    
    private func ucURL(_ refreshType: MJRefresh) ->String {
        let current = Int(currentTime())! * 1000
        if refreshType == .normal {
            return headerURL + "0" + middleURL + String(current) + footerURL
        }else{
            return headerURL + "" + String(current) + middleURL + String(current + 35) + footerURL
        }
    }
    
    private func ucRefresh() {
        header = MJRefreshHeaderView.header()
        footer = MJRefreshFooterView.footer()
        header?.scrollView = tableView
        footer?.scrollView = tableView
        unowned let blockSelf = self
        header?.beginRefreshingBlock = {(baseView) ->Void in
            blockSelf.netRequestWithMJRefresh(.pull, baseView: baseView)
        }
        footer?.beginRefreshingBlock = {(baseView) ->Void in
            blockSelf.netRequestWithMJRefresh(.push, baseView: baseView)
        }
    }
//MARK: - tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]
        if model.thumbnails!.count >= 3 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "YZUCPicturesTableViewCell") as? YZUCPicturesTableViewCell
            if cell == nil {
                cell = Bundle.main.loadNibNamed("YZUCPicturesTableViewCell", owner: nil, options: nil)?.last as? YZUCPicturesTableViewCell
            }
            cell?.configureCell(model)
            return cell!
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "YZUCPictureTableViewCell") as? YZUCPictureTableViewCell
            if cell == nil {
                cell = Bundle.main.loadNibNamed("YZUCPictureTableViewCell", owner: nil, options: nil)?.last as? YZUCPictureTableViewCell
            }
            cell?.configureCell(model)
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataSource[indexPath.row]
        if model.thumbnails!.count >= 3 {
            return ISIPAD ? 200 : 123
        }else{
            return ISIPAD ? 150 : 80
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = dataSource[indexPath.row]
        let wvc  = YZWebViewController(urlString: model.url)
        self.navigationController?.pushViewController(wvc, animated: true)
    }
    
}
