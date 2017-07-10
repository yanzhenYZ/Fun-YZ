//
//  YZSuperSecondViewController.swift
//  Funny
//
//  Created by yanzhen on 16/12/26.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit

class YZSuperSecondViewController: YZSuperViewController, UITableViewProtocol {

    var header: MJRefreshHeaderView?
    var footer: MJRefreshFooterView?
    @IBOutlet weak var tableView: UITableView!
    
    deinit {
        header?.free()
        footer?.free()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    init() {
        super.init(nibName: "YZSuperSecondViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
