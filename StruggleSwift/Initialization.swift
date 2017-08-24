//
//  Initialization.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/20.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

class Initialization: NSObject {
    
    var f = Fahrenheit()
    
    
    func printSomeThing() {
        
        //        1.1
        print("The default temperature is \(f.temperature) Fahrenheit")
        
        //        1.2
        let  boilingPointerOfWater = Celsius(fromFahreheit: 212.0)
        print("--->boilingPointOfWater.temperatureInCelsius:\(boilingPointerOfWater.temperatureInCelsius)")
        let freezingPointerOfWater = Celsius(fromKelvin: 273.15)
        print("--->freezingPointOfWater.temperatureInCelsius:\(freezingPointerOfWater.temperatureInCelsius)")
        
        
        
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



