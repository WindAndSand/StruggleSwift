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
    
/*
    闭包表达式语法一般形式如下：
    {
        (parameters) -> returnType in
        statements
    }
     由关键字 in 引入， 该关键字表示闭包的参数和返回值类型定义已经完成，闭包函数体开始
 */
   
    let names = ["Chris","Alex","Ewa","Barry","Daniella"]
    
//    不使用闭包
    func backwards(s1: String, s2:String) -> Bool
    {
        return s1 > s2
//        print("")
    }
    
    
    /*
//    Swift 标准库提供了 sort 函数，会根据您提供的基于输出类型排序的闭包函数将已知类型数组中的值进行排序
    var  reversed = sort(names, {names, backwards})
    print(reversed)
    
    
//    使用闭包
    var reversed1 = sort(names, {(s1: String, s2:String) -> Bool in
    
    return s1 > s2
    })
    
    print(reversed1)
    
    
//    一 闭包的几种变形
//    1. 根据上下文推断类型
    reversed = sort(names, {s1, s2 in return s1 > s2})
    
//    2. 单表达式闭包隐含返回
//    如果比包体只有一个表达式，那么 return 关键字可以省略
    reversed = sort(names, {s1, s2 in s1> s2})
    
//    3. 参数名称缩写
//    $0 和 $1 表示闭包中第一个和第二个 String 类型的参数
    reversed = sort(names, {$0 > $1})
    
//    4. 运算符函数
    reversed = sort (names, >)
    
 
    
    
//    二 尾随闭包：是一个书写在函数括号之外(之后)的闭包表达式，函数支持将其作为最后一个参数调用。
//    如果您需要将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用 trailing 闭包来增强函数的可读性。
    function = someFunctionThatTakesAClosure() {
    // 闭包主体部分
    }
    
    
 
    
//    三 捕获值
    
    func makeIncrementor(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        
//        incrementor() 函数并没有捕获任何参数，但是在函数体内访问了 runningTotal 和 amount变量，这是因为其通过捕获在包含它的函数体内已经存在的 runningTotal 和 amount 变量而实现
        func incrementor() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementor
    }
    
    let incrementByTen = incrementByTen(forIncrement: 10)
    
//    incrementor 不仅捕获了 runningTotal 的值，还捕获了它的引用，保证 makeIncrementor 结束时，runningTotal 并不会消失，保证当下一次执行 makeIncrementor 函数时，runningTotal 继续增加
    print(incrementByTen())  //10
    print(incrementByTen())  //20
    print(incrementByTen())  //30
    
//    解决方法，将其赋值给一个变量
    let incrementBySeven = makeIncrementor(forIncrement: 7)
    print(incrementBySevet)     //7
    print(incrementByTen())  //40

 
    
    
//    四 闭包是引用类型
//    incrementBySeven 和 incrementByTen 是常量，但是这些常量指向的闭包仍然可以增加其捕获的变量值。 这是因为函数和闭包都是引用类型。
    let alsoIncrementByTen = incrementByTen //incrementByTen 指向了 86 行的 incrementByTen 函数,incrementByTen 函数执行了 96 ，其值为 40.alsoIncrementByTen() 指向的还是 incrementor函数，它的值还是叠加的
    print(alsoIncrementByTen())  // 返回的值为50
 
 */
    
    
    
    
    
    
}
