//
//  Extension.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/26.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

//    1 扩展：扩展就是向一个已有的类、结构体或枚举类型添加新功能（functionality）。这包括在没有权限获取原始源代码的情况下扩展类型的能力（即逆向建模）。扩展和 Objective-C 中的分类（categories）类似。（不过与Objective-C不同的是，Swift 的扩展没有名字。）

/*
    Swift 中的扩展特点：
        a. 添加计算型属性和计算静态属性
        b. 定义实例方法和类型方法
        c. 提供新的构造器
        d. 定义下标
        e. 定义和使用新的嵌套类型
        f. 使一个已有类型符合某个接口
*/

class Extension: NSObject {
    
//    1.2
    let oneInch2 = 25.4.mm
    let threeFeet = 3.ft
    
//    这些属性是只读的计算型属性，所有从简考虑它们不用get关键字表示。它们的返回值是Double型，而且可以用于所有接受Double的数学计算中
    let aMarathon = 42.km + 195.m
    
//    1.3 因为结构体Rect提供了其所有属性的默认值，所以正如默认构造器中描述的，它可以自动接受一个默认的构造器和一个成员级构造器。这些构造器可以用于构造新的Rect实例
    let defaultRect3 = Rect()
    let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
    
//    注意：如果你使用扩展提供了一个新的构造器，你依旧有责任保证构造过程能够让所有实例完全初始化。
    let centerRect3 = Rect3(center: Point3(x:4.0, y:4.0), size: Size(width: 3.0, height: 3.0))  //// centerRect的原点是 (2.5, 2.5)，大小是 (3.0, 3.0)
    
//    1.5
    var  someInt5 = 3
    
    
    
    
    
    
    func printSomeThing() {
        
//        1.2
        print("One inch is \(oneInch2) meters")
        print("Three feet is \(threeFeet) meters")
        print("A marathon is \(aMarathon) meters long")
        
        
//        1.4 
        2.repetitions (task:{
            print("1.4--------->:HELLO")
        })
        
//        1.5
        someInt5.square()
        
        print("1.5--->someInt5:\(someInt5)")
        
//        1.6
        print("1.6---->746381295[3]:\(746381295[3])\n--->746381295[1]:\(746381295[1])\n--->746381295[2]:\(746381295[2])")
        
//        1.7
        printLetterKinds(str: "huanggang")
        
    }
}


//    1.1 扩展语法:声明一个扩展使用关键字extension
extension SomeClass{
    // 加到SomeType的新功能写到这里
}

//    一个扩展可以扩展一个已有类型，使其能够适配一个或多个协议（protocol）。当这种情况发生时，接口的名字应该完全按照类或结构体的名字的方式进行书写：
//extension SomeType: SomeProtocol, AnotherProctocol{// 协议实现写到这里  }

//    1.2 计算型属性:扩展可以向已有类型添加计算型实例属性和计算型类型属性。
//    下面的例子向 Swift 的内建Double类型添加了5个计算型实例属性，从而提供与距离单位协作的基本支持。

extension Double{
    var km: Double { return self * 1_000.0}
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0}
    var ft: Double { return self / 3.28084}
    
}

//    注意：扩展可以添加新的计算属性，但是不可以添加存储属性，也不可以向已有属性添加属性观测器(property observers)。


//    1.3 构造器:扩展可以向已有类型添加新的构造器。这可以让你扩展其它类型，将你自己的定制类型作为构造器参数，或者提供该类型的原始实现中没有包含的额外初始化选项

//    注意：如果你使用扩展向一个值类型添加一个构造器，该构造器向所有的存储属性提供默认值，而且没有定义任何定制构造器（custom initializers），那么对于来自你的扩展构造器中的值类型，你可以调用默认构造器(default initializers)和成员级构造器(memberwise initializers)。 正如在值类型的构造器授权中描述的，如果你已经把构造器写成值类型原始实现的一部分，上述规则不再适用。

struct Size3 {
    var width = 0.0, height = 0.0
    
}


struct Point3 {
    var x = 0.0, y = 0.0
    
}

struct Rect3 {
    var origin = Point()
    var size = Size()
    
    
}

//    提供一个额外的使用特殊中心点和大小的构造器来扩展Rect3结构体
extension Rect3 {
    init(center: Point3, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        
        self.init(origin: Point(x: originX, y: originY), size: size)
        
    }
}


//    1.4 方法: 扩展可以向已有类型添加新的实例方法和类型方法。
//    下面的例子向Int类型添加一个名为repetitions的新实例方法：

extension Int{

    func repetitions(task:() ->()) {    //这个repetitions方法使用了一个() -> ()类型的单参数（single argument），表明函数没有参数而且没有返回值
        for i in 0...self  {
            task()
        }
    }
}


//    1.5 修改实例方法:通过扩展添加的实例方法也可以修改该实例本身。结构体和枚举类型中修改self或其属性的方法必须将该实例方法标注为mutating，正如来自原始实现的修改方法一样。
extension Int{
    mutating func square(){
        self = self * self
    }
}


//    1.6 下标：扩展可以向一个已有类型添加新下标。这个例子向Swift内建类型Int添加了一个整型下标。该下标[n]返回十进制数字从右向左数的第n个数字
extension Int{
    subscript (digitIndex: Int) -> Int{
        var decimalBase = 1
    
        for _ in 1...digitIndex{
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

//    1.7嵌套类型:扩展可以向已有的类、结构体和枚举添加新的嵌套类型：
extension Character {
    enum Kind {
        case Vowel, Consonant, Other
    }
    
    var kind: Kind {
        switch String(self).lowercased() {
        case "a", "e", "i", "o", "u":
            return .Vowel
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m","n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            return .Consonant
        default:
            return .Other
        }
    }
}

//    该例子向Character添加了新的嵌套枚举。这个名为Kind的枚举表示特定字符的类型。具体来说，就是表示一个标准的拉丁脚本中的字符是元音还是辅音（不考虑口语和地方变种），或者是其它类型。

//    这个嵌套枚举可以和一个Character值联合使用了：
func printLetterKinds(str: String) {
    print("'\\(word)' is made up of the following kinds of letters:")
    for character in str.characters {
        switch character.kind {
        case .Vowel:
            print("vowel ")
        case .Consonant:
            print("consonant ")
        case .Other:
            print("other ")
        }
    }
    print("\n")
}


//    由于已知character.kind是Character.Kind型，所以Character.Kind中的所有成员值都可以使用switch语句里的形式简写，比如使用 .Vowel代替Character.Kind.Vowel
