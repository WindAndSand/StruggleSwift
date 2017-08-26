//
//  Initialization.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/20.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

class Initialization: NSObject {
    
//    1.1 
    var f = Fahrenheit()
    
//    1.3
    let magenta3 = Color(red: 1.0, green: 1.0, blue: 0.0)
    
//    1.4 我们将属性回答response声明为String?类型，或者说是可选字符串类型optional String。当SurveyQuestion实例化时，它将自动赋值为空nil，表明暂时还不存在此字符串。
    let cheeseQuestion4 = SurveyOuestion4(text: "Do you like cheese?")
    
//    1.5 
    let beetsQuestion5 = SurveyQuestion5(text: "How about beets?")
    
    
//    1.6 由于ShoppingListItem类中的所有属性都有默认值，且它是没有父类的基类，它将自动获得一个可以为所有属性设置默认值的默认构造器（尽管代码中没有显式为name属性设置默认值，但由于name是可选字符串类型，它将默认设置为nil）。上面例子中使用默认构造器创造了一个ShoppingListItem类的实例（使用ShoppingListItem()形式的构造器语法），并将其赋值给变量item。
    var item = ShoppingListItem6()
    
//    1.7 由于这两个存储型属性都有默认值，结构体Size自动获得了一个逐一成员构造器 init(width:height:)。
    let twotByTwo = Size7(width: 2.0, height: 2.0)
    
//    1.8 
//    init()，在功能上跟没有自定义构造器时自动获得的默认构造器是一样的。这个构造器是一个空函数，使用一对大括号{}来描述，它没有执行任何定制的构造过程。调用这个构造器将返回一个Rect实例，它的origin和size属性都使用定义时的默认值Point(x: 0.0, y: 0.0)和Size(width: 0.0, height: 0.0)：
    let basicRect8 = Rect8()
    
//    第二个Rect构造器init(origin:size:)，在功能上跟结构体在没有自定义构造器时获得的逐一成员构造器是一样的。这个构造器只是简单的将origin和size的参数值赋给对应的存储型属性：
    let originRect = Rect8(origin: Point8(x: 2.0, y: 2.0),
                          size: Size8(width: 5.0, height: 5.0))
    
//    第三个Rect构造器init(center:size:)稍微复杂一点。它先通过center和size的值计算出origin的坐标。然后再调用（或代理给）init(origin:size:)构造器来将新的origin和size值赋值到对应的属性中：
    let centerRect = Rect8(center: Point8(x: 4.0, y: 4.0), size: Size8(width: 3.0, height: 3.0)) // centerRect 的原点是 (2.5, 2.5)，尺寸是 (3.0, 3.0)
    
    
//    1.9  构造器init(name: String)被定义为一个指定构造器，因为它能确保所有新Food实例的中存储型属性都被初始化。Food类没有父类，所以init(name: String)构造器不需要调用super.init()来完成构造
    let nameMeat9 = Food9(name: "Bacon")
    
//    Food类同样提供了一个没有参数的便利构造器 init()。这个init()构造器为新食物提供了一个默认的占位名字，通过代理调用同一类中定义的指定构造器init(name: String)并给参数name传值[Unnamed]来实现：
    let mysteryMeat = Food9()
    
    
    let oneMysteryItem = RecipeIngredient9()
    let oneBacon = RecipeIngredient9(name: "Bacon")
    let sixEggs = RecipeIngredient9(name: "Eggs", quantity: 6)
    
    var breakfasltList9 = [ShoppingListItem9(), ShoppingListItem9(name: "Bacon"), ShoppingListItem9(name: "Eggs", quantity: 6),]
    
    
    
    
    
    
    func printSomeThing() {
        
        //        1.1
        print("The default temperature is \(f.temperature) Fahrenheit")
        
        //        1.2
        let  boilingPointerOfWater = Celsius(fromFahreheit: 212.0)
        print("--->boilingPointOfWater.temperatureInCelsius:\(boilingPointerOfWater.temperatureInCelsius)")
        let freezingPointerOfWater = Celsius(fromKelvin: 273.15)
        print("--->freezingPointOfWater.temperatureInCelsius:\(freezingPointerOfWater.temperatureInCelsius)")
        
//        1.4
        cheeseQuestion4.ask()
        cheeseQuestion4.response = "Yes, I do like cheese"
        
//        1.5
        beetsQuestion5.ask()
        beetsQuestion5.response = "I also like beets. (But not with cheese.)"
        
        
//        1.9 
        breakfasltList9[0].name = "Orange juice"
        breakfasltList9[0].purchased = true

        for item in breakfasltList9 {
            print("1.9---->\(item.description)")
        }
        
        
    }

}





