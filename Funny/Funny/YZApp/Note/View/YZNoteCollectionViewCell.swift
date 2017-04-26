//
//  YZNoteCollectionViewCell.swift
//  Funny
//
//  Created by yanzhen on 17/1/5.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

protocol YZNoteCollectionViewCellDelegate: NSObjectProtocol {
    func deleteNote(_ noteCell: YZNoteCollectionViewCell)
}

class YZNoteCollectionViewCell: UICollectionViewCell {

    public weak var delegate: YZNoteCollectionViewCellDelegate?
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var deleteBtn: UIButton!
    private var noteModel: YZNoteModel!
    public func configureCell(_ note: YZNoteModel, edit: Bool) {
        noteModel = note
        textView.text = note.title
        timeLabel.text = dateString(note.time)
        deleteBtn.isHidden = edit
    }

    public func animation() {
        if !noteModel.animated {
            self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
            UIView.animate(withDuration: 1, animations: { 
                self.layer.transform = CATransform3DMakeScale(1, 1, 1)
                self.noteModel.animated = true
            })
        }
    }
    
    @IBAction @objc private func deleteBtnClick(_ sender: UIButton) {
        delegate?.deleteNote(self)
        YZLog(1111)
    }
}
