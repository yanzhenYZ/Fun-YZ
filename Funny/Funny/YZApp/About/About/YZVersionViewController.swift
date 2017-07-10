//
//  YZVersionViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/9.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit
import YZUIKit

private let VERSIONIVPATH = Document + "/VersionAbout/image.data"

class YZVersionViewController: UIViewController, UIViewControllerPreviewingDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet private weak var versionLabel: UILabel!
    @IBOutlet private weak var aboutImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "关于"
        self.registerForPreviewing(with: self as UIViewControllerPreviewingDelegate, sourceView: view)
        
        aboutImageView.image = #imageLiteral(resourceName: "aboutFunny")
        if let headImage = UIImage(contentsOfFile: VERSIONIVPATH) {
            aboutImageView.image = headImage
        }

        versionLabel.text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String?
    }
//MARK: UIImagePickerController    
    @IBAction func longGestureAction(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
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
        aboutImageView.image = image
        let data = UIImageJPEGRepresentation(image, 1)
        let path = Document + "/VersionAbout"
        if !FileManager.default.fileExists(atPath: path) {
            try? FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        NSData(data: data!).write(toFile: VERSIONIVPATH, atomically: true)
    }

    
    
//MARK: - UIViewControllerPreviewingDelegate
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        return YZNewVersionViewController()
    }
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.show(viewControllerToCommit, sender: self)
    }
    

}
