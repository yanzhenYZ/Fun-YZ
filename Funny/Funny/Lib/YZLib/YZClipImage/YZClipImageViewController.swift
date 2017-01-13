//
//  YZClipImageViewController.swift
//  Funny
//
//  Created by yanzhen on 17/1/7.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

typealias ClipDoneBlock = (_ image: UIImage) ->Void

class YZClipImageViewController: UIViewController, UIScrollViewDelegate {

    private var image: UIImage!
    private var backView: UIView!
    private var scrollView: UIScrollView!
    private var imageView: UIImageView!
    private var maskView: YZClipImageMaskView!
    private var saveBlock: ClipDoneBlock!
    init(image: UIImage, block: @escaping ClipDoneBlock) {
        super.init(nibName: nil, bundle: nil)
        self.image = image
        saveBlock = block
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.black
        ///
        backView = UIView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: WIDTH))
        backView.center = CGPoint(x: WIDTH * 0.5, y: HEIGHT * 0.5)
        view.addSubview(backView)
        ///
        scrollView = UIScrollView(frame: backView.bounds)
        scrollView.clipsToBounds = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.maximumZoomScale = 5
        ///=1.0时没有弹性的效果
        scrollView.minimumZoomScale = 1.01
        scrollView.delegate = self
        backView.addSubview(scrollView)
        ///
        var imageW = image.size.width
        var imageH = image.size.height
        let scale: CGFloat = WIDTH / imageW
        imageW *= scale
        imageH *= scale
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageW, height: imageH))
        imageView.image = image
        scrollView.addSubview(imageView)
        scrollView.setZoomScale(1.01, animated: true)
        ///**imageView坐标必须以(0, 0)开始(保证拖动imageView可以回到scrollView边界内)**
        ///调整imageView在scrollView的中心，只能通过设置--contentOffset
        scrollView.contentOffset = CGPoint(x: (imageView.width - scrollView.width) * 0.5, y: (imageView.height - scrollView.height) * 0.5)
        maskView = YZClipImageMaskView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT), clipFrame: backView.frame)
        view.addSubview(maskView)
        ///
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "使用", style: .plain, target: self, action: #selector(self.saveAction))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(self.cancelAction))
    }
    
    @objc private func cancelAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveAction() {
        saveBlock(backView.getRenderImage())
        self.dismiss(animated: true, completion: nil)
    }
//MARK: - UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }


}
