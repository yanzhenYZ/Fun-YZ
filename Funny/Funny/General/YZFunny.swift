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

//MARK: Enum
enum YZAPPNAME: Int {
    case Content = 100
    case GifShow
    case BuDeJie
    case Walfare
    case UC
    case NetEsae
    case YingKe
    case Draw
    case Note
    case QR
}

let FunnyApp = ["Funny.YZContentTabBarViewController",
                "Funny.YZGifShowTabBarViewController",
                "Funny.YZBuDeJieTabBarViewController",
                "Funny.YZWalfareTabBarViewController",
                "Funny.YZUCTabBarViewController",
                "Funny.YZNetEaseTabBarViewController",
                "Funny.YZYKTabBarViewController",
                "Funny.YZDrawPictureViewController",
                "Funny.YZNoteLockedViewController",
                "Funny.YZQRViewController"]
enum MJRefresh : Int {
    case pull = -1
    case normal
    case push
}
//MARK: Func
func YZColor(_ R: CGFloat, _ G: CGFloat, _ B: CGFloat) ->UIColor {
    return UIColor(red: R / 255.0, green: G / 255.0, blue: B / 255.0, alpha: 1.0)
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
