//
//  YZUserDefaultsManager.swift
//  Funny
//
//  Created by yanzhen on 17/1/10.
//  Copyright © 2017年 Y&Z. All rights reserved.
//

import UIKit

class YZUserDefaultsManager: NSObject {
    
    class func getBrightLevel() ->Float {
        let ud = UserDefaults.standard
        let brightLevel = ud.object(forKey: "YK_BrightLevel")
        return brightLevel~~ ? (brightLevel as! Float) / 10 : 0.5
    }
    
    class func saveBrightLevel(_ brightLevel: Float) {
        let ud = UserDefaults.standard
        ud.set(brightLevel, forKey: "YK_BrightLevel")
        ud.synchronize()
    }
    
    class func getBeautyLevel() ->Float {
        let ud = UserDefaults.standard
        let beautyLevel = ud.object(forKey: "YK_BeautyLevel")
        return beautyLevel~~ ? (beautyLevel as! Float) / 10 : 0.5
    }
    
    class func saveBeautyLevel(_ beautyLevel: Float) {
        let ud = UserDefaults.standard
        ud.set(beautyLevel, forKey: "YK_BeautyLevel")
        ud.synchronize()
    }
    
    class func getVideoQuality() ->UInt {
        let ud = UserDefaults.standard
        let quality = ud.object(forKey: "YZYK_VideoQuality")
        if quality == nil {
            return 5
        }else{
            return quality as! UInt - 100
        }
    }
    
    class func saveVideoQuality(_ quality: Int) {
        let ud = UserDefaults.standard
        ud.set(quality + 100, forKey: "YZYK_VideoQuality")
        ud.synchronize()
    }
    
    class func getSelfLiveAddress() ->String {
        let ud = UserDefaults.standard
        var address = ud.object(forKey: "YZYK_SelfLiveAddress")
        if address~~ {
            return address as! String
        }else{
            address = currentTime() + "_" + NSUUID().uuidString
            saveSelfLiveAddress(address as! String)
            return address as! String
        }
    }
    
    class func saveSelfLiveAddress(_ address: String) {
        let ud = UserDefaults.standard
        ud.setValue(address, forKey: "YZYK_SelfLiveAddress")
        ud.synchronize()
    }
//MARK: - password
    class func writeNotePassword(_ password: String) {
        let ud = UserDefaults.standard
        ud.setValue(password, forKey: "note_password")
        ud.synchronize()
    }
    
    class func getNotePassword() ->String {
        let notePassword = UserDefaults.standard.object(forKey: "note_password")
        return notePassword~~ ? notePassword as! String : "1234"
    }
    
    class func writeManagerPassword(_ password: String) {
        let ud = UserDefaults.standard
        ud.setValue(password, forKey: "manager_password")
        ud.synchronize()
    }
    
    class func getManagerPassword() ->String {
        let notePassword = UserDefaults.standard.object(forKey: "manager_password")
        return notePassword~~ ? notePassword as! String : "1234"
    }

}
