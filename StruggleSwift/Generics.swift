//
//  Generics.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/27.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

//    1 泛型：泛型代码可以让你写出根据自我需求定义、适用于任何类型的，灵活且可重用的函数和类型。它可以让你避免重复的代码，用一种清晰和抽象的方式来表达代码的意图。

class Generics: NSObject {
    
//    1.5
    var stackOfStrings = Stack<String>()
    
//    1.8
    var stackOfStrings8 = Stack<String>()
    
    
    func printSomeThing() {
//        1.1 
        var someInt = 3
        var anotherInt = 107
//        self.swapTwoInts(a: &someInt, b: &anotherInt)
//        print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
        
        
//        1.2
        swapTwoValues(a: &someInt, b: &anotherInt)
        // someInt is now 107, and anotherInt is now 3
        
        var someString = "hello"
        var anotherString = "world"
        swapTwoValues(a: &someString, b: &anotherString)
        print("----->someString:\(someString), anotherString:\(anotherString)")
        
        
        //    1.5
        stackOfStrings.push(item: "uno")
        stackOfStrings.push(item: "dos")
        stackOfStrings.push(item: "tres")
        stackOfStrings.push(item: "cuatro")
        let fromTheTop = stackOfStrings.pop()
        print("1.5---->fromTheTop:\(fromTheTop)")
        
        
//        1.6.2
        let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
        if let foundIndex = findStringIndex(array: strings, valueToFind: "llama") {
            print("The index of llama is \(foundIndex)")
        }
        
        print("findIndex--->\(String(describing: findIndex(array: ["Mike", "Malcolm", "Andrea"], valueToFind: "Andrea")))")
        
        
//        1.8
        stackOfStrings8.push(item: "uno")
        stackOfStrings8.push(item: "dos")
        stackOfStrings8.push(item: "tres")
        
        var arrayOfStrings = ["uno", "dos", "tres"]
        
//        if let a = self.allItemsMatch(someContainer: stackOfStrings8, anotherContainer: arrayOfStrings) {
//
//        }
    }
    
    //    1.1 泛型所解决的问题
    //    这里是一个标准的，非泛型函数swapTwoInts,用来交换两个Int值：
    func swapTwoInts( a: inout Int, b: inout Int){
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
//    1.2 泛型函数 ：泛型函数可以工作于任何类型，这里是一个上面swapTwoInts函数的泛型版本
//    尖括号告诉 Swift 那个T是swapTwoValues函数所定义的一个类型。因为T是一个占位命名类型，Swift 不会去查找命名为T的实际类型。
    func swapTwoValues<T>( a: inout T, b: inout T) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    
//    1.3 类型参数:在上面的swapTwoValues例子中，占位类型T是一种类型参数的示例。类型参数指定并命名为一个占位类型，并且紧随在函数名后面，使用一对尖括号括起来
//    一旦一个类型参数被指定，那么其可以被使用来定义一个函数的参数类型（如swapTwoValues函数中的参数a和b），或作为一个函数返回类型，或用作函数主体中的注释类型。在这种情况下，被类型参数所代表的占位类型不管函数任何时候被调用，都会被实际类型所替换（在上面swapTwoValues例子中，当函数第一次被调用时，T被Int替换，第二次调用时，被String替换。）
    
//    1.4 命名类型参数:请始终使用大写字母开头的驼峰式命名法（例如T和KeyType）来给类型参数命名，以表明它们是类型的占位符，而非类型值。
    
    //        1.6.2 类型约束行为：
    //    这里有个名为findStringIndex的非泛型函数，该函数功能是去查找包含一给定String值的数组。若查找到匹配的字符串，findStringIndex函数返回该字符串在数组中的索引值（Int），反之则返回nil：
    
    func findStringIndex(array: [String], valueToFind: String) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
    
//    这个函数仍然返回Int，是不是有点迷惑呢，而不是泛型类型?那是因为函数返回的是一个可选的索引数，而不是从数组中得到的一个可选值。
    func findIndex<T: Equatable>(array: [T], valueToFind: T) -> Int? {  //findIndex中这个单个类型参数写做：T: Equatable，也就意味着“任何T类型都遵循Equatable协议”。
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
    
        return nil 
    }
    
    
    
    //    1.8 Where 语句:类型约束中描述的类型约束确保你定义关于类型参数的需求和一泛型函数或类型有关联。
    //    下面的列子定义了一个名为allItemsMatch的泛型函数，用来检查是否两个Container单例包含具有相同顺序的相同元素。如果匹配到所有的元素，那么返回一个为true的Boolean值，反之，则相反。
    
    //    这两个容器可以被检查出是否是相同类型的容器（虽然它们可以是），但他们确实拥有相同类型的元素。这个需求通过一个类型约束和where语句结合来表示：
    func allItemsMatch<
        C1: Container, C2: Container>
        (someContainer: C1, anotherContainer: C2) -> Bool
        where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
            
            // check that both containers contain the same number of items
            if someContainer.count != anotherContainer.count {
                return false
            }
            
            // check each pair of items to see if they are equivalent
            for i in 0...someContainer.count {
                if someContainer[i] != anotherContainer[i] {
                    return false
                }
            }
            
            // all items match, so return true
            return true
            
    }
    
