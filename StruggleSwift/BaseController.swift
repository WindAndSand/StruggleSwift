//
//  BaseController.swift
//  StruggleSwift
//
//  Created by 黄刚 on 2017/8/17.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.enumeration()
        
//        self.classAndStruct()
        
//        self.properties()
        
//        self.method()
        
//        self.affiliatedScript()
        
        
        

    }
    
    
//    类和结构体
    func classAndStruct() {
        let CAS = ClassAndStruct()
        CAS.printSomeThing()
    }
    
//    属性
    func properties()  {
        let properties = Properties()
        properties.printSomeThing()
    }
    
//    方法
    func method()  {
        let metod = Methods()
        metod.printSomeThing()
    }
    
//    附属脚本
    func affiliatedScript() {
        let affiliatedScript = AffiliatedScript()
        affiliatedScript.printSomeThing()
        
        self.arc()
        
    }
    
//    枚举
    func enumeration() {
        let enumeration = Enumeration()
        enumeration.printSomeThing()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func arc() {
        let arc = ARC()
        arc.printSomeThing()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
