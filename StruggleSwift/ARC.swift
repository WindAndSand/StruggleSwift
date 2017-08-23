//
//  ARC.swift
//  StruggleSwift
//
//  Created by 黄刚 on 2017/8/23.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

class ARC: NSObject {
    
//    1
    var reference1: Person? //因为这些变量都是可选类型（Person?，而非Person），因此他们都被自动初始化为nil，并且当前并没有引用一个Person的实例
    var reference2: Person?
    var reference3: Person?
    
//    1.1 
    var john:Person1?
    var number71: Apartment?
    
//    1.2
    var john2: Person2?
    var number72: Apartment2?
    
    
//    1.3 
    var john3: Customer?    //定义了一个叫john的可选类型Customer变量，用来保存某个特定消费者的引用
    
    
    
    
    func printSomeThing()  {
        
//        1
        reference1 = Person(name: "John Appleseed")
        reference2 = reference1 //这一个Person实例有三个强引用
        reference3 = reference1
        
        reference1 = nil
        reference2 = nil //如果你通过赋值nil给两个变量来破坏其中的两个强引用（包括原始的引用），只剩下一个强引用，这个Person实例也不会被销毁：
        
        reference3 = nil //第三个也是最后一个强引用被破坏，ARC才会销毁Person的实例，这时，有一点非常明确，你无法继续使用Person实例：
        
        
//        1.1
        john = Person1(name: "John Appleseed")
        number71 = Apartment(number: 73)
        
//        强引用形成环
        john!.apartment = number71
        number71!.tenant = john
        
        john = nil
        number71 = nil
        
        
//        1.2 
        john2 = Person2(name: "John Appleseed")
        number72 = Apartment2(number: 73)
        
//        Person的实例仍然是Apartment实例的强引用，但是Apartment实例则是Person实例的弱引用。这意味着当破坏john变量所持有的强引用后，不再存在任何Person实例的强引用
        john2!.apartment = number72
        number72!.tenant = john2
        
        john2 = nil //既然不存在Person实例的强引用，那么该实例就会被销毁
        
        
//        1.3 ：Customer实例持有CreditCard实例的强引用，而CreditCard实例则持有Customer实例的无主引用。因为customer的无主引用，当破坏john变量持有的强引用时，就没有Customer实例的强引用了：
        john3 = Customer(name: "1.3--John Appleseed")
        john3!.card = CreditCard(number: 1234_9012_3456, customer: john3!)
        
//        Customer实例被销毁。然后，CreditCard实例的强引用也不复存在，因此CreditCard实例也被销毁
        john3 = nil
        
    }
    


}

//    注意：引用计数只应用在类的实例。结构体(Structure)和枚举类型是值类型，并非引用类型，不是以引用的方式来存储和传递的。

//    1. ARC 如何工作：每次创建一个类的实例，ARC就会分配一个内存块，用来存储这个实例的相关信息。这个内存块保存着实例的类型，以及这个实例相关的属性的值。

//     只要有一个有效的引用，ARC都不会释放这个实例。为了让这变成现实，只要你将一个类的实例赋值给一个属性或者常量或者变量，这个属性、常量或者变量就是这个实例的强引用(strong reference)。之所以称之为“强”引用，是因为它强持有这个实例，并且只要这个强引用还存在，就不能销毁实例。
class Person{

    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized") //类Person还有一个deinitializer方法，当销毁一个类的实例时，会打印一条消息。
    }
    
}

//    1.1 类实例间的强引用环:，一个类的实例永远不会有0个强引用。在两个类实例彼此保持对方的强引用，使得每个实例都使对方保持有效时会发生这种情况。我们称之为强引用环。
//    解决方法：通过用弱引用或者无主引用来取代强引用，我们可以解决强引用环问题。在开始学习如何解决这个问题之前，理解它产生的原因会很有帮助。


//    每个Person实例拥有一个String类型的name属性以及一个被初始化为nil的apartment可选属性。apartment属性是可选的，因为一个人并不一定拥有一座公寓。
class Person1{
    
    let name: String
    init(name: String) {
        self.name = name
    }
    
    var apartment: Apartment?
    
    
    
    deinit {
        print("\(name) 11111is being deinitialized")     }
    
}

class Apartment {
    let number: Int
    init(number: Int) {
        self.number = number
    }
    
    var tenant: Person1?
    deinit {
        print("Apartment #\(number) 11111is being deinitialized")
    }
    
    
}

//    1.2 解决实例间的强引用环
//    解决办法：Swift提供两种方法来解决强引用环：弱引用和无主引用。：弱引用和无主引用允许引用环中的一个实例引用另外一个实例，但不是强引用。因此实例可以互相引用但是不会产生强引用环

//    对于生命周期中引用会变为nil的实例，使用弱引用；对于初始化时赋值之后引用再也不会赋值为nil的实例，使用无主引用。


//    弱引用：弱引用不会增加实例的引用计数，因此不会阻止ARC销毁被引用的实例。这种特性使得引用不会变成强引用环。声明属性或者变量的时候，关键字weak表明引用为弱引用。

//    在实例的生命周期中，如果某些时候引用没有值，那么弱引用可以阻止强引用环。如果整个生命周期内引用都有值，那么相应的用无主引用，在无主引用这一章中有详细描述。在上面的Apartment例子中，有时一个Apartment实例可能没有房客，因此此处应该用弱引用。

//    因为弱引用可以没有值，所以声明弱引用的时候必须是可选类型的。在Swift语言中，推荐用可选类型来作为可能没有值的引用的类型。

//    如前所述，弱引用不会保持实例，因此即使实例的弱引用依然存在，ARC也有可能会销毁实例，并将弱引用赋值为nil。你可以想检查其他的可选值一样检查弱引用是否存在，永远也不会碰到引用了也被销毁的实例的情况。

class Person2 {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment2?
    deinit { print("\(name) 222222222222 is being deinitialized") }
}

class Apartment2 {
    let number: Int
    init(number: Int) { self.number = number }
    weak var tenant: Person2?
    deinit { print("Apartment #\(number) 22222222222222222 is being deinitialized") }
}

//  1.3 无主引用：和弱引用相似，无主引用也不强持有实例。但是和弱引用不同的是，无主引用默认始终有值。因此，无主引用只能定义为非可选类型（non-optional type）。在属性、变量前添加unowned关键字，可以声明一个无主引用。

//    注意:当实例被销毁后，试图访问该实例的无主引用会触发运行时错误。使用无主引用时请确保引用始终指向一个未销毁的实例。 上面的非法操作会百分百让应用崩溃，不会发生无法预期的行为。因此，你应该避免这种情况。


//    在这个模型中，消费者不一定有信用卡，但是每张信用卡一定对应一个消费者。鉴于这种关系，Customer类有一个可选类型属性card，而CreditCard类的customer属性则是非可选类型的。
class Customer{

    let name: String
    var card: CreditCard?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("无主引用：---\(name) is being deinitialized")
    }
    
    
}

class CreditCard {
    let  number: Int
    unowned let customer: Customer
    init(number: Int, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    
    
    deinit {
        print("无主引用：---Card #\(number) is being deinitialized")
    }
    
}

//    1.4 无主引用以及隐式展开的可选属性

















