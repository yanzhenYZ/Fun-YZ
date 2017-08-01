//
//  YZYKMyTableViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

private let dataSource = [["我的直播地址","我的好友"],["扫一扫"],["视频质量","美颜设置"],["声明"],["退出"]]
private let vcs = [["Funny.YZYKMyLiveAddressViewController","Funny.YZYKMyFriendsTableViewController"],["Funny.YZYKMyLiveAddressViewController"],["Funny.YZYKVideoQualityTableViewController","Funny.YZYKBeautyViewController"],["Funny.YZYKDeclarationViewController"],["EXIT"]]

class YZYKMyTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "我的"
        tableView.rowHeight = 50
        tableView.sectionFooterHeight = 25
        tableView.backgroundColor = UIColor(230, 230, 237)
    }

// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "YZYKMyTableViewController")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "YZYKMyTableViewController")
            cell?.accessoryType = .disclosureIndicator
        }
        cell?.textLabel?.text = dataSource[indexPath.section][indexPath.row]
        return cell!
    }
 
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 4 {
            self.tabBarController?.dismiss(animated: true, completion: nil)
            return
        }
        
        let vcClass = NSClassFromString(vcs[indexPath.section][indexPath.row]) as! UIViewController.Type
        var vc = vcClass.init()
        
        if indexPath.section == 1 {
            vc = YZQRScanningViewController(live: true)
        }
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
