//
//  YZContentSuperViewController.swift
//  Funny
//
//  Created by yanzhen on 16/12/26.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZContentSuperViewController: YZSuperSecondViewController {

    var max_Time: String = "1"
    var min_Time: String = "1"
    var pullHeaderStr: String!
    var pullFooterStr: String!
    var pushHeaderStr: String!
    var pushFooterStr: String!
    var dataSource = [YZSuperFrame]()
    public var normalURLStr: String {
        get {
            return ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        configureMJRefresh()
        self.netRequestWithMJRefresh(.normal, baseView: nil)
    }

    func netRequestWithMJRefresh(_ refreshType: MJRefresh, baseView: MJRefreshBaseView?) {
        
    }
    
    func getNetURLString(_ refreshType: MJRefresh) ->String {
        if refreshType == .pull {
            return pullHeaderStr + max_Time + pullFooterStr
        }else if refreshType == .push {
            return pushHeaderStr + min_Time + pushFooterStr
        }else {
            return normalURLStr
        }
    }
    
    private func configureMJRefresh() {
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
//MARK: tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return dataSource[indexPath.row].rowHeight
    }
}
