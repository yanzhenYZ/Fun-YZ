//
//  YZSettingTableViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/9.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZSettingTableViewController: UITableViewController {

    private var dataSource = [["隐私设置"]]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "设置"
        tableView.rowHeight = 50
        tableView.sectionFooterHeight = 25.0
        tableView.backgroundColor = UIColor(230, 230, 237)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "YZSettingTableViewController")
        ///
        let tableHeaderView = UIView()
        tableHeaderView.height = 25.0
        tableHeaderView.backgroundColor = UIColor(230, 230, 237)
        tableView.tableHeaderView = tableHeaderView
    }

    
// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YZSettingTableViewController", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = dataSource[indexPath.section][indexPath.row]
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(230, 230, 237)
        return footerView
    }

}
