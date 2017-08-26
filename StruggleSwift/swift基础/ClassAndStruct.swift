//
//  ClassAndStruct.swift
//  StruggleSwift
//
//  Created by 黄刚 on 2017/8/17.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit


class ClassAndStruct: NSObject
{
//    1.1 类和结构体实例
    let someResolution = Resolution()
    let someVideoMode = VideoMode()
    
//    1.3 结构体类型的成员逐一初始化器
    let vga = Resolution(width:640, height:480)
    
//    1.4 结构体和枚举是值类型：值类型被赋予给一个变量，常数或者本身被传递给一个函数的时候，实际上操作的是其的拷贝。所有的基本类型：整数(Integer)、浮点数(floating-point)、布尔值(Booleans)、字符串(string)、数组(array)和字典(dictionaries)，都是值类型，并且都是以结构体的形式在后台所实现。所有的结构体和枚举都是值类型。这意味着它们的实例，以及实例中所包含的任何值类型属性，在代码中传递的时候都会被复制。
    let hd = Resolution(width: 1920, height: 1080)
    
//    1.5
    var currentDirection = CompassPoint.West
    
//    1.6 类是引用类型：与值类型不同，引用类型在被赋予到一个变量，常量或者被传递到一个函数时，操作的并不是其拷贝。因此，引用的是已存在的实例本身而不是其拷贝。
    let tenEighty = VideoMode()
    
    
//    1.7 恒等运算符:因为类是引用类型，有可能有多个常量和变量在后台同时引用某一个类实例。(对于结构体和枚举来说，这并不成立。因为它们作值类型，在被赋予到常量，变量或者传递到函数时，总是会被拷贝。).判定两个常量或者变量是否引用同一个类实例将会很有帮助。为了达到这个目的，Swift 内建了两个恒等运算符：等价于 ( === ), 不等价于 ( !== )
    
//    1.8 demo 字典
    var ages = ["Peter": 23, "Wei": 35, "Anish": 65, "Katya": 19]
    
