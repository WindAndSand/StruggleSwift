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
        
        
//        self.classAndStruct()
        
//        self.properties()
        
        self.method()
        
        

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
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
