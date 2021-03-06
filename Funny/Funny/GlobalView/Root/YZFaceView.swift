//
//  YZFaceView.swift
//  Funny
//
//  Created by yanzhen on 17/3/3.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit
import AVFoundation

class YZFaceView: UIView {

    private var session: AVCaptureSession?
    override init(frame: CGRect) {
        super.init(frame: frame)
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = frame;
        self.addSubview(effectView)
    }
    
    public func startRunning() {
        if session~~ {
            if !session!.isRunning {
                session!.startRunning()
            }
            return
        }
        let device = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: AVMediaType.video, position: .front)
        let input = try? AVCaptureDeviceInput.init(device: device!)
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSession.Preset.high
        if session!.canAddInput(input!) {
            session?.addInput(input!)
        }
        let previewLayer = AVCaptureVideoPreviewLayer(session: session!)
        previewLayer.frame = self.bounds
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.backgroundColor = UIColor.clear.cgColor
        self.layer.insertSublayer(previewLayer, at: 0)
        session?.startRunning()
    }
    
    public func stopRunning() {
        session?.stopRunning()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
