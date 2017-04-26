//
//  YZHttpManager.swift
//  Funny
//
//  Created by yanzhen on 16/12/23.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

//https://github.com/Alamofire/Alamofire
import UIKit
import Alamofire

//typealias HttpBlock = (Bool, [String : AnyObject]) -> Void

class YZHttpManager: NSObject {

    private var netManager: NetworkReachabilityManager!
    static let manager = YZHttpManager()
    private override init() {
        netManager = NetworkReachabilityManager();
    }
    
    func startMonitoring(wifi:@escaping (Bool) -> Void) {
        netManager.listener = { status in
            wifi(status == .reachable(.ethernetOrWiFi))
        }
        netManager.startListening()
    }
    
    class func get(_ urlString: String, success:(([String : AnyObject])->Void)?, failure:((Error?) ->Swift.Void)?) {
        Alamofire.request(urlString).responseJSON { (response) in
            if response.result.isSuccess {
                success?(response.result.value as! [String : AnyObject])
            }else{
                failure?(response.result.error)
                YZLog(response.result.error!.localizedDescription)
            }
        }
    }
    
    class func post(_ urlString: String, parameters: [String: Any]? = nil, success:(([String : AnyObject])->Void)?, failure:((Error?) ->Swift.Void)?) {
        Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                success?(response.result.value as! [String : AnyObject])
            }else {
                failure?(response.result.error)
            }
        }
    }
    
    //在方法中直接使用block
//    class func get(_ url: String, completionHandler: @escaping (Bool, Any?) -> Void) {
//        Alamofire.request(url).responseJSON { (response) in
//            completionHandler(response.result.isSuccess,response.result.value)
//        }
//    }
//
//    class func post(_ url: String, parameters: [String: Any]? = nil, completionHandler:@escaping (Bool, Any?) -> Void) {
//        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { (response) in
//            completionHandler(response.result.isSuccess,response.result.value)
//        }
//    }
}