    //        1.9 数组的赋值和拷贝行为：如果你将一个数组(Array)实例赋给一个变量或常量，或者将其作为参数传递给函数或方法调用，在事件发生时数组的内容不会被拷贝。相反，数组公用相同的元素序列。当你在一个数组内修改某一元素，修改结果也会在另一数组显示。对数组来说，拷贝行为仅仅当操作有可能修改数组长度时才会发生。这种行为包括了附加(appending),插入(inserting),删除(removing)或者使用范围下标(ranged subscript)去替换这一范围内的元素。
    var a = [1, 2, 3]
    
//    2.0 确保数组的唯一性:通过在数组变量上调用unshare方法来确定数组引用的唯一性。(当数组赋给常量时，不能调用unshare方法)
    

    
    
    
    
    
    
    
    func printSomeThing()
    {
//        1.2 属性访问
        print("The width of someResolution is \(someResolution.width)")
        
        print("The width of someVideoMode is \(someVideoMode.resolution.width)")
        
        someVideoMode.resolution.width = 1280
        print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
        
        print("结构体类型的成员逐一初始化器:heitht-->\(vga.height)")
        
//        1.4 在将hd赋予给cinema的时候，实际上是将hd中所储存的值(values)进行拷贝，然后将拷贝的数据储存到新的cinema实例中。结果就是两个完全独立的实例碰巧包含有相同的数值。由于两者相互独立，因此将cinema的width修改为2048并不会影响hd中的宽(width)。
        var cinema = hd
        cinema.width = 2048
        print("cinema is now  \(cinema.width) pixels wide")
        print("hd is now  \(hd.width) pixels wide")
        
        
//        1.5 上例中rememberedDirection被赋予了currentDirection的值(value)，实际上它被赋予的是值(value)的一个拷贝。赋值过程结束后再修改currentDirection的值并不影响rememberedDirection所储存的原始值(value)的拷贝。
        let remembredDirection = currentDirection
        currentDirection = .East //值变为 East
        if remembredDirection == .West
        {
            print("The remembered direction is still .West")
        }
        
        
//        1.6 因为类是引用类型，所以tenEight和alsoTenEight实际上引用的是相同的VideoMode实例。换句话说，它们只是同一个实例的两种叫法。
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        
//        需要注意的是tenEighty和alsoTenEighty被声明为常量(constants)而不是变量。然而你依然可以改变tenEighty.frameRate和alsoTenEighty.frameRate,因为这两个常量本身不会改变。它们并不储存这个VideoMode实例，在后台仅仅是对VideoMode实例的引用。所以，改变的是被引用的基础VideoMode的frameRate参数，而不改变常量的值。
        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        print("\nThe frameRate property of tenEighty is now \(tenEighty.frameRate)")
        
//        1.7 “等价于”表示两个类类型(class type)的常量或者变量引用同一个类实例(即：引用相同的地址)。“等于”表示两个实例的值“相等”或“相同”，判定时要遵照类设计者定义定义的评判标准，因此相比于“相等”，这是一种更加合适的叫法。
        if tenEighty === alsoTenEighty
        {
            print("\ntenTighty and alsoTenEighty refer to the same Resolution instance.====")
        }
        
        print("------>总结：Swift 中数组(Array)和字典(Dictionary)类型均以结构体的形式实现。然而当数组被赋予一个常量或变量，或被传递给一个函数或方法时，其拷贝行为与字典和其它结构体有些许不同。\n\nObjective-C:以下对数组和结构体的行为描述与对NSArray和NSDictionary的行为描述在本质上不同，后者是以类的形式实现，前者是以结构体的形式实现。NSArray和NSDictionary实例总是以对已有实例引用,而不是拷贝的方式被赋值和传递。\n")

        
//        1.8 字典的键(keys)是字符串(String)类型，值(values)是整(Int)类型。这两种类型在Swift 中都是值类型(value types)，所以当字典被拷贝时，两者都会被拷贝。
        var compiedAges = ages
        compiedAges["Peter"] = 24
        print(ages["Peter"])
        
        
//        1.9 
        var b = a
        var c = a
        print("--a[0]:\(a[0])\nb[0]:\(b[0])\nc[0]:\(c[0])\n")
//        通过下标语法修改数组中某一元素的值，那么a,b,c中的相应值都会发生改变。请注意当你用下标语法修改某一值时，并没有拷贝行为伴随发生，因为下表语法修改值时没有改变数组长度的可能：然而，当你给a附加新元素时，数组的长度会改变。 当附加元素这一事件发生时，Swift 会创建这个数组的一个拷贝。从此以后，a将会是原数组的一个独立拷贝。
        a[0] = 42
        print("数组赋值--->a[0]:\(a[0])\nb[0]:\(b[0])\nc[0]:\(c[0])\n")
        
        a.append(4)
        a[0] = 777
        print("数组增加元素并--->a[0]:\(a[0])\nb[0]:\(b[0])\nc[0]:\(c[0])\n")
        
        
//        2.0 如果一个数组被多个变量引用，在其中的一个变量上调用unshare方法，则会拷贝此数组，此时这个变量将会有属于它自己的独立数组拷贝。当数组仅被一个变量引用时，则不会有拷贝发生
       /* a.unshare()
        
//        在unshare方法调用后再修改b中第一个元素的值，这三个数组(a,b,c)会返回不同的三个值：
        
        b[0] = -105
        println(a[0])
        // 77
        println(b[0])
        // -105 
        println(c[0])
 */
        
    }
    
    

}

//    在你每次定义一个新类或者结构体的时候，实际上你是有效地定义了一个新的 Swift 类型。
struct Resolution {
//    结构体包含了两个名为width和height的储存属性。储存属性是捆绑和储存在类或结构体中的常量或变量。当这两个属性被初始化为整数0的时候，它们会被推断为Int类型。
    var width = 0
    var height = 0
    
}

class VideoMode: NSObject
{
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?   //name属性会被自动赋予一个默认值nil，意为“没有name值”，因它是一个可选类型。
    
    
    
    
}

//1.5 枚举也遵循相同的行为准则
enum CompassPoint
{
    case North, South, East, West
}


