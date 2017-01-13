//
//  YZDrawPictureViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/4.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZDrawPictureViewController: YZSuperViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, YZPaintingImageViewProtocol {

    @IBOutlet private weak var paintingView: YZPaintingView!
    private var dpImageView: YZPaintingImageView?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "画图"
    }

    @IBAction private func undo(_ sender: Any) {
        paintingView.undo()
    }
    
    @IBAction private func clear(_ sender: Any) {
        paintingView.clearScreen()
    }
    
    @IBAction private func eraser(_ sender: Any) {
        paintingView.lineColor = UIColor.white
    }
    
    @IBAction private func photo(_ sender: Any) {
        paintingView.clearScreen()
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }

    @IBAction private func startMark(_ sender: Any) {
        dpImageView?.startDrawPicture()
    }

    @IBAction private func save(_ sender: Any) {
        if !paintingView.isDrawInView() {
            return
        }
        YZFunnyManager.saveImage(paintingView.getRenderImage())
    }
    
    
    @IBAction private func slider(_ sender: UISlider) {
        paintingView.lineWidth = CGFloat(sender.value)
    }
    
    @IBAction private func colorBtnClick(_ sender: UIButton) {
        paintingView.lineColor = sender.backgroundColor!
    }
//MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        dpImageView = YZPaintingImageView(frame: paintingView.frame)
        dpImageView?.delegate = self
        dpImageView?.image = image
        self.view.addSubview(dpImageView!)
        paintingView.lineColor = UIColor.black
        self.dismiss(animated: true, completion: nil)
    }
//MARK: - YZPaintingImageViewProtocol
    func drawImage(_ image: UIImage) {
        paintingView.image = image
    }
}
