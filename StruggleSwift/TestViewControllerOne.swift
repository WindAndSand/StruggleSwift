//
//  TestViewController.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/10/15.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit
//Block传值，需要注意的是，谁传值就需要定义Block，捕获方仅仅需要传递Block给传值方，并处理捕获的值。


class TestViewControllerOne: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        self.title = "Block 的值"
        
        self.createClourseView()
        
//        加载控件
        self.loadUIControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let VC = TestViewControllerTwo()
        VC.father = self
        VC.getBlock(block: { (value) in
            self.title = value
        })
        VC.changeTestTwoController(backgroundColorOne: UIColor.groupTableViewBackground, changeClosureOne: { (labelOne, backgroundColorOne) -> (Void) in
            self.labelText.text = labelOne
            self.labelText.backgroundColor = backgroundColorOne
        }, title: "TestViewControllerTwo")
        
        
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func changeTestTwoController(backgroundColorOne: UIColor, changeClosureOne: ((UILabel, UIColor) -> (Void)),title: String) {
        changeClosureOne(self.labelText, self.labelText.backgroundColor!)
        self.title =  title
        self.view.backgroundColor = backgroundColorOne
        print("------->多余的字符串是：\(title)")
    }
    
    
    func change(block: (UILabel)->()) {
        block(self.labelText)
//        self.labelText.text = text
    }
    
//    MARK: - 创建闭包View
    func createClourseView(){
//    创建CustomView对象
        let cutomeView = TestView(frame: CGRect(x: 0, y: 64, width: self.view.frame.width, height: 200));
        cutomeView.backgroundColor = UIColor.yellow
        self.view.addSubview(cutomeView)
//    给cutomeView的btnClickBlock闭包属性赋值
        cutomeView.btnClickBlock = {
//    () in 无参数可以省略
//    当按钮被点击时会执行此代码块
            print("按钮被点击");
        }
    }
    
    func loadUIControl()  {
        self.view.addSubview(self.labelText)
    }
    
//    MARK: - 懒加载
//    fileprivate 
    fileprivate lazy var labelText: UILabel = {
        let labelText = UILabel(frame: CGRect(x: 0, y: 280, width: self.view.frame.width, height: 30))
        labelText.backgroundColor = UIColor.lightGray
        labelText.text = "Block 回传值过来"
        labelText.textColor = UIColor.blue
        labelText.font = UIFont.systemFont(ofSize: 20)
        return labelText
    }()
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

}