//        1 构造器：构造过程是通过定义构造器（Initializers）来实现的，这些构造器可以看做是用来创建特定类型实例的特殊方法。

//        1.1 存储型属性的初始赋值：类和结构体在实例创建时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状态。可以在构造器中为存储型属性赋初值，也可以在定义属性时为其设置默认值。
//        注意：当你为存储型属性设置默认值或者在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观测器.构造器在创建某特定类型的新实例时调用。它的最简形式类似于一个不带任何参数的实例方法，以关键字init命名。

struct Fahrenheit {
    var temperature: Double
    
    init() {
        temperature = 32.0
    }
    
}

//        1.2 定制化构造过程
struct Celsius
{
    var temperatureInCelsius: Double = 0.0
    
    init(fromFahreheit fahrnheit: Double) { //外部名字为fromFahrenheit，内部名字为fahrenheit
        temperatureInCelsius = (fahrnheit - 32.0) / 18
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
}

//    1.3 内部和外部参数名：构造参数也存在一个在构造器内部使用的参数名字和一个在调用构造器时使用的外部参数名字

//    构造器并不像函数和方法那样在括号前有一个可辨别的名字。所以在调用构造器时，主要通过构造器中的参数名和类型来确定需要调用的构造器。正因为参数如此重要，如果你在定义构造器时没有提供参数的外部名字，Swift 会为每个构造器的参数自动生成一个跟内部名字相同的外部名，就相当于在每个构造参数之前加了一个哈希符号

//    注意：如果你不希望为构造器的某个参数提供外部名字，你可以使用下划线_来显示描述它的外部名，以此覆盖上面所说的默认行为。

struct Color {
    var red = 0.0, green = 0.0, blue = 0.0
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}

//    1.4 可选属性类型:如果你定制的类型包含一个逻辑上允许取值为空的存储型属性--不管是因为它无法在初始化时赋值，还是因为它可以在之后某个时间点可以赋值为空--你都需要将它定义为可选类型optional type。可选类型的属性将自动初始化为空nil，表示这个属性是故意在初始化时设置为空的。
class SurveyOuestion4 {

    var text: String
    var response: String?
    
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print("1.4--->\(text)")
    }


}

//    1.5 构造过程中常量属性的修改: 只要在构造过程结束前常量的值能确定，你可以在构造过程中的任意时间点修改常量属性的值
//    注意：对某个类实例来说，它的常量属性只能在定义它的类的构造过程中修改；不能在子类中修改。

class SurveyQuestion5 {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print("1.5--->\(text)") //用常量属性替代变量属性text，指明问题内容text在其创建之后不会再被修改。尽管text属性现在是常量，我们仍然可以在其类的构造器中修改它的值：
    }
}


//    1.6 默认构造器 :Swift 将为所有属性已提供默认值的且自身没有定义任何构造器的结构体或基类，提供一个默认的构造器。这个默认构造器将简单的创建一个所有属性值都设置为默认值的实例。
class ShoppingListItem6 {

    var name: String?
    var quantity = 1
    var purchased = false
    
}


//    1.7 结构体的逐一成员构造器:如果结构体对所有存储型属性提供了默认值且自身没有提供定制的构造器，它们能自动获得一个逐一成员构造器, 逐一成员构造器是用来初始化结构体新实例里成员属性的快捷方法。我们在调用逐一成员构造器时，通过与成员属性名相同的参数名进行传值来完成对成员属性的初始赋值。
struct Size7 {
    var width = 0.0, height = 0.0
    
}

