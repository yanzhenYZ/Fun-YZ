//
//  AppDelegate.swift
//  Funny
//
//  Created by yanzhen on 16/12/22.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

import UIKit
import YZPlayer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var avWindow: YZAVWindow = {
        let avW = YZAVWindow(frame: CGRect(x: 0, y: 0, width: WIDTH, height: WIDTH / 4 * 3))
        let color = UIColor(colorLiteralRed: 1.0, green: 155 / 255.0, blue: 23 / 255.0, alpha: 1)
        let attributes = [NSForegroundColorAttributeName : color, NSFontAttributeName : UIFont(name: "IowanOldStyle-BoldItalic", size: 18)!]
        let mark = YZAVMark("Y&Z TV", rect: CGRect(x: 5, y: 5, width: 120, height: 40), attrs: attributes)
        avW.mark(mark)
        avW.setImageName("WindowViewPause", close: "closeWindowView")
//        avW.isHidden = true
//        avW.makeKeyAndVisible()
        return avW
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        let vc = YZRootViewController();
        let nvc = UINavigationController(rootViewController: vc)
        window?.rootViewController = nvc

        configureAppearance()
        configureMJExtension()
        configure3DTouch()
        WXApi.registerApp("wxe3eede5106905cd7")
        YZHttpManager.manager.startMonitoring { (wifi) in
            if !wifi {
                self.notConnectWifi()
            }
        }
        
        window?.makeKeyAndVisible()
        return true
    }
    
    private func configure3DTouch() {
        let types = ["106","100","902"]
        let titles = ["直播","内涵段子","扫一扫"]
        let icons = [UIApplicationShortcutIconType.captureVideo,UIApplicationShortcutIconType.play,UIApplicationShortcutIconType.shuffle]
        var items = [UIApplicationShortcutItem]()
        for i in 0...2 {
            let icon = UIApplicationShortcutIcon(type: icons[i])
            let item = UIApplicationShortcutItem(type: types[i], localizedTitle: titles[i], localizedSubtitle: nil, icon: icon, userInfo: nil)
            items.append(item)
        }
        UIApplication.shared.shortcutItems = items
    }
    
    private func configureAppearance() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.tintColor = FunnyColor
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : FunnyColor]
        let tabBar = UITabBar.appearance()
        tabBar.tintColor = FunnyColor
    }
    
    private func configureMJExtension() {
        NSObject.mj_setupReplacedKey { () -> [AnyHashable : Any]? in
            return ["ID" : "id"]
        }
        
        YZContentGroup.mj_setupReplacedKey { () -> [AnyHashable : Any]? in
            return ["video_720p" : "720p_video"]
        }
    }
    
    private func notConnectWifi() {
        let alert = UIAlertController(title: "警告", message: "您当前处于非WiFi状态", preferredStyle: .alert);
        let action = UIAlertAction(title: "确定", style: .default, handler: nil);
        alert.addAction(action)
        let rootNVC = self.window?.rootViewController as! UINavigationController;
        if let currentVC = rootNVC.presentedViewController {
            currentVC.present(alert, animated: true, completion: nil);
        }else{
            rootNVC.present(alert, animated: true, completion: nil);
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme == "YZFunny" {
            let subStrings = url.absoluteString.components(separatedBy: "//")
            widgetIntoVC(Int(subStrings[1])!)
        }
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        widgetIntoVC(Int(shortcutItem.type)!)
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        YZFunnyManager.clearCache()
    }

    private func widgetIntoVC(_ tag: Int) {
        let rootNVC = self.window?.rootViewController as! UINavigationController
        //程序未启动通过3DTouch---使用storyBoard这里会崩溃？？？
        let rootVC = rootNVC.viewControllers.first as! YZRootViewController
        rootVC.widgetIntoViewController(tag)

//        rootVC.dismiss(animated: true, completion: nil)
    }
}

