//
//  Enumeration.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/19.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

class Enumeration: NSObject {
    
//    1.1 directionToHead的类型被推断当它被CompassPoint的一个可能值初始化。一旦directionToHead被声明为一个CompassPoint，你可以使用更短的点（.）语法将其设置为另一个CompassPoint的值：
    var directionToHead = CompassPoint.West
    
    let somePlant = Planet.Earth
    
    
//    1.3
    var productBarcode = Barcode.UPCA(8, 85909_51226, 3)    //提供的“标识符”值在整数字中有一个下划线，使其便于阅读条形码
    
    
    
    
    func printSomeThing()
    {
        
//        1.1 正如在控制流中介绍，当考虑一个枚举的成员们时，一个switch语句必须全面。如果忽略了.West这种情况，上面那段代码将无法通过编译，因为它没有考虑到CompassPoint的全部成员。全面性的要求确保了枚举成员不会被意外遗漏。
        directionToHead = .East
        switch directionToHead {
        case .North:
            print("Lots of planets have a north")
        case .South:
            print("Lots of planets have a south")
        case .East:
            print("Lots of planets have a east")
        case .West:
            print("Lots of planets have a west")
        
        }
        
        
        
        switch somePlant {
        case .Earth:
            print("Mostly harmless")
        default:
             print("Not a safe place for humans")
        }
        
        
//        1.3
        productBarcode = .QRCode("ABCDEFGHIJKLMNOP")    //原始的Barcode.UPCA和其整数值被新的Barcode.QRCode和其字符串值所替代。
        
        switch productBarcode {
        case .UPCA(let numberSystem, let identifier, let check):
            print("UPC-A with value of \(numberSystem), \(identifier), \(check).")
        case .QRCode(let productCode):
            print("QR code with value of \(productCode).")
        default:
            print("1.3 ------")
            
        }
        
//        1.3
//        使用枚举成员的rawValue方法可以访问该枚举成员的原始值
        print("Planet1.Earth.toRaw():\(Planet1.Earth.rawValue)")
//        使用枚举的fromRaw方法来试图找到具有特定原始值的枚举成员。这个例子通过原始值7识别Uranus
//        print("Planet1.fromRaw(7):\(Planet1.frowRaw(7))")
        
        
        
        
        
        
    }
    
    

}

//        1.1
//        注意： 不像 C 和 Objective-C 一样，Swift 的枚举成员在被创建时不会被赋予一个默认的整数值。在上面的CompassPoints例子中，North，South，East和West不是隐式得等于0，1，2和3。相反的，这些不同的枚举成员在CompassPoint的一种显示定义中拥有各自不同的值。
enum CompassPoint1{

    case North
    case South
    case East
    case West
    
}



enum Planet{

    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Nepturn
    
}


//        1.2 匹配枚举值和Switch语句


//        1.3 关联值:你可以为Planet.Earth设置一个常量或则变量，并且在之后查看这个值。然而，有时候会很有用如果能够把其他类型的关联值和成员值一起存储起来。这能让你随着成员值存储额外的自定义信息，并且当每次你在代码中利用该成员时允许这个信息产生变化
//      “定义一个名为Barcode的枚举类型，它可以是UPCA的一个关联值（Int，Int，Int），或者QRCode的一个字符串类型（String）关联值。”
enum Barcode{
    case UPCA(Int, Int, Int)
    case QRCode(String)
}


//        1.4 原始值:作为关联值的替代，枚举成员可以被默认值（称为原始值）预先填充，其中这些原始值具有相同的类型。

//        这里是一个枚举成员存储原始 ASCII 值的例子
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}


//      下面的枚举是对之前Planet这个枚举的一个细化，利用原始整型值来表示每个 planet 在太阳系中的顺序
enum Planet1: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}









