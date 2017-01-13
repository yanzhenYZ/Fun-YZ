//
//  YZNoteCreateViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/5.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZNoteCreateViewController: UIViewController {

    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var textBottomConstraint: NSLayoutConstraint!
    private var noteModel: YZNoteModel?
    
    init(note: YZNoteModel?) {
        super.init(nibName: "YZNoteCreateViewController", bundle: nil)
        noteModel = note
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "笔记"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(self.saveNote))
        textView.becomeFirstResponder()
        if noteModel != nil {
            textView.text = noteModel?.title
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboartChanged(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboartChanged(_:)), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboartChanged(_:)), name: .UIKeyboardDidChangeFrame, object: nil)
    }

    @objc private func keyboartChanged(_ note: Notification) {
        let keyboardFrame = (note.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        UIView.animate(withDuration: 0.25) { 
            self.textBottomConstraint.constant = HEIGHT - keyboardFrame.origin.y
        }
    }
    
    @objc private func saveNote() {
        if textView.text.isEmpty {
            let alert = UIAlertController(title: "提示", message: "输入内容为空，请重新输入", preferredStyle: .alert)
            let action = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if noteModel != nil {
            if noteModel?.title != textView.text {
                noteModel?.title = textView.text
                YZNoteManager.manager.updateNote(noteModel!)
            }
        }else{
            let note = YZNoteModel(noteTitle: textView.text, noteTime: Int(Date().timeIntervalSince1970))
            YZNoteManager.manager.addNote(note)
        }
        self.navigationController?.popViewController(animated: true)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
