//
//  TheBasics.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/13.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit
import Foundation

class TheBasics: NSObject
{
    
    /// 一 常量和变量
//    1.用let来声明常量，用var来声明变量
    let maximumNumberOfLoginAttempts = 10
    var currentLoginAttempt = 0

    
//   2. 一行中声明多个常量或者多个变量，用逗号隔开
    var x = 0.0, y = 0.0, z = 0.0

    
    
    
    /// 二 类型标注:当你声明常量或者变量的时候可以加上类型标注(type annotation)，说明常量或者变量中要存储的值的类型。如果要添加类型标注，需要在常量或者变量名后面加上一个冒号和空格，然后加上类型名称。
    
//    1. 给welcomeMessage变量添加了类型标注，表示这个变量可以存储String类型的值
//    var welcomeMessage: String
//    welcomeMessage = "Hello"
    
//    var friendlyWelcome = "Hello!"
//    friendlyWelcome = "Bonjour"
    
    

    
    /// 三 分号
//    1.必须加分号，在同一行内写多条独立的语句：
//    let c、、at = "??????"; print("cat:")
    
    
    
    /// 四 整数转换
    
//    1.将数字类型转换为另一种
    let twoThousand: UInt16 = 2_000
    let one: UInt8 = 1
//    let twoThousandAndOne = twoThousand + UInt16(one)
    
    
    
    /// 四 类型别名：类型别名(type aliases)就是给现有类型定义另一个名字。你可以使用typealias关键字来定义类型别名。
    typealias AudioSample = UInt16
    var masAmplitudeFound = AudioSample()  //定义了一个别名

    
    
    
    /// 五 布尔类型：两个布尔常量，true和false
    
    let i = 1
//    if i{}  // 会报错，使用了非布尔值
//    if i == 1{}   //i == 1的比较结果是Bool类型，所以第二个例子可以通过类型检查
  
    
    
    
     /// 六 元组类型：把多个值组合成一个复合值。元组内的值可以使任意类型，并不要求是相同类型。
    
    let http404Error = (404, "Not Found")
//     http404Error 的类型是 (Int, String)，值是 (404, "Not Found")
    
//    1.将一个元组的内容分解（decompose）成单独的常量和变量
//    let (statusCode, statusMessage) = http404Error1
//    print("The status code is \(statusCode)")
    // 输出 "The status code is 404"
//    print("The status message is \(statusMessage)")
    // 输出 "The status message is Not Found"
    
//    2.只需要一部分元组值，分解的时候可以把要忽略的部分用下划线（_）标记
//    let (justTheStatusCode, _) = http404Error
//    print("The status code is \(justTheStatusCode)")
    // 输出 "The status code is 404"
    
//    3.通过下标来访问元组中的单个元素，下标从零开始
//    print("The status code is\(http404Error.0)")
    // 输出 "The status code is 404"
//    print("The status message is \(http404Error.1)")
    // 输出 "The status message is Not Found"
    
//    4.在定义元组的时候给单个元素命名
    let http200Status = (statusCode: 200, description: "OK")
    
//    5.给元组中的元素命名后，你可以通过名字来获取这些元素的值
//    print(""The status code is \(http200Status.statusCode)")
//      输出 "The status code is 200"
//    print("The status message is \(http200Status.description)")
//      输出 "The status message is OK"

    
    
    
    /// 七 可选
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
