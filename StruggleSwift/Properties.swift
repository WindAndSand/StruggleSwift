//
//  Properties.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/13.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

class Properties: NSObject
{

//    1.1
    var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
    
//    创建了一个结构体的实例并赋值给一个常量，则无法修改实例的任何属性，即使定义了变量存储属性
    let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
    
//        1.4
    var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 1.0, height: 1.0))
    
//    1.6 
    let stepCounter = StepCounter()
    
//    1.9
    var leftChannel = AudioChannel()
    
    var rightChannel = AudioChannel()
    
    
    
    
    func printSomeThing()
    {
//        1.1 
        rangeOfThreeItems.firstValue = 6
        
//    爆出警告，要求把 var 改为 let。解释：这种行为是由于结构体（struct）属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量；属于引用类型的类（class）则不一样，把一个引用类型的实例赋给一个常量后，仍然可以修改实例的变量属性。
//        rangeOfFourItems.firstValue = 6
        
        
        //1.2 DataManager的一个功能是从文件导入数据，该功能由DataImporter类提供，DataImporter需要消耗不少时间完成初始化：因为它的实例在初始化时可能要打开文件，还要读取文件内容到内存。DataManager也可能不从文件中导入数据。所以当DataManager的实例被创建时，没必要创建一个DataImporter的实例，更明智的是当用到DataImporter的时候才去创建它。
        let manager = DataManager()
        manager.data.append("Some data")
        manager.data.append("Some more data")
        
//        lazy，importer属性只有在第一次被访问的时候才被创建。比如访问它的属性fileName时：
        print("调用 lazy 属性：--->\(manager.importer.fileName)")
        
        
        
//        1.4
        let initalSquareCenter = square.center
        square.center = Point(x: 15.0, y: 15.0)
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))\n---initalSquareCenter:\(initalSquareCenter)")
        
//        1.6
        stepCounter.totalSteps = 200

        stepCounter.totalSteps = 360
        
        stepCounter.totalSteps = 896
        
        
//        1.9 获取和设置类型属性的值
//        跟实例的属性一样，类型属性的访问也是通过点运算符来进行，但是，类型属性是通过类型本身来获取和设置，而不是通过实例
        print(SomeClass.computedTypeProperty)
        print(SomeStructure.storedTypeProperty)
        SomeStructure.storedTypeProperty = "Another value"
        print(SomeStructure.storedTypeProperty)
        

        
//        demo
        leftChannel.currentLevel = 7
        print("------- leftChannel.currentLevel:\(leftChannel.currentLevel)")   //输出 7
        

        print("------AudioChannel.maxInputLevelForAllChannels:\(AudioChannel.maxInputLevelForAllChannels)") //输出 7
        
        

    }
    

}

//    1.1 存储属性:一个存储属性就是存储在特定类或结构体的实例里的一个常量或变量，存储属性可以是变量存储属性（用关键字var定义），也可以是常量存储属性（用关键字let定义）。
struct FixedLengthRange {
    var firstValue: Int //变量存储属性
    let length: Int //length的常量存储属性
    
}



//    1.2 延迟存储属性：延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用@lazy来标示一个延迟存储属性。
//    注意：必须将延迟存储属性声明成变量（使用var关键字），因为属性的值在实例构造完成之前可能无法得到。而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性。
//    1.2 使用了延迟存储属性来避免复杂类的不必要的初始化
class DataImporter
{
    var fileName = "data.txt"
    
    
}

class DataManager
{
    lazy var importer = DataImporter()
    var  data: Array<String> = Array<String>()
    /*三种另类构造数组的方法:
    var data1: [String] = Array()
    var data2: [String] = []
    var data3: [String] = [String]()
    */
}


//    1.3 存储属性和实例变量:
//    Swift 中的属性没有对应的实例变量，属性的后端存储也无法直接访问。这就避免了不同场景下访问方式的困扰，同时也将属性的定义简化成一个语句。 一个类型中属性的全部信息——包括命名、类型和内存管理特征——都在唯一一个地方（类型定义中）定义

//    1.4 计算属性: 除存储属性外，类、结构体和枚举可以定义计算属性，计算属性不直接存储值，而是提供一个 getter 来获取值，一个可选的 setter 来间接设置其他属性或变量的值。

