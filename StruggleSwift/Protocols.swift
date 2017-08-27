//
//  Protocols.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/26.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

//    1 Protocol(协议)用于统一方法和属性的名称，而不实现任何功能。协议能够被类，枚举，结构体实现，满足协议要求的类，枚举，结构体被称为协议的遵循者
class Protocols: NSObject {
    
//    1.2 
    let john = Person1_2(fullName: "John Appleseed")
    
//    1.3
    let generator = LinearCongruentialGenerator()
    
//    1.4
    var lightSwitch4 = OnOffSwitch.Off
    
//    1.5
    var d5 = Dice(sides: 6, generator: LinearCongruentialGenerator())
    
    
//    1.6 
    let tracker = DiceGameTracker()
//    let game = SnakesAndLadders()
//    game.delegate = tracker
//    game.play()
    
//    1.7
    let d7 = Dice(sides: 12,generator: LinearCongruentialGenerator())
    
//    1.8 Hamster的实例可以作为TextRepresentable类型使用
    let simonTheHamster = Hamster(name: "Simon")
    
//    1.9 
    
//    2.2 Named协议包含String类型的name属性；Aged协议包含Int类型的age属性。Person结构体遵循了这两个协议
    let birthdayPerson = Person2_2(name: "Malcolm", age: 21)
    
//    2.3Circle,Country,Animal并没有一个相同的基类，所以采用AnyObject类型的数组来装载在他们的实例

    let objects: [AnyObject] = [
        Circle(radius: 2.0),
        Country2_3(area: 243_610),
        Animal(legs: 4)
    ]
    
//    2.4 使用ThreeSource作为数据源开实例化一个Counter
    var counter = Counter2_4()
    


    
    
    
//    MARK: - printSomeThing()
    func printSomeThing()  {
        
//        1.2
        print("1.2-->john.name:\(john.fullName)")
        
//        1.3
        print("Here's a random number: \(generator.random())")
        
        print("And another one: \(generator.random())")
        
//        1.4
        lightSwitch4.toggle()
        
//        1.5
        for _ in 1...5{
            print("Random dice roll is \(d5.roll())")
        }
        
        
//        1.7
        print(d7.asText())
        // 输出 "A 12-sided dice"let d12 = Dice(sides: 12,generator: LinearCongruentialGenerator())
        print(d7.asText())
        // 输出 "A 12-sided dice"let d12 = Dice(sides: 12,generator: LinearCongruentialGenerator())
        print(d7.asText())
        
        
//        1.8
        let somethingTextRepresentable: TextRepresentable = simonTheHamster //注意：即时满足了协议的所有要求，类型也不会自动转变，因此你必须为它做出明显的协议声明
        print(somethingTextRepresentable.asText())
        // 输出 "A hamster named Simon"
        
        
//        1.9 thing被当做是TextRepresentable类型而不是Dice，DiceGame，Hamster等类型。因此能且仅能调用asText方法
        let things: [TextRepresentable] = [d7,simonTheHamster]
        for thing in things {
            print(thing.asText())
        }
        
        
//        2.2
        wishHappyBirthday(celebrator: birthdayPerson)
        
//        2.3 在迭代时检查object数组的元素是否遵循了HasArea协议：
        
        for object in objects {
            if let objectWithArea = object as? HasArea {    //objects数组中元素的类型并不会因为向下转型而改变，当它们被赋值给objectWithArea时只被视为HasArea类型，因此只有area属性能够被访问。
                print("Area is \(objectWithArea.area)")
            } else {
                print("Something that doesn't have an area")
            } 
        }
        
        
//        2.4
        counter.dataSource = ThreeSource()
        for _ in 1...4 {
            print("2.4--->counter.count:\(counter.count)")
        }
        
        
        counter.count = -4
        counter.dataSource = TowardsZeroSource()
        for _ in 1...5 {
            counter.increment()
            print(counter.count)
        }

    }

}


//    1.1 协议的语法 :在类，结构体，枚举的名称后加上协议名称，中间以冒号:分隔即可实现协议；实现多个协议时，各协议之间用逗号,分隔
//    遵循者需要提供协议指定的成员，如属性，方法，操作符，下标等
//    当某个类含有父类的同时并实现了协议，应当把父类放在所有的协议之前


//    1.2 属性要求:协议能够要求其遵循者必须含有一些特定名称和类型的实例属性或类属性，也能够要求属性的(设置权限)settable 和(访问权限)gettable，但它不要求属性是存储型属性还是计算型属性。

//    通常前置var关键字将属性声明为变量。在属性声明后写上{ get set }表示属性为可读写的。{ get }用来表示属性为可读的。即使你为可读的属性实现了setter方法，它也不会出错

