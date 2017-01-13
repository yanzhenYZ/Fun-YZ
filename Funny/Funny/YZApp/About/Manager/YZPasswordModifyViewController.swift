//
//  YZPasswordModifyViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/9.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

enum YZPasswordType: Int {
    case Note
    case Manager
}

class YZPasswordModifyViewController: UIViewController {

    @IBOutlet private weak var password2TF: YZTextField!
    @IBOutlet private weak var password1TF: YZTextField!
    private var passwordType: YZPasswordType!
    init(_ type: YZPasswordType) {
        super.init(nibName: "YZPasswordModifyViewController", bundle: nil)
        passwordType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if passwordType == .Manager {
            password1TF.placeholder = "请输入4位管理员密码"
        }
    }

    @IBAction private func sureAction(_ sender: UIButton) {
        if password1TF.text?.length == 4 && password2TF.text == password1TF.text {
            if passwordType == .Manager {
                YZUserDefaultsManager.writeManagerPassword(password1TF.text!)
            }else if passwordType == .Note {
                YZUserDefaultsManager.writeNotePassword(password1TF.text!)
            }
            self.navigationController?.popViewController(animated: true)
        }else{
            let alert = UIAlertController(title: "警告", message: "输入密码有误，请重新输入", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .destructive, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
