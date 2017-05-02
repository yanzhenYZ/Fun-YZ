//
//  YZNetEaseViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/4.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZNetEaseViewController: YZSuperSecondViewController {

    var defaultURL: String!
    var pushURL: String!
    var key: String!
    var index: Int = 1
    private var dataSource = [YZNetEaseModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        netEaseRefresh()
        netRequestWithMJRefresh(.normal, baseView: nil)
    }

    private func netRequestWithMJRefresh(_ refreshType: MJRefresh, baseView: MJRefreshBaseView?) {
        let urlString = netEaseURL(refreshType)
        YZHttpManager.get(urlString, success: { (response) in
            let keyArray = response[self.key] as! Array<[String : AnyObject]>
            let models = YZNetEaseModel.mj_objectArray(withKeyValuesArray: keyArray)
            for (_,value) in models!.enumerated() {
                let model = value as! YZNetEaseModel
                if model.url~~ {
                    if model.url!.hasPrefix("http") {
                        self.dataSource.append(model)
                    }
                }
            }
            baseView?.endRefreshing()
            self.tableView.reloadData()
        }) { (error) in
            baseView?.endRefreshing()
            YZLog(error?.localizedDescription ?? "YZNetEaseVC---Fail")
        }
    }
    
    private func netEaseURL(_ refreshType: MJRefresh) ->String {
        if refreshType == .push {
            let urlString = pushURL + String(index * 20) + NetEaseDefaultFooterURL
//            index += 1
            index++
            return urlString
        }else{
            return defaultURL
        }
    }
    
    private func netEaseRefresh() {
        footer = MJRefreshFooterView.footer()
        footer?.scrollView = tableView
        unowned let blockSelf = self
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
        if model.imgextra~~ && model.imgextra!.count >= 2 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "YZNEPicturesTableViewCell") as? YZNEPicturesTableViewCell
            if cell == nil {
                cell = Bundle.main.loadNibNamed("YZNEPicturesTableViewCell", owner: nil, options: nil)?.last as? YZNEPicturesTableViewCell
            }
            cell?.configureCell(model)
            return cell!
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "YZNEPictureTableViewCell") as? YZNEPictureTableViewCell
            if cell == nil {
                cell = Bundle.main.loadNibNamed("YZNEPictureTableViewCell", owner: nil, options: nil)?.last as? YZNEPictureTableViewCell
            }
            cell?.configureCell(model)
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataSource[indexPath.row]
        if model.imgextra~~ && model.imgextra!.count >= 2 {
            return ISIPAD ? 200 : 125
        }else{
            return ISIPAD ? 150 : 90
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = dataSource[indexPath.row]
        let wvc  = YZNEWebViewController(urlString: model.url!)
        self.navigationController?.pushViewController(wvc, animated: true)
    }

}