protocol SomeProtocol{

    var musBeSettable: Int{get set}
    var doesNotNeedToBeSettable: Int { get }
    
    
}

//    用类来实现协议时，使用class关键字来表示该属性为类成员；用结构体或枚举实现协议时，则使用static关键字来表示：
protocol AnotherProtocol{
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String{ get }
    
}

struct Person1_2: FullyNamed {
//    Person结构体含有一个名为fullName的存储型属性，完整的遵循了协议。(若协议未被完整遵循，编译时则会报错)。
    
    var fullName: String
    
}

class  Starship: FullyNamed {
//    Starship类将fullName实现为可读的计算型属性。它的每一个实例都有一个名为name的必备属性和一个名为prefix的可选属性。 当prefix存在时，将prefix插入到name之前来为Starship构建fullName。
    var prefix: String?
    var name: String
    
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String {
    
    return (prefix!) + name
    }
    
    
    
}

//    1.3 方法要求:协议能够要求其遵循者必备某些特定的实例方法和类方法。协议方法的声明与普通方法声明相似，但它不需要方法内容。
//    注意： 协议方法支持变长参数(variadic parameter)，不支持默认参数(default parameter)。前置class关键字表示协议中的成员为类成员；当协议用于被枚举或结构体遵循时，则使用static关键字。

protocol SomeProtocol3 {
    static func someTypeMethod ()
}

protocol RandomNumberGenerator {
    func random() -> Double //RandomNumberGenerator3协议要求其遵循者必须拥有一个名为random， 返回值类型为Double的实例方法。
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) / m)
        return lastRandom / m
    }

  
    
}


//    1.4 突变方法要求:能在方法或函数内部改变实例类型的方法称为突变方法。在值类型(Value Type)(译者注：特指结构体和枚举)中的的函数前缀加上mutating关键字来表示该函数允许改变该实例和其属性的类型
//    类中的成员为引用类型(Reference Type)，可以方便的修改实例及其属性的值而无需改变类型；而结构体和枚举中的成员均为值类型(Value Type)，修改变量的值就相当于修改变量的类型，而Swift默认不允许修改类型，因此需要前置mutating关键字用来表示该函数中能够修改类型

//    注意：用class实现协议中的mutating方法时，不用写mutating关键字；用结构体，枚举实现协议中的mutating方法时，必须写mutating关键字。

//    根据函数名称推测，toggle可能用于切换或恢复某个属性的状态。mutating关键字表示它为突变方法：
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case .Off:
            self = .On
        case .On:
            self = .Off
        }
    }
}


//    1.5 协议类型:协议本身不实现任何功能，但你可以将它当做类型来使用。
    /*
        使用场景：
        a. 作为函数，方法或构造器中的参数类型，返回值类型
        b. 作为常量，变量，属性的类型
        c. 作为数组，字典或其他容器中的元素类型
    */


//    Dice含有sides和generator两个属性，前者用来表示骰子有几个面，后者为骰子提供一个随机数生成器。由于后者为RandomNumberGenerator的协议类型。所以它能够被赋值为任意遵循该协议的类型。

//    使用构造器(init)来代替之前版本中的setup操作。构造器中含有一个名为generator，类型为RandomNumberGenerator的形参，使得它可以接收任意遵循RandomNumberGenerator协议的类型
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

//    1.6 委托(代理)模式:委托是一种设计模式，它允许类或结构体将一些需要它们负责的功能交由(委托)给其他的类型。

//    委托模式的实现很简单： 定义协议来封装那些需要被委托的函数和方法， 使其遵循者拥有这些被委托的函数和方法。

//    DiceGame协议可以在任意含有骰子的游戏中实现，DiceGameDelegate协议可以用来追踪DiceGame的游戏过程
protocol DiceGame {
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll:Int)
    func gameDidEnd(game: DiceGame)
}

/*
class SnakesAndLadders: DiceGame {
    var dice: Dice

    let finalSquare = 25
    let dic = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = [Int] (repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(game: self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(game: self,didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(game: self)
    }
} 
 
//    注意：因为delegate并不是该游戏的必备条件，delegate被定义为遵循DiceGameDelegate协议的可选属性
 DicegameDelegate协议提供了三个方法用来追踪游戏过程。被放置于游戏的逻辑中，即play()方法内。分别在游戏开始时，新一轮开始时，游戏结束时被调用。
*/

//    因为delegate是一个遵循DiceGameDelegate的可选属性，因此在play()方法中使用了可选链来调用委托方法。 若delegate属性为nil， 则委托调用优雅地失效。若delegate不为nil，则委托方法被调用


