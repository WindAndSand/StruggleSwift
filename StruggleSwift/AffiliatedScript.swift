//
//  AffiliatedScript.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/19.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

//        附属脚本：附属脚本可以定义在类（Class）、结构体（structure）和枚举（enumeration）这些目标中，可以认为是访问对象、集合或序列的快捷方式，不需要再调用实例的特定的赋值和访问方法。举例来说，用附属脚本访问一个数组(Array)实例中的元素可以这样写 someArray[index] ，访问字典(Dictionary)实例中的元素可以这样写 someDictionary[key]。

class AffiliatedScript: NSObject
{
    
//    1.1
    let threeTimesTable = TimesTable(multiplier: 3) //数值3作为结构体构造函数入参初始化实例成员multiplier
    
//    1.3 
    var matrix = Matrix(rows: 2, columns: 2)
    
    
    
    func printSomeThing() {
//        1.1
        print("3的6倍是\(threeTimesTable[6])") // 输出 "3的6倍是18" ,比如threeTimesTable[6]。这句话访问了threeTimesTable的第六个元素，返回18或者6的3倍。
        
//        1.2 定义一个名为numberOfLegs的变量并用一个字典字面量初始化出了包含三对键值的字典实例。numberOfLegs的字典存放值类型推断为Dictionary<String, Int>。字典实例创建完成之后通过附属脚本的方式将整型值2赋值到字典实例的索引为bird的位置中。
        numberOfLegs["bird"] = 2

        
//        1.3
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    

}


//        1.1 附属脚本语法：附属脚本允许你通过在实例后面的方括号中传入一个或者多个的索引值来对实例进行访问和赋值。语法类似于实例方法和计算型属性的混合。与定义实例方法类似，定义附属脚本使用subscript关键字，显式声明入参（一个或多个）和返回类型。与实例方法不同的是附属脚本可以设定为读写或只读。这种方式又有点像计算型属性的getter和setter：

/*
 subscript(index: Int) -> Int {
 get {
 //       返回与入参匹配的Int类型的值
 }
 
 set(newValue) {
 // 执行赋值操作
 }
 }
 
 //     与只读计算型属性一样，可以直接将原本应该写在get代码块中的代码写在subscript中：
 subscript(index: Int) -> Int {
 // 返回与入参匹配的Int类型的值
 }
 
 */
//        注意：TimesTable例子是基于一个固定的数学公式。它并不适合开放写权限来对threeTimesTable[someIndex]进行赋值操作，这也是为什么附属脚本只定义为只读的原因。
struct TimesTable
{
    let multiplier: Int
    subscript(index: Int) -> Int{
    
        return multiplier * index
    }
}


//        1.2 附属脚本用法:根据使用场景不同附属脚本也具有不同的含义。通常附属脚本是用来访问集合（collection），列表（list）或序列（sequence）中元素的快捷方式;Swift 的字典（Dictionary）实现了通过附属脚本来对其实例中存放的值进行存取操作。在附属脚本中使用和字典索引相同类型的值，并且把一个字典值类型的值赋值给这个附属脚本来为字典设值：
var numberOfLegs = ["spider": 8, "ant": 6, "cat":4]

//      注意：Swift 中字典的附属脚本实现中，在get部分返回值是Int?，上例中的numberOfLegs字典通过下边返回的是一个Int?或者说“可选的int”，不是每个字典的索引都能得到一个整型值，对于没有设过值的索引的访问返回的结果就是nil；同样想要从字典实例中删除某个索引下的值也只需要给这个索引赋值为nil即可。


//        1.3 附属脚本选项:附属脚本允许任意数量的入参索引，并且每个入参类型也没有限制。附属脚本的返回值也可以是任何类型。附属脚本可以使用变量参数和可变参数，但使用写入读出（in-out）参数或给参数设置默认值都是不允许的。

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
   
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    
    subscript(row: Int, column: Int) -> Double{
        get{
        
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            return grid[(row * column) + column]
        }
        
        set{
        
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            grid[(row * columns) + columns] = newValue
        }
    }
}





