struct Point
{
    var x = 0.0, y = 0.0
}

struct Size
{
    var width = 0.0, height = 0.0
}

struct Rect
{
    var origin = Point()
    var size = Size()
    
    var center: Point
    {
        get
        {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            
            return Point(x: centerX, y: centerY)
            
        }
        
        set(newCenter)
        {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        
        }
    }
    
    
    
}


//    1.5 便捷 setter 声明
//    如果计算属性的 setter 没有定义表示新值的参数名，则可以使用默认名称newValue。下面是使用了便捷 setter 声明的Rect结构体代码：

struct AlternativeRect {
    var origin = Point()
    var size = Size()
    
    var center: Point{
        get{
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2 )
            
            return Point(x: centerX, y: centerY)
        }
        
        set{
        
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
        
    }
    
    
}


//    1.6 属性监视器:属性监视器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性监视器，甚至新的值和现在的值相同的时候也不例外。

//     可以为除了延迟存储属性之外的其他存储属性添加属性监视器，也可以通过重载属性的方式为继承的属性（包括存储属性和计算属性）添加属性监视器。
//     willSet在设置新的值之前调用
//     didSet在新的值被设置之后立即调用
//     willSet监视器会将新的属性值作为固定参数传入，在willSet的实现代码中可以为这个参数指定一个名称，如果不指定则参数仍然可用，这时使用默认名称newValue表示。
//     注意：willSet和didSet监视器在属性初始化过程中不会被调用，他们只会当属性的值在初始化之外的地方被设置时被调用。

class StepCounter {
    var totalSteps: Int = 0{
        
        willSet(newToTalSteps){
            print("About to set totalSteps to \(newToTalSteps)")
        }
        
        didSet{
        
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    
    }
}


//    1.7 全局变量和局部变量:计算属性和属性监视器所描述的模式也可以用于全局变量和局部变量，全局变量是在函数、方法、闭包或任何类型之外定义的变量，局部变量是在函数、方法或闭包内部定义的变量。

//  注意：全局的常量或变量都是延迟计算的，跟延迟存储属性相似，不同的地方在于，全局的常量或变量不需要标记@lazy特性；局部范围的常量或变量不会延迟计算。


//  1.8 类型属性:为类型本身定义属性，不管类型有多少个实例，这些属性都只有唯一一份。这种属性就是类型属性(相当于用 static 定义的属性)

//  实例的属性：属于一个特定类型实例，每次类型实例化后都拥有自己的一套属性值，实例之间的属性相互独立。(相当于对象的属性，初始化后彼此之间隔离)

//  注意：跟实例的存储属性不同，必须给存储型类型属性指定默认值，因为类型本身无法在初始化过程中使用构造器给类型属性赋值


//    1.9 类型属性语法：在 C 或 Objective-C 中，静态常量和静态变量的定义是通过特定类型加上global关键字。在 Swift 编程语言中，类型属性是作为类型定义的一部分写在类型最外层的花括号内，因此它的作用范围也就在类型支持的范围内。
//      定义值类型(参见类与结构体)：使用关键字static来定义值类型的类型属性
//      类型属性：关键字class来为类（class）定义类型属性

struct SomeStructure
{
    static var storedTypeProperty = "Some Value."
    static var computedTypeProperty: Int{
        
        return 1
    
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int{
        return 1
    
    }
}

class SomeClass {
    class  var computedTypeProperty: Int {
        
        return 1
        
    }
}


//        一个demo
    struct AudioChannel {

        static let thresholdLevel = 10  //声音电平的最大上限阈值，它是一个取值为 10 的常量，对所有实例都可见，如果声音电平高于 10，则取最大上限值 10
        static var maxInputLevelForAllChannels = 0  //表示所有AudioChannel实例的电平值的最大值，初始值是 0
        var currentLevel: Int = 0{  //  currentLevel实例存储属性
        
            didSet{
                if currentLevel > AudioChannel.thresholdLevel {
                    currentLevel = AudioChannel.thresholdLevel  //将新电平值设为阙值
                }
                
                if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                    AudioChannel.maxInputLevelForAllChannels = currentLevel //存储当前电平值作为新的最大输入电平
                }
            
            }
        }
        
    
}















