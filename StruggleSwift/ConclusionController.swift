//
//  ConclusionController.swift
//  StruggleSwift
//
//  Created by HuangGang on 2018/3/26.
//  Copyright © 2018年 HuangGang. All rights reserved.
//

import UIKit

class ConclusionController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        

    }
    
//    判断某个对象是什么类型
    func methodOne() {
        let date = NSDate()
        let name1: AnyClass! = object_getClass(date)
        print("--->\(name1)")
        print("-------->\(NSDate.self)")
        
        let date1 = NSDate()
        let name2 = type(of:date1)
        print("---->2\(name2)")
    }
    
//    数组的遍历
    func methodTwo() {
        
        var name: Array<String> = ["金科","李白","黄忠","安琪拉","大白","哑舍","老夫子","凯"]
        for (index, value) in name.enumerated()
        {
            print("name \(index): \(value)")
            
            if value == "李白" {
                name.remove(at: index)
            }
            
        }
        
        for (index, value) in name.enumerated()
        {
            print("--->name \(index): \(value)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
