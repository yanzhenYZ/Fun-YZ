//
//  YZBuDeJieViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZBuDeJieViewController: YZSuperSecondViewController {

    public var dataSource = [YZSuperFrame]()
    public var maxid: String!
    public var maxtime: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        budejieRefresh()
        netRequestWithMJRefresh(.normal, baseView: nil)
    }

    public func netRequestWithMJRefresh(_ refreshType: MJRefresh, baseView: MJRefreshBaseView?) {
        
    }
    
    public func budejieURL(_ refreshType: MJRefresh) ->String {
        return ""
    }
    
    private func budejieRefresh() {
        footer = MJRefreshFooterView.footer()
        footer?.scrollView = tableView
        footer?.beginRefreshingBlock = { [weak self] (baseView) ->Void in
            self?.netRequestWithMJRefresh(.push, baseView: baseView)
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
