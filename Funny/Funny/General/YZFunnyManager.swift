//
//  YZFunnyManager.swift
//  Funny
//
//  Created by yanzhen on 16/12/27.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit
import AVKit
import LocalAuthentication

class YZFunnyManager: NSObject {

    class func saveImage(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    class func image(_ image: UIImage,didFinishSavingWithError error: NSError?, contextInfo: AnyObject){
        if error != nil {
            MBProgressHUD.showMessage("保存失败", success: false, stringColor: UIColor.red)
        }else{
            MBProgressHUD.showMessage("已保存到相册", success: true, stringColor: UIColor.red)
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
                        print("User tapped Enter Password")
                    }else if Int32(error!._code) == kLAErrorUserCancel {
                        //手动取消
                        print("User tapped Cancel")
                    }else{
                        //失败
                        print("Authenticated failed")
                    }
                    DispatchQueue.main.async(execute: {
                        failed?()
                    })
                }
            })
        }
    }
    
//MARK: - SDWebImage
    class func clearCache() {
        let manager = SDWebImageManager.shared()
        manager.cancelAll()
        manager.imageCache?.clearMemory()
    }
//    class func clearDisk(completion: @escaping (Void) ->Void) {
//    class func clearDisk(completion: @escaping () ->Void) {
//    class func clearDisk(completion: (() -> Swift.Void)? = nil) {
    class func clearDisk(completion: (() -> Swift.Void)?) {
        let manager = SDWebImageManager.shared()
        manager.imageCache?.clearDisk(onCompletion: {
            completion?()
        })
    }
    
    class func getDiskCacheSize() ->UInt{
        let manager = SDWebImageManager.shared()
        return manager.imageCache!.getSize()
    }
//MARK: - Audio and Video
    class func requestAccessForVideo(completionHandler handler: ((Bool) -> Swift.Void)?){
        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted) in
                if granted {
                    print("--用户开启摄像头--")
                }
                handler?(granted)
            })
            break
        case .authorized:
            print("--用户已开启摄像头--")
            handler?(true)
            break
        default:
            print("--用户拒绝开启摄像头--")
            handler?(false)
            break
        }
    }
    
    class func requestAccessForAudio() {
        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeAudio)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeAudio, completionHandler: { (granted) in
                if granted {
                    print("--用户开启麦克风--")
                }
            })
            break
        case .authorized:
            print("--用户已开启麦克风--")
            break
        default:
            print("--用户拒绝开启麦克风--")
            break
        }

    }
}
