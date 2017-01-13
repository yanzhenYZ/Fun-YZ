//
//  YZWalfareViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZWalfareViewController: YZSuperSecondViewController {

    public var dataSource = [YZSuperFrame]()
    var defaultURL: String!
    var pullHeaderURL: String!
    var pushHeaderURL: String!
    var latest_viewed_ts: String!
    var max_timestamp: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        walfareRefresh()
        netRequestWithMJRefresh(.normal, baseView: nil)
    }

    public func netRequestWithMJRefresh(_ refreshType: MJRefresh, baseView: MJRefreshBaseView?) {
        
    }
    
    func walfareURL(_ refreshType: MJRefresh) ->String {
        if refreshType == .push {
            return pushHeaderURL + max_timestamp + WalfarePushDefaultMiddleURL + latest_viewed_ts + WalfareDefaultFootURL
        }else{
            latest_viewed_ts = currentTime()
            return defaultURL
        }
    }
    
    private func walfareRefresh() {
        footer = MJRefreshFooterView.footer()
        footer?.scrollView = tableView
        unowned let blockSelf = self
        footer?.beginRefreshingBlock = {(baseView) ->Void in
            blockSelf.netRequestWithMJRefresh(.push, baseView: baseView)
        }
    }
//MARK: - tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource[indexPath.row].rowHeight
    }

}
