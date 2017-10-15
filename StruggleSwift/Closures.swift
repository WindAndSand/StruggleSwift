//
//  Closures.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/13.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit
import Foundation

class Closures: NSObject {
    
    
    let names = ["Chris","Alex","Ewa","Barry","Daniella"]
    
    //    不使用闭包
    func backwards(s1: String, s2:String) -> Bool
    {
        return s1 > s2
        //        print("")
    }
    
    /*
     闭包表达式语法一般形式如下：
     {
     (parameters) -> returnType in
     statements
     }
     由关键字 in 引入， 该关键字表示闭包的参数和返回值类型定义已经完成，闭包函数体开始
     */
    
    
    //    MARK: - 1. 语法表达式
    //    1.1一般形式
    let calAdd1:(Int,Int)->(Int) = {
        (a:Int,b:Int) -> Int in
        return a + b
    }
    //    1.2 可以根据闭包上下文推断参数和返回值的类型，所以上面的例子可以简化如下
    let calAdd2:(Int,Int)->(Int) = {
        a,b in  //也可以写成(a,b) in
        return a + b
    }
    
    //    1.3 单行表达式闭包可以隐式返回，如下，省略return
    let calAdd3:(Int,Int)->(Int) = {(a,b) in a + b}
    
    //    1.4 如果闭包没有参数，可以直接省略“in”
    let calAdd4:()->Int =  {return 100+150}
    
    //    1.5 没有参数也没返回值，所以把return和in都省略了
    let calAdd5:()->Void = {print("我是250")}
    
    //    总结：let calAdd：(add类型)。这里的add类型就是闭包类型 (Int,Int)->(Int)。意思就是声明一个calAdd常量，其类型是个闭包类型。
    
    //    MARK: - 2. 起别名
    //    2.1 以关键字“typealias”先声明一个闭包数据类型。类似于OC中的typedef起别名
    typealias AddBlock = (Int, Int) -> (Int)
    
    let Add:AddBlock = {
        (c,d) in
        return c + d
    }
    
    //    MARK: - 3. 尾随闭包
    //    3.1 是一个书写在函数括号之外(或之后)的闭包表达式，函数支持将其作为最后一个参数调用。如果您需要将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用 trailing 闭包来增强函数的可读性。
    /*
     function = someFunctionThatTakesAClosure() {
     // 闭包主体部分
     }
     */
    func post(url:String,succesce:(String)->Void) {
        
        print("发送请求");
        
        succesce("请求完成");
    }
    
    //    MARK: - 4.值捕获
    //    4.1 闭包可以在其被定义的上下文中捕获常量或变量。Swift中，可以捕获值的闭包的最简单形式是嵌套函数，也就是定义在其他函数的函数体内的函数。
    func makeIncrementor(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        
        //        incrementor() 函数并没有捕获任何参数，但是在函数体内访问了 runningTotal 和 amount变量，这是因为其通过捕获在包含它的函数体内已经存在的 runningTotal 和 amount 变量而实现
        func incrementor() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementor
    }
    
    //    MARK: - 5.逃逸闭包和非逃逸闭包
    /*
     逃逸闭包一般用于异步函数的回调，比如网络请求成功的回调和失败的回调。语法：在函数的闭包行参前加关键字“@escaping”。
     简单来说，是为了管理内存。一个闭包会强引用它捕获的所有对象————如果你在闭包中访问了当前对象中的任意属性或实例方法，闭包会持有当前对象，因为这些方法和属性都隐性地携带了一个 self 参数。
     这种方式很容易导致循环引用，这解释了为什么编译器会要求你在闭包中显式地写出对 self 的引用。这迫使你考虑潜在的循环引用，并使用捕获列表手动处理。
     然而，使用非逃逸的闭包不会产生循环引用————编译器可以保证在函数返回时闭包会释放它捕获的所有对象。因此，编译器只要求在逃逸闭包中明确对 self 的强引用。显然，使用非逃逸闭包是一个更加愉悦的方案。
     */
    
//    5.1.1 逃逸闭包：当一个闭包作为参数传到一个函数中，需要这个闭包在函数返回之后才被执行，我们就称该闭包从函数种逃逸(简单的来说：一个接受逃逸闭包作为参数的函数，逃逸闭包（可能）会在函数返回之后才被调用————也就是说，闭包逃离了函数的作用域。)。一般如果闭包在函数体内涉及到异步操作，但函数却是很快就会执行完毕并返回的，闭包必须要逃逸掉，以便异步操作的回调。
    func doSomething(some: @escaping () -> Void){
        //延时操作，注意这里的单位是秒
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            //1秒后操作
            some()
        }
        print("函数体")
    }
    
