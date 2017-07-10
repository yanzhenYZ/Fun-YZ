//
//  YZAboutInfoTableViewController.swift
//  Funny
//
//  Created by yanzhen on 16/12/26.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit
import YZUIKit

private let ABOUTHEADHEIGHT: CGFloat = ISIPAD ? 400 : 290
private let HEADIVPATH = Document + "/AboutHeadImage/image.data"

class YZAboutInfoTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private var headImageView: UIImageView!
    private var dataSource = ["清除缓存","设置","管理","声明","关于"]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "clear"), for: .default)
        self.navigationController?.navigationBar.shadowImage = #imageLiteral(resourceName: "clear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "我的"
        automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = YZColor(247, 247, 247)
        ///headView
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: ABOUTHEADHEIGHT))
        headImageView = UIImageView(frame: headView.bounds)
        headImageView.contentMode = .scaleAspectFill
        headImageView.clipsToBounds = true
        headImageView.image = #imageLiteral(resourceName: "Ais")
        if let headImage = UIImage(contentsOfFile: HEADIVPATH) {
            headImageView.image = headImage
        }
        headView.addSubview(headImageView)
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longGestureAction(_:)))
        headView.addGestureRecognizer(longGesture)
        tableView.tableHeaderView = headView
        tableView.rowHeight = 63
        ///footerView
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 60))
        footerView.backgroundColor = UIColor.clear
        
        let exitBtn = UIButton(frame: CGRect(x: 0, y: 10, width: WIDTH, height: 50))
        exitBtn.backgroundColor = UIColor.white
        exitBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        exitBtn.setTitle("退出", for: .normal)
        exitBtn.setTitleColor(YZColor(255, 133, 25), for: .normal)
        exitBtn.addTarget(self, action: #selector(self.exitVC), for: .touchUpInside)
        footerView.addSubview(exitBtn)
        tableView.tableFooterView = footerView
    }
    
    @objc private func exitVC() {
        exit(0)
    }
    
    private func diskSize() ->String {
        let size = YZFunnyManager.getDiskCacheSize()
        return String(format: "%.2fMB", CGFloat(size) / 1000 / 1000.0)
    }

// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "YZAboutInfoTableViewController")

        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "YZAboutInfoTableViewController")
            cell?.accessoryType = .disclosureIndicator
            cell?.detailTextLabel?.textColor = YZColor(255, 133, 25)
        }
        if indexPath.row == 0 {
            cell?.detailTextLabel?.text = diskSize()
        }
        cell?.textLabel?.text = dataSource[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            YZFunnyManager.clearDisk(completion: { 
                tableView.reloadData()
            })
        }else{
            let vcs = ["Funny.YZSettingTableViewController","Funny.YZManagerLockViewController","Funny.YZDeclartionViewController","Funny.YZVersionViewController"]
            let vcClass = NSClassFromString(vcs[indexPath.row - 1]) as! UIViewController.Type
            self.navigationController?.pushViewController(vcClass.init(), animated: true)
        }
    }
//MARK: - scrollViewDelegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            let scale = 1 - offsetY / ABOUTHEADHEIGHT
            headImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            var rect = headImageView.frame
            rect.origin.y = offsetY
            headImageView.frame = rect
        }
    }
//MARK: UIImagePickerController
    @objc private func longGestureAction(_ longGesture: UILongPressGestureRecognizer) {
        if longGesture.state == .began {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        if ISIPAD {
            saveHeadImage(image)
        }else{
            let vc = YZClipImageViewController(image: image, block: { [weak self] (doneImage) in
                self?.saveHeadImage(doneImage)
            })
            picker.pushViewController(vc, animated: true)
        }
    }
    
    private func saveHeadImage(_ image: UIImage) {
        headImageView.image = image
        let data = UIImageJPEGRepresentation(image, 1)
        let path = Document + "/AboutHeadImage"
        if !FileManager.default.fileExists(atPath: path) {
            try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        NSData(data: data!).write(toFile: HEADIVPATH, atomically: true)
    }
}
