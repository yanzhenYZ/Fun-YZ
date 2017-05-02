//
//  YZPostfix.swift
//  test
//
//  Created by yanzhen on 2017/4/27.
//  Copyright © 2017年 v2tech. All rights reserved.
//

//postfix 右结合
//prefix  左结合
//infix   中间结合
postfix operator ~~
postfix func ~~(obj: Any?) -> Bool {
    return obj != nil
}

postfix operator ++

@discardableResult
postfix func ++(a: inout Int) -> Int {
    a = a + 1
    return a
}
//
postfix operator --

@discardableResult
postfix func --(a: inout Int) -> Int {
    a = a - 1
    return a
}
