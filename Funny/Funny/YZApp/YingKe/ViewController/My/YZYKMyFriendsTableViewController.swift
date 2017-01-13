//
//  YZYKMyFriendsTableViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZYKMyFriendsTableViewController: UITableViewController {

    private var dataSource = [YZYKDBModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的好友"
        tableView.rowHeight = 50
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "YZYKMyFriendsTableVC")
        dataSource.append(contentsOf: YZNoteManager.manager.allLives())
    }

// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YZYKMyFriendsTableVC", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = dataSource[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = YZYingKeModel()
        model.stream_addr = YK_Live_Header + dataSource[indexPath.row].liveAddress
        let player = YZYKPlayerViewController(model)
        self.navigationController?.pushViewController(player, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            YZNoteManager.manager.deleteLive(dataSource[indexPath.row])
            dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除好友"
    }
}
