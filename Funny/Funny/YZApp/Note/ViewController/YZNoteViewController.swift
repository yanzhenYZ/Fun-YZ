//
//  YZNoteViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/5.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZNoteViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, YZNoteCollectionViewCellDelegate {

    @IBOutlet private weak var collectionView: UICollectionView!
    private var dataSource = [YZNoteModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "备忘录"
        collectionView.register(UINib(nibName: "YZNoteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "YZNoteCollectionViewCell")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "编辑", style: .plain, target: self, action: #selector(self.edit))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    private func reloadData() {
        dataSource.removeAll()
        dataSource.append(contentsOf: YZNoteManager.manager.allNotes())
        collectionView.reloadData()
    }
    
    @objc private func edit() {
        if  self.navigationItem.rightBarButtonItem?.title == "编辑" {
            self.navigationItem.rightBarButtonItem?.title = "完成"
        }else{
            self.navigationItem.rightBarButtonItem?.title = "编辑"
        }
        collectionView.reloadData()
    }
    
    @IBAction func addNewNote(_ sender: UIBarButtonItem) {
        let vc = YZNoteCreateViewController(note: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
//MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YZNoteCollectionViewCell", for: indexPath) as! YZNoteCollectionViewCell
        cell.configureCell(dataSource[indexPath.item], edit: self.navigationItem.rightBarButtonItem?.title == "编辑")
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.navigationItem.rightBarButtonItem?.title == "编辑" {
            let vc = YZNoteCreateViewController(note: dataSource[indexPath.item])
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (WIDTH - 15) * 0.5, height: ISIPAD ? 220 : 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let noteCell = cell as! YZNoteCollectionViewCell
        noteCell.animation()
    }
//YZNoteCollectionViewCellDelegate
    func deleteNote(_ noteCell: YZNoteCollectionViewCell) {
        let indexPath = collectionView.indexPath(for: noteCell)
        let note = dataSource[indexPath!.item]
        YZNoteManager.manager.deleteNote(note)
        dataSource.remove(at: indexPath!.item)
        collectionView.reloadData()
    }
    
}
