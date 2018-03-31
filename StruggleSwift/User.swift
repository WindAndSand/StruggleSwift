//
//  User.swift
//  StruggleSwift
//
//  Created by HuangGang on 2018/3/30.
//  Copyright © 2018年 HuangGang. All rights reserved.
//

import UIKit
import ObjectMapper

class User: Mappable {
    var username: String?
    var age: Int?
    var weight: Double!
    var bestFriend: User?        // User对象
    var friends: [User]?         // Users数组
    var birthday: Date?
    var array: [AnyObject]?
    var dictionary: [String : AnyObject] = [:]
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        username    <- map["username"]
        age         <- map["age"]
        weight      <- map["weight"]
        bestFriend  <- map["best_friend"]
        friends     <- map["friends"]
        birthday    <- (map["birthday"], DateTransform())
        array       <- map["arr"]
        dictionary  <- map["dict"]
    }
    

}