//    1.8 值类型的构造器代理:构造器可以通过调用其它构造器来完成实例的部分构造过程。这一过程称为构造器代理，它能减少多个构造器间的代码重复。
//    构造器代理的实现规则和形式在值类型和类类型中有所不同。值类型（结构体和枚举类型）不支持继承，所以构造器代理的过程相对简单，因为它们只能代理任务给本身提供的其它构造器。类则不同，它可以继承自其它类（请参考继承），这意味着类有责任保证其所有继承的存储型属性在构造时也能正确的初始化

//    对于值类型，你可以使用self.init在自定义的构造器中引用其它的属于相同值类型的构造器。并且你只能在构造器内部调用self.init。 

//    注意，如果你为某个值类型定义了一个定制的构造器，你将无法访问到默认构造器（如果是结构体，则无法访问逐一对象构造器）。这个限制可以防止你在为值类型定义了一个更复杂的，完成了重要准备构造器之后，别人还是错误的使用了那个自动生成的构造器。

//    注意：假如你想通过默认构造器、逐一对象构造器以及你自己定制的构造器为值类型创建实例，我们建议你将自己定制的构造器写到扩展（extension）中，而不是跟值类型定义混在一起。

struct Size8 {
    var width = 0.0, height = 0.0
    
}

struct Point8 {
    var x = 0.0, y = 0.0
    
}

//    可以通过以下三种方式为Rect8创建实例--使用默认的0值来初始化origin和size属性；使用特定的origin和size实例来初始化；使用特定的center和size来初始化。在下面Rect结构体定义中，我们为着三种方式提供了三个自定义的构造器：
struct Rect8 {

    var origin = Point8()
    var size = Size8()
    
    init() {}
    
    init(origin: Point8, size: Size8) {
        self.origin = origin
        self.size = size
    }
    
    init(center: Point8, size: Size8) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        
        self.init(origin: Point8(x: originX, y: originY), size: size)
        
        
    }
}

//    1.9 类的继承和构造过程:类里面的所有存储型属性--包括所有继承自父类的属性--都必须在构造过程中设置初始值。Swift 提供了两种类型的类构造器来确保所有类实例中存储型属性都能获得初始值，它们分别是指定构造器和便利构造器。
//        1.9.1 指定构造器和便利构造器:指定构造器是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性，并根据父类链往上调用父类的构造器来实现父类的初始化。
/*
            构造器链
            为了简化指定构造器和便利构造器之间的调用关系，Swift 采用以下三条规则来限制构造器之间的代理调用：

            规则 1
            指定构造器必须调用其直接父类的的指定构造器。

            规则 2
            便利构造器必须调用同一类中定义的其它构造器。

            规则 3
            便利构造器必须最终以调用一个指定构造器结束。

            一个更方便记忆的方法是：

            指定构造器必须总是向上代理
            便利构造器必须总是横向代理
 */
//            1.9.2 两段式构造过程:Swift 中类的构造过程包含两个阶段。第一个阶段，每个存储型属性通过引入它们的类的构造器来设置初始值。当每一个存储型属性值被确定后，第二阶段开始，它给每个类一次机会在新实例准备使用之前进一步定制它们的存储型属性。

//            1.9.3：指定构造器和便利构造器的语法
/*
                类的指定构造器的写法跟值类型简单构造器一样：
 
                init(parameters) {
                    statements
                }
                便利构造器也采用相同样式的写法，但需要在init关键字之前放置convenience关键字，并使用空格将它们俩分开：
                convenience init(parameters) {
                statements
                }
 */

class Food9 {

    var  name: String
    init(name: String) {  //指定 构造器
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
    
}

//    类层级中的第二个类是Food的子类RecipeIngredient。RecipeIngredient类构建了食谱中的一味调味剂。它引入了Int类型的数量属性quantity（以及从Food继承过来的name属性），并且定义了两个构造器来创建Recipe
class RecipeIngredient9: Food9 {
    var quantity: Int
    
//    RecipeIngredient类拥有一个指定构造器init(name: String, quantity: Int)，它可以用来产生新RecipeIngredient实例的所有属性值。这个构造器一开始先将传入的quantity参数赋值给quantity属性，这个属性也是唯一在RecipeIngredient中新引入的属性。随后，构造器将任务向上代理给父类Food的init(name: String)。这个过程满足两段式构造过程中的安全检查1。
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
//    RecipeIngredient也定义了一个便利构造器init(name: String)，它只通过name来创建RecipeIngredient的实例。这个便利构造器假设任意RecipeIngredient实例的quantity为1，所以不需要显示指明数量即可创建出实例。这个便利构造器的定义可以让创建实例更加方便和快捷，并且避免了使用重复的代码来创建多个quantity为 1 的RecipeIngredient实例。这个便利构造器只是简单的将任务代理给了同一类里提供的指定构造器。
    