    /*
     这些要求意思是：
     
     someContainer是一个C1类型的容器。 anotherContainer是一个C2类型的容器。 someContainer和anotherContainer包含相同的元素类型。 someContainer中的元素可以通过不等于操作(!=)来检查它们是否彼此不同。
     
     */

    



}


//    1.5 泛型类型:通常在泛型函数中，Swift 允许你定义你自己的泛型类型。这些自定义类、结构体和枚举作用于任何类型，如同Array和Dictionary的用法。
//    一个非泛型版本的栈，Int值型的栈：
struct IntStack {
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

//    一个相同代码的泛型版本：
struct Stack<T> {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
}


//    1.6 类型约束:swapTwoValues函数和Stack类型可以作用于任何类型，不过，有的时候对使用在泛型函数和泛型类型上的类型强制约束为某种特定类型是非常有用的。类型约束指定了一个必须继承自指定类的类型参数，或者遵循一个特定的协议或协议构成。

//        1.6.1 类型约束语法:你可以写一个在一个类型参数名后面的类型约束，通过冒号分割，来作为类型参数链的一部分。这种作用于泛型函数的类型约束的基础语法如下所示（和泛型类型的语法相同）：
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {  //第一个类型参数T，有一个需要T必须是SomeClass子类的类型约束；第二个类型参数U，有一个需要U必须遵循SomeProtocol协议的类型约束
    // function body goes here
}


//    1.7 关联类型:当定义一个协议时，有的时候声明一个或多个关联类型作为协议定义的一部分是非常有用的。一个关联类型给定作用于协议部分的类型一个节点名（或别名）。作用于关联类型上实际类型是不需要指定的，直到该协议接受。关联类型被指定为associatedtype关键字。
//        1.7.1 关联类型行为
//        这里是一个Container协议的例子，定义了一个ItemType关联类型：

/*
 Container协议定义了三个任何容器必须支持的兼容要求：
 
 必须可能通过append方法添加一个新item到容器里；
 必须可能通过使用count属性获取容器里items的数量，并返回一个Int值；
 必须可能通过容器的Int索引值下标可以检索到每一个item
 
 
 这个协议没有指定容器里item是如何存储的或何种类型是允许的。这个协议只指定三个任何遵循Container类型所必须支持的功能点。一个遵循的类型也可以提供其他额外的功能，只要满足这三个条件。
 
 任何遵循Container协议的类型必须指定存储在其里面的值类型，必须保证只有正确类型的items可以加进容器里，必须明确可以通过其下标返回item类型。
 
 */

protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}


//    一个早前IntStack类型的非泛型版本，适用于遵循Container协议：
struct IntStack_: Container {
    // original IntStack implementation
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // conformance to the Container protocol
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item: item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}


/*
 IntStack类型实现了Container协议的所有三个要求，在IntStack类型的每个包含部分的功能都满足这些要求。
 
 此外，IntStack指定了Container的实现，适用的ItemType被用作Int类型。对于这个Container协议实现而言，定义 typealias ItemType = Int，将抽象的ItemType类型转换为具体的Int类型。
 */

//    可以生成遵循Container协议的泛型Stack类型：
struct Stack_<T>: Container {
    // original Stack<T> implementation
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(item: T) {
        self.push(item: item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> T {
        return items[i]
    }
}


