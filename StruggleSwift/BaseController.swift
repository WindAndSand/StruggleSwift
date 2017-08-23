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
        
        let CAS = ClassAndStruct()
        CAS.printSomeThing()
        
        self.arc()
        

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