//    5.1.2 逃逸闭包
    var comletionHandle: ()->String = {"约吗?"}//4,7
    
    func doSomething2(some: @escaping ()->String){
        comletionHandle = some//3
    }//5
    
//    5.1.3 逃逸闭包和非逃逸闭包的 Demo
    /*
     .将一个闭包标记为@escaping意味着你必须在闭包中显式的引用self。
     .其实@escaping和self都是在提醒你，这是一个逃逸闭包，
     .别误操作导致了循环引用！而非逃逸包可以隐式引用self。
 */
    
    var completionHandlers: [() -> Void] = []
    //逃逸
    func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
        completionHandlers.append(completionHandler)
    }
    //非逃逸
    func someFunctionWithNonescapingClosure(closure: () -> Void) {
        closure()
    }
    
    var x = 10
    func doSomething3() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
    
    
//    MARK: - 6. 自动闭包
    /*
     自动闭包是一种自动创建的闭包，封装一堆表达式在自动闭包中，然后将自动闭包作为参数传给函数。而自动闭包是不接受任何参数的，但可以返回自动闭包中表达式产生的值。
     自动闭包让你能够延迟求值，直到调用这个闭包，闭包代码块才会被执行。说白了，就是语法简洁了，有点懒加载的意思。
     */
    

   
    
    func printSomeThing() {
//        1.1
        print(calAdd1(100,150))
        
//        1.2
        print(calAdd2(150,100))
        
//        1.3
        print(calAdd3(50,200))
        
//        1.4
        print("....\(calAdd4())")
        
//        1.5
        calAdd5()
        
//        2.1
        let Result = Add(100,150)
        print("起别名闭包：Result = \(Result)")
        
//        3.1
        //正常写法，第二个参数，传递一个闭包
        post(url: "http", succesce: {
            //闭包传递的参数
            (json) in
            //执行的代码
            print(json);
            
        });
        
        //尾随闭包，当闭包作为函数的最后一个参数时，可以省略前面的括号
        post(url: "http") { (json) in
            print(json);
        };
        
        
//        4.1
        let incrementByTen = makeIncrementor(forIncrement: 10)
        
        //    incrementor 不仅捕获了 runningTotal 的值，还捕获了它的引用，保证 makeIncrementor 结束时，runningTotal 并不会消失，保证当下一次执行 makeIncrementor 函数时，runningTotal 继续增加
        print(incrementByTen())  //10
        print(incrementByTen())  //20
        print(incrementByTen())  //30
        
        //    解决方法，将其赋值给一个变量
        let incrementBySeven = makeIncrementor(forIncrement: 7)
        print(incrementBySeven)     //7
        print(incrementByTen())  //40

        
//        5.1.1 逃逸闭包
        self.doSomething {
            print("---->逃逸闭包")
        }
        
//        5.1.2
//        闭包没有参数，可以直接省略
        self.doSomething2 { () -> String in //1
            return "叔叔，我们不约-0---"//9
        }//2
        
        print(comletionHandle())//6,8,10


//        5.1.3
        self.doSomething3()
        
        
//        6.
        var array = ["I","have","a","apple"]
        print(array.count)
        //打印出"4"
        
        let removeBlock = {array.remove(at: 3)}//测试了下，这里代码超过一行，返回值失效。
        print(array.count)
        //打印出"4"
        
        print("执行代码块移除\(removeBlock())")
        //打印出"执行代码块移除apple" 这里自动闭包返回了apple值
        
        print(array.count)
        //打印出"3"
        
        
    }
    
    
}
