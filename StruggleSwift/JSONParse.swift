//
//  JSONParse.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/12/19.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

//参考资料：http://www.rockerhx.com/2017/09/25/2017-09-25-Swift4-Codable-Basic/
struct Swifter: Decodable {
    let fullName: String
    let id: Int
    let twitter: URL
}

//enum SwifterOrBool: Decodable {
//
//    case swifter(Swifter)
//    case bool(Bool)
//}

struct SwifterOne: Codable {
    let fullName: String
    let id: Int
    let twitter: URL
}

enum BeerStyle : String, Codable {
    case ipa
    case stout
    case kolsch
    // ...
}
struct Beer: Codable {
    let name: String
    let brewery: String
    let abv: Float
    let style: BeerStyle
}

enum MyStructKeys: String, CodingKey {
    case fullName = "fullName"
    case id = "id"
    case twitter = "twitter"
}


struct MoreComplexStruct: Decodable {
    let swifter: Swifter
    let lovesSwift: Bool
}

class JSONParse: NSObject, Codable {

    func pareJSONOne()  {
        let json = """
        {
            "fullName": "Federico Zanetello",
            "id": 123456,
            "twitter": "http://twitter.com/zntfdr"
        }
        """.data(using: .utf8)! // our data in native (JSON) format
        do {
            let myStruct = try JSONDecoder().decode(Swifter.self, from: json) // Decoding our data
            print(myStruct)
        } catch  {
            print(error.localizedDescription)  //注意这里:error是抛出的Error对象，这个对象没有通过var error:Error创建，在catch的大括号里直接就能拿到，如果想要取得错误信息，直接处理error就可以
        }
    }
    
    func pareJSONTwo()  {
        let json = """
        {
            "name": "Endeavor",
            "abv": 8.9,
            "brewery": "Saint Arnold",
            "style": "ipa"
        }
        """.data(using: .utf8)! // our data in native (JSON) format
        do {
            let myStruct = try JSONDecoder().decode(Beer.self, from: json) // Decoding our data
            print(myStruct)
        } catch  {
            print(error.localizedDescription)  //注意这里:error是抛出的Error对象，这个对象没有通过var error:Error创建，在catch的大括号里直接就能拿到，如果想要取得错误信息，直接处理error就可以
        }
        
    }
    
//    MARK: 自定义解析数据
    func pareJSONThree()  {
        let json = """
        {
            "fullName": "Federico Zanetello",
            "id": 123456,
            "twitter": "http://twitter.com/zntfdr"
        }
        """.data(using: .utf8)
        let decoder = JSONDecoder()
//        接下来创建容器
//        let container = try decoder.container(keyedBy: MyStructKeys.self)
////        提取数据:做类型转换
//        let fullName: String = try container.decode(String.self, forKey: .fullName)
//        let id: Int = try container.decode(Int.self, forKey: .id)
//        let twitter: URL = try container.decode(URL.self, forKey: .twitter)
////        初始化,使用默认的构造器：
//        let myStruct = Swifter(fullName: fullName, id: id, twitter: twitter)
        
    }
    
//    MARK: - 复杂结构处理,数组
    func pareJSONFour()  {
        let json = """
        [
            {
                "fullName": "Federico Zanetello",
                "id": 123456,
                "twitter": "http://twitter.com/zntfdr"
            },
            {
                "fullName": "Federico Zanetello",
                "id": 123456,
                "twitter": "http://twitter.com/zntfdr"
            },
            {
                "fullName": "Federico Zanetello",
                "id": 123456,
                "twitter": "http://twitter.com/zntfdr"
            }
        ]
        """.data(using: .utf8)!
        do {
            let myStructArray = try JSONDecoder().decode([Swifter].self, from: json)
            myStructArray.forEach { print($0) }

        } catch  {
            print(error.localizedDescription)
        }
    }
    
//    MARK: - 字典
    func pareJSONFive()  {
        let json = """
        {
            "one": {
                "fullName": "Federico Zanetello",
                "id": 123456,
                "twitter": "http://twitter.com/zntfdr"
            },
            "two": {
                "fullName": "Federico Zanetello",
                "id": 123456,
                "twitter": "http://twitter.com/zntfdr"
            },
            "three": {
                "fullName": "Federico Zanetello",
                "id": 123456,
                "twitter": "http://twitter.com/zntfdr"
            }
        }
        """.data(using: .utf8)! // our data in native format

        do {
            let myStructDictionary = try JSONDecoder().decode([String: SwifterOne].self, from: json)
            myStructDictionary.forEach { print("\($0.key): \($0.value)") }
            
        } catch  {
            print(error.localizedDescription)
        }
        
    }
    
    //    MARK: - 枚举
    func pareJSONSix()  {
        
    }
    
//    MARK: - 嵌套结构
    func pareJSONSeven()  {
        let json = """
        {
            "swifter": {
                "fullName": "Federico Zanetello",
                "id": 123456,
                "twitter": "http://twitter.com/zntfdr"
            },
            "lovesSwift": true
        }
        """.data(using: .utf8)! // our data in native format
        do {
            let myMoreComplexStruct = try JSONDecoder().decode(MoreComplexStruct.self, from: json)
            print(myMoreComplexStruct.swifter)
            
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    
}
