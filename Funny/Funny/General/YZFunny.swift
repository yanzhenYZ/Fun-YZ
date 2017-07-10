//
//  YZFunny.swift
//  Funny
//
//  Created by yanzhen on 16/12/22.
//  Copyright © 2016年 Y&Z. All rights reserved.
//

let WIDTH  = UIScreen.main.bounds.size.width
let HEIGHT = UIScreen.main.bounds.size.height;
let ISIPAD = UI_USER_INTERFACE_IDIOM() == .pad;
let FunnyColor = UIColor(red: 1.0, green: 133 / 255.0, blue: 25 / 255.0, alpha: 1.0)
let CGRectScreen = CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT)
let CGRectZero = CGRect(x: 0, y: 0, width: 0, height: 0)
let CGPointZero = CGPoint.zero
//MARK: - 
let CONTENTSPACE: CGFloat = 5.0
let COMMENTVIEWSPACE: CGFloat = 60.0
let USERVIEWHEIGHT: CGFloat = 60.0

let OTHERUSERTEXTLABELFONT: CGFloat = 17.0
let USERNAMELABELFONT: CGFloat = 17.0
let CREATTIMELABELFONT: CGFloat = 14.0
let USERTEXTMAINLABELFONT: CGFloat = 20.0

let Document = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!

//MARK: typealias
typealias int = Int;
typealias UITableViewProtocol = UITableViewDataSource & UITableViewDelegate

//MARK: Enum
enum YZAPPNAME: Int {
    case Content = 100
    case GifShow
    case BuDeJie
    case Walfare
    case UC
    case NetEsae
    case YingKe
    case Draw    = 900
    case Note
    case QR
    case Zipai
}

let FunnyApp: [Int : String] = [
    100 : "Funny.YZContentTabBarViewController",
    101 : "Funny.YZGifShowTabBarViewController",
    102 : "Funny.YZBuDeJieTabBarViewController",
    103 : "Funny.YZWalfareTabBarViewController",
    104 : "Funny.YZUCTabBarViewController",
    105 : "Funny.YZNetEaseTabBarViewController",
    106 : "Funny.YZYKTabBarViewController",
    900 : "Funny.YZDrawPictureViewController",
    901 : "Funny.YZNoteLockedViewController",
    902 : "Funny.YZQRViewController",
    903 : "Funny.YZMPViewController"
]

enum MJRefresh : Int {
    case pull = -1
    case normal
    case push
}
//MARK: Func
func YZColor(_ R: CGFloat, _ G: CGFloat, _ B: CGFloat) ->UIColor {
    return UIColor(red: R / 255.0, green: G / 255.0, blue: B / 255.0, alpha: 1.0)
}

///<T>表示任何类型的参数
func YZLog<T>(_ items: T,file: String = #file,line: Int = #line,method: String = #function) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)] \([method]) \(items)")
    #endif
}


func currentTime() ->String {
    let time = Date().timeIntervalSince1970
    return String(Int(time))
}

public func dateString(_ timeInterval: Int) ->String {
    let date = Date.init(timeIntervalSince1970: TimeInterval(timeInterval))
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return format.string(from: date)
}
