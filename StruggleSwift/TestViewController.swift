//
//  TestViewController.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/10/15.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        self.createClourseView()
    }
    
//    MARK: - 创建闭包View
    func createClourseView(){
//    创建CustomView对象
        let cutomeView = TestView(frame: CGRect(x: 0, y: 64, width: 200, height: 200));
        cutomeView.backgroundColor = UIColor.yellow
        self.view.addSubview(cutomeView)
//    给cutomeView的btnClickBlock闭包属性赋值
        cutomeView.btnClickBlock = {
//    () in 无参数可以省略
//    当按钮被点击时会执行此代码块
            print("按钮被点击");
        }
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
