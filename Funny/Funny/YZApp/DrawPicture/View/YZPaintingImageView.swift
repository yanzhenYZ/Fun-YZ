//
//  YZPaintingImageView.swift
//  Funny
//
//  Created by yanzhen on 17/1/4.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

protocol YZPaintingImageViewProtocol : NSObjectProtocol{
    func drawImage(_ image: UIImage)
}

class YZPaintingImageView: UIImageView, UIGestureRecognizerDelegate {

    weak var delegate: YZPaintingImageViewProtocol?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
        
        let pin = UIPinchGestureRecognizer(target: self, action: #selector(self.pinAction(_:)))
        pin.delegate = self
        self.addGestureRecognizer(pin)
        
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(self.rotationAction(_:)))
        rotation.delegate = self
        self.addGestureRecognizer(rotation)
    }
    
    public func startDrawPicture() {
        UIView.animate(withDuration: 0.5, animations: { 
            self.alpha = 0.3
        }) { (finish) in
            UIView.animate(withDuration: 0.5, animations: { 
                self.alpha = 1.0
            }, completion: { (finished) in
                let renderImage = self.getRenderImage()
                self.removeFromSuperview()
                self.delegate?.drawImage(renderImage)
            })
        }
    }
    
//MARK: - gesture
    @objc private func pinAction(_ pin: UIPinchGestureRecognizer) {
        self.transform = self.transform.scaledBy(x: pin.scale, y: pin.scale)
        pin.scale = 1
    }
    
    @objc private func rotationAction(_ rotation: UIRotationGestureRecognizer) {
        self.transform = self.transform.rotated(by: rotation.rotation)
        rotation.rotation = 0
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
