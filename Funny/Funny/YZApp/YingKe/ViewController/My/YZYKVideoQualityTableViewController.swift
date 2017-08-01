//
//  YZYKVideoQualityTableViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

private let dataSource = [["15帧-码率:500Kps","24帧-码率:800Kps","30帧-码率:800Kps"],["15帧-码率:800Kps","24帧-码率:800Kps","30帧-码率:800Kps"],["15帧-码率:1000Kps","24帧-码率:1200Kps","30帧-码率:1200Kps"]]

class YZYKVideoQualityTableViewController: UITableViewController {

    private var videoQuality: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "视频质量"
        videoQuality = Int(YZUserDefaultsManager.getVideoQuality())
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(self.saveAction))
        
        tableView.backgroundColor = UIColor(230, 230, 237)
        tableView.rowHeight = 50
        tableView.sectionFooterHeight = 25
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "YZYKVideoQualityTableVC")
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 50))
        label.text = "部分设备可能不支持其中一些格式"
        label.textAlignment = .center
        label.numberOfLines = 0
        tableView.tableFooterView = label
    }
    
    @objc private func saveAction() {
        YZUserDefaultsManager.saveVideoQuality(videoQuality)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func switchAction(_ sw: UISwitch) {
        videoQuality = sw.tag - 100
        tableView.reloadData()
    }
    
// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YZYKVideoQualityTableVC", for: indexPath)

        let sw = UISwitch()
        let tag = indexPath.section * 3 + indexPath.row
        sw.tag = tag + 100
        sw.addTarget(self, action: #selector(self.switchAction(_:)), for: .valueChanged)
        sw.isOn = tag == Int(videoQuality)
        cell.accessoryView = sw
        cell.textLabel?.text = dataSource[indexPath.section][indexPath.row]
        return cell
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        videoQuality = indexPath.section * 3 + indexPath.row
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ["360x640","540x960","720x1280"][section]
    }
}