    convenience override init(name: String) {
        self.init(name: name, quantity: 1)
    }
    
}

//    注意，RecipeIngredient的便利构造器init(name: String)使用了跟Food中指定构造器init(name: String)相同的参数。尽管RecipeIngredient这个构造器是便利构造器，RecipeIngredient依然提供了对所有父类指定构造器的实现。因此，RecipeIngredient也能自动继承了所有父类的便利构造器。

//    注意，RecipeIngredient的便利构造器init(name: String)使用了跟Food中指定构造器init(name: String)相同的参数。尽管RecipeIngredient这个构造器是便利构造器，RecipeIngredient依然提供了对所有父类指定构造器的实现。因此，RecipeIngredient也能自动继承了所有父类的便利构造器。

//    由于它为自己引入的所有属性都提供了默认值，并且自己没有定义任何构造器，ShoppingListItem将自动继承所有父类中的指定构造器和便利构造器。

class ShoppingListItem9: RecipeIngredient9 {
    var purchased = false
    
    var description: String {
        var output = "\(quantity) x \(name.lowercased())"
        output += purchased ? " ?" : " ?"
        
        return output
        
    }
    
    
}


//    2.1 通过闭包和函数来设置属性的默认值:如果某个存储型属性的默认值需要特别的定制或准备，你就可以使用闭包或全局函数来为其属性提供定制的默认值。每当某个属性所属的新类型实例创建时，对应的闭包或函数会被调用，而它们的返回值会当做默认值赋值给这个属性。

//    这种类型的闭包或函数一般会创建一个跟属性类型相同的临时变量，然后修改它的值以满足预期的初始状态，最后将这个临时变量的值作为属性的默认值进行返回

/*
class SomeClas2_1 {

    
    let someProperty: SomeType = {
        
        // 在这个闭包中给 someProperty 创建一个默认值
        // someValue 必须和 SomeType 类型相同
        return someValue
    }()
    
//    注意闭包结尾的大括号后面接了一对空的小括号。这是用来告诉 Swift 需要立刻执行此闭包。如果你忽略了这对括号，相当于是将闭包本身作为值赋值给了属性，而不是将闭包的返回值赋值给属性。
}
 */

//demo
//  结构体Checkerboard，它构建了西洋跳棋游戏的棋盘：Checkerboard结构体定义了一个属性boardColors，它是一个包含 100 个布尔值的数组。数组中的某元素布尔值为true表示对应的是一个黑格，布尔值为false表示对应的是一个白格。数组中第一个元素代表棋盘上左上角的格子，最后一个元素代表棋盘上右下角的格子。

//  boardColor数组是通过一个闭包来初始化和组装颜色值的：
/*
struct Checkerboard {
    let boardColors: Bool[] = {
        var temporaryBoard = Bool[]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[(row * 10) + column]
    }
}

 每当一个新的Checkerboard实例创建时，对应的赋值闭包会执行，一系列颜色值会被计算出来作为默认值赋值给boardColors。上面例子中描述的闭包将计算出棋盘中每个格子合适的颜色，将这些颜色值保存到一个临时数组temporaryBoard中，并在构建完成时将此数组作为闭包返回值返回。这个返回的值将保存到boardColors中，并可以通squareIsBlackAtRow这个工具函数来查询。
 let board = Checkerboard()
 println(board.squareIsBlackAtRow(0, column: 1))
 // 输出 "true"
 println(board.squareIsBlackAtRow(9, column: 9))
 // 输出 "false"
 */