//    DiceGameTracker遵循了DiceGameDelegate协议
class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
//        if game is SnakesAndLadders {
//            print("Started a new game of Snakes and Ladders")
//        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}


//    1.7 在扩展中添加协议成员:即便无法修改源代码，依然可以通过扩展(Extension)来扩充已存在类型(译者注： 类，结构体，枚举等)。扩展可以为已存在的类型添加属性，方法，下标，协议等成员

//    注意： 通过扩展为已存在的类型遵循协议时，该类型的所有实例也会随之添加协议中的方法

protocol TextRepresentable {
    func asText() -> String
}



//    通过扩展为上一节中提到的Dice类遵循TextRepresentable协议
extension Dice: TextRepresentable {
    func asText() -> String {
        return "A \(sides)-sided dice"
    }

}


//    1.8 通过延展补充协议声明:当一个类型已经实现了协议中的所有要求，却没有声明时，可以通过扩展来补充协议声明：
struct Hamster {
    var name: String
    func asText() -> String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}


//    1.9:集合中的协议类型:协议类型可以被集合使用，表示集合中的元素均为协议类型：




//    2.1 协议的继承:协议能够继承一到多个其他协议。语法与类的继承相似，多个协议间用逗号,分隔
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // 协议定义
}
//    如下所示，PrettyTextRepresentable协议继承了TextRepresentable协议,遵循PrettyTextRepresentable协议的同时，也需要遵循TextRepresentable`协议。

protocol PrettyTextRepresentable: TextRepresentable {
    func asPrettyText() -> String
}

/*
extension SnakesAndLadders: PrettyTextRepresentable {
    func asPrettyText() -> String {
        var output = asText() + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}
 */


//    2.2 协议合成:一个协议可由多个协议采用protocol这样的格式进行组合，称为协议合成(protocol composition)。
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person2_2: Named, Aged {
    var name: String
    var age: Int
}

//    wishHappyBirthday函数的形参celebrator的类型为protocol。可以传入任意遵循这两个协议的类型的实例
func wishHappyBirthday(celebrator: Person2_2) {
    print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}

//    2.3 检验协议的一致性:使用is检验协议一致性，使用as将协议类型向下转换(downcast)为的其他协议类型。检验与转换的语法和之前相同(详情查看类型检查)：
//        a. is操作符用来检查实例是否遵循了某个协议。
//        b. as?返回一个可选值，当实例遵循协议时，返回该协议类型；否则返回nil
//        c. as用以强制向下转换型。

//    注意：@objc用来表示协议是可选的，也可以用来表示暴露给Objective-C的代码，此外，@objc型协议只对类有效，因此只能在类中检查协议的一致性
@objc protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    var area: Double

    let pi = 3.1415927
    var radius: Double = 0.0
    init(radius: Double) {
        self.radius = radius
        self.area = pi * radius * radius
    }
}
class Country2_3: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

//    Circle和Country都遵循了HasArea协议，前者把area写为计算型属性（computed property），后者则把area写为存储型属性（stored property）。

//    Animal类没有实现任何协议
class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

//    2.4 可选协议要求:可选协议含有可选成员，其遵循者可以选择是否实现这些成员。在协议中使用@optional关键字作为前缀来定义可选成员。
//    注意：可选协议只能在含有@objc前缀的协议中生效。且@objc的协议只能被类遵循。
//    Counter类使用CounterDataSource类型的外部数据源来提供增量值(increment amount)，如下所示：
@objc protocol CounterDataSource {
    @objc optional func incrementForCount(count: Int) -> Int    //可选方法
    @objc optional var fixedIncrement: Int { get }  //可选属性
}

//    注意：CounterDataSource中的属性和方法都是可选的，因此可以在类中声明但不实现这些成员，尽管技术上允许这样做，不过最好不要这样写。

//    Counter类含有CounterDataSource?类型的可选属性dataSource，如下所示：
class Counter2_4 {
//    count属性用于存储当前的值，increment方法用来为count赋值。
    
    var count = 0
    var dataSource: CounterDataSource?
    
//    当incrementForCount不能被调用时，尝试使用可选属性fixedIncrement来代替。
    func increment() {  //increment方法通过可选链，尝试从两种可选成员中获取count。
        if let amount = dataSource?.incrementForCount?(count: count) {  //在dataSource后边加上了?标记来表明只在dataSource非空时才去调用incrementForCount`方法。
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}


//    ThreeSource实现了CounterDataSource协议，如下所示：
class ThreeSource: CounterDataSource {
    let fixedIncrement = 3
}


//    TowardsZeroSource实现了CounterDataSource协议中的incrementForCount方法，如下所示：
class TowardsZeroSource: CounterDataSource {
    func incrementForCount(count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}


