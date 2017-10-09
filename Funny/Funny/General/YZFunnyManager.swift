//
//  YZFunnyManager.swift
//  Funny
//
//  Created by yanzhen on 16/12/27.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit
import Kingfisher
import AVFoundation
import LocalAuthentication

class YZFunnyManager: NSObject {

    class func saveImage(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc class func image(_ image: UIImage,didFinishSavingWithError error: NSError?, contextInfo: AnyObject){
        let window = UIApplication.shared.keyWindow
        if error~~ {
            window?.showToast("保存失败")
        }else{
            YZProgressHud.showHud(window!, imgName: "Checkmark", message: "保存成功")
        }
    }
//MARK: password
    class func authentication(failed: (() ->Void)?,succeed:(() ->Void)?) {
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Use Touch ID to Login.", reply: { (success, error) in
                if success {
                    DispatchQueue.main.async(execute: {
                        succeed?()
                    })
                }else{
                    if Int32(error!._code) == kLAErrorUserFallback {
                        YZLog("User tapped Enter Password")
                    }else if Int32(error!._code) == kLAErrorUserCancel {
                        //手动取消
                        YZLog("User tapped Cancel")
                    }else{
                        //失败
                        YZLog("Authenticated failed")
                    }
                    DispatchQueue.main.async(execute: {
                        failed?()
                    })
                }
            })
        }
    }
    
//MARK: - Kingfisher
    class func clearCache() {
        let manager = KingfisherManager.shared
        manager.cache.clearMemoryCache()
    }
//    class func clearDisk(completion: @escaping (Void) ->Void) {
//    class func clearDisk(completion: @escaping () ->Void) {
//    class func clearDisk(completion: (() -> Swift.Void)? = nil) {
    class func clearDisk(completion: (() -> Swift.Void)?) {
        KingfisherManager.shared.cache.clearDiskCache {
            completion?()
        }
    }
    
    class func getDiskCacheSize(handler: @escaping (UInt) -> Void) {
        KingfisherManager.shared.cache.calculateDiskCacheSize { (size) in
            handler(size)
        }
    }
//MARK: - Audio and Video
    class func requestAccessForVideo(completionHandler handler: ((Bool) -> Swift.Void)?){
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted) in
                if granted {
                    YZLog("--用户开启摄像头--")
                }
                handler?(granted)
            })
        case .authorized:
            YZLog("--用户已开启摄像头--")
            handler?(true)
        default:
            YZLog("--用户拒绝开启摄像头--")
            handler?(false)
        }
    }
    
    class func requestAccessForAudio() {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.audio, completionHandler: { (granted) in
                if granted {
                    YZLog("--用户开启麦克风--")
                }
            })
        case .authorized:
            YZLog("--用户已开启麦克风--")
        default:
            YZLog("--用户拒绝开启麦克风--")
        }

    }
}
