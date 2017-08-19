//
//  Methods.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/19.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

//      方法：方法是与某些特定类型相关联的函数

class Methods: NSObject
{
    
//    1.1 
    let counter = Counter() // 初始计数值是0
    
    
    //    1.2
    let counter1 = Counter1()
    
//    1.3
    let somePoint = Point1(x: 4.0, y:5.0)
    
//    1.3.1
    var somePoint2 = Point2(x:1.0, y: 1.0)
    
//    1.3.2
    var ovenLight = TriStateSwitch.Low
    
    
    
    
    func printSomeThing()
    {
//        1.1
        counter.increment() // 计数值是1
        counter.incrementBy(amount: 5)  // 计数值是6
        counter.reset() // 计数值是0
        
        
//        1.2
        
        counter1.incrementBy(amount: 5, numberOfTimes: 3)   //或者： counter value is now 15 
        
        
//        1.3
        if somePoint.isToTheRightOfX(x: 1.0)
        {
            print("This point is to the right of the line where x == 1.0")
        }
        
//        1.3.1
        somePoint2.moveByX(deltaX: 2.0, y: 3.0)
        print("The point is now at (\(somePoint2.x), \(somePoint2.y))")
        
        
//        1.3.2
        print("----->1.3.2-ovenLight.next():\(ovenLight.next())")
        print("----->1.3.2--ovenLight.next():\(ovenLight.next())\(ovenLight)")
        
        
//        1.4
        SomeClass1.someTypeMethod()

    }
    

    
    
    
    
    

}





//        1.1实例犯法：实例方法是属于某个特定类、结构体或者枚举类型实例的方法。实例方法提供访问和修改实例属性的方法或提供与实例目的相关的功能，并以此来支撑实例的功能。

class Counter {
    var count = 0
    
    func increment() {
        count += 1
    }
    
    func incrementBy(amount: Int)  {
        count += amount
    }
    
    func reset()  {
        count = 0
    }
    
}


//        1.2 方法的局部参数名称和外部参数名称:函数参数可以同时有一个局部名称（在函数体内部使用）和一个外部名称（在调用函数时使用）
//        Swift 中方法的名称通常用一个介词指向方法的第一个参数，比如：with，for，by等等。前面的Counter类的例子中incrementBy方法就是这样的
//        Swift 默认仅给方法的第一个参数名称一个局部参数名称;默认同时给第二个和后续的参数名称局部参数名称和外部参数名称。这个约定与典型的命名和调用约定相适应，与你在写 Objective-C 的方法时很相似。这个约定还让表达式方法在调用时不需要再限定参数名称。
class Counter1
{
    var count: Int = 0
//    incrementBy方法有两个参数： amount和numberOfTimes。默认情况下，Swift 只把amount当作一个局部名称，但是把numberOfTimes即看作局部名称又看作外部名称。不必为第一个参数值再定义一个外部变量名：因为从函数名incrementBy已经能很清楚地看出它的作用。但是第二个参数，就要被一个外部参数名称所限定，以便在方法被调用时明确它的作用。
    func incrementBy(amount: Int, numberOfTimes: Int) {
        count += amount * numberOfTimes
    }
    
//    func increMentBy1(amount: Int, #numberOfTimes: Int)  {
//        count += amount * numberOfTimes
//    }
}


//        1.3 self 属性：你不必在你的代码里面经常写self。不论何时，只要在一个方法中使用一个已知的属性或者方法名称，如果你没有明确的写self，Swift 假定你是指当前实例的属性或者方法。这种假定在上面的Counter中已经示范了：Counter中的三个实例方法中都使用的是count（而不是self.count）。

//        self消除方法参数x和实例属性x之间的歧义
struct Point1{
    var x = 0.0, y = 0.0
    func isToTheRightOfX(x: Double) -> Bool
    {
        return self.x > x
    }
    

}


//        1.3.1 在实例方法中修改值类型,如：结构体和枚举是值类型。一般情况下，值类型的属性不能在它的实例方法中被修改。但是，如果你确实需要在某个具体的方法中修改结构体或者枚举的属性，你可以选择变异(mutating)这个方法，然后方法就可以从方法内部改变它的属性；并且它做的任何改变在方法结束时还会保留在原始结构中。
struct Point2
{
    var x = 0.0, y = 0.0
    
    mutating func moveByX(deltaX: Double, y deltaY: Double)
    {
        x += deltaX
        y += deltaY
    
    }
    
    
}


//        1.3.2 枚举的变异方法可以把self设置为相同的枚举类型中不同的成员
enum TriStateSwitch{

case Off, Low, High
    
    mutating func next(){
    
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
            
        }
    }
}


//        1.4 类型方法定义类型本身调用的方法，这种方法就叫做类型方法。声明类的类型方法，在方法的func关键字之前加上关键字class；声明结构体和枚举的类型方法，在方法的func关键字之前加上关键字static。
//      在类型方法的方法体（body）中，self指向这个类型本身，而不是类型的某个实例。对于结构体和枚举来说，这意味着你可以用self来消除静态属性和静态方法参数之间的歧义

class SomeClass1 {
    class func someTypeMethod()
    {
        print("调用 SomeClass1的someTypeMethod() 类方法")
    }
}


struct LevelTracker {
    static var highestUnlockedLevel = 1
    static func unlockLevel(level: Int){
    
        if level > highestUnlockedLevel {  //一旦新等级被解锁，它会更新highestUnlockedLevel的值。
            highestUnlockedLevel = level
        }
        
    }
    
    static func levelIsUnlocked(level: Int) -> Bool { return level <= highestUnlockedLevel }  //如果某个给定的等级已经被解锁，它将返回true
    
    var currentLevel = 1
    
    mutating func advanceToLevel(level: Int) -> Bool{
    
        if LevelTracker.levelIsUnlocked(level: level)
        {
            currentLevel = level
            return true
        }else{ return false }
    }
    
}

