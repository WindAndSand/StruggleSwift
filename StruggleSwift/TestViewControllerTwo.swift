//
//  TestViewControllerTwo.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/10/29.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

class TestViewControllerTwo: UIViewController {
    var textFiledWidth: Int?
    
    var father: TestViewControllerOne!
    
    typealias titleBlock = (String) -> ()
    var block: titleBlock?
    
//    传值的页面 定义
    typealias labelClosure = ((_ title: String, _ color: UIColor) -> Void)?
//    生成
//    var changeTitleAndClosure: labelClosure
    
    
//    var myFunc = changeLastVcBacgroundColor?()
//
//    func initBack(mathFunction: (changeLastVcBacgroundColor: UIColor)) -> () {
//        myFunc = mathFunction
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        self.textFiledWidth = Int(self.view.bounds.width - 110)

        self.loadUIControl()
        print("------>打印出来")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.textFiledWidth = Int(self.view.bounds.width - 110)
    }
    
    func loadUIControl()  {
        self.view.addSubview(self.textField)
        self.view.addSubview(self.button)
        
        self.view.addSubview(self.textFieldOne)
        self.view.addSubview(self.buttonOne)
        
    }
    
    
//    MAKR: - 控制器 title 改变
    func getBlock(block: titleBlock?) {
        self.block = block
    }
    func tempbuttonAction() {
        if let block = self.block {
            block(self.textField.text!)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func click(){
        self.father.change { (label) in
            label.text = self.textFieldOne.text
        }
//        changeTitleAndClosure?(self.textFieldOne.text!,UIColor.green)
        self.navigationController?.popViewController(animated: true)
    }

    func changeTestTwoController(backgroundColorOne: UIColor, changeClosureOne: ((String, UIColor) -> (Void)),title: String) {
        changeClosureOne("self.textFieldOne.text!", UIColor.red)
        self.title =  title
        self.view.backgroundColor = backgroundColorOne
        print("------->多余的字符串是：\(title)")
    }
    
//    func changeLabelContent(backgroundColorTwo: UIColor, labelStyleClosure: changeTitleAndClosure, title: String) {
//        labelStyleClosure(self.textField.text, UIColor.blue)
//        backgroundColorTwo = UIColor.red
//        title = "************"
//    }
    
//    MARK: - 懒加载
    fileprivate lazy var textField: UITextField = {
        let temp: UITextField = UITextField.init(frame: CGRect(x: 100, y: 100, width: self.textFiledWidth!, height: 30))
        temp.backgroundColor = UIColor.lightGray
        temp.borderStyle = .roundedRect
        return temp
    }()
    fileprivate lazy var button: UIButton = {
        let temp = UIButton.init(frame: CGRect.init(x: 10, y: 100, width: 88, height: 30))
        temp.setTitle("返回", for: .normal)
        temp.backgroundColor = UIColor.groupTableViewBackground
        temp.addTarget(self, action: #selector(tempbuttonAction), for: .touchUpInside)
        return temp
    }()
    
    
    fileprivate lazy var buttonOne: UIButton = {
        let temp = UIButton.init(frame: CGRect.init(x: 10, y: 140, width: 88, height: 30))
        temp.setTitle("返回One", for: .normal)
        temp.backgroundColor = UIColor.black
        temp.addTarget(self, action: #selector(click), for: .touchUpInside)
        return temp
    }()
    fileprivate lazy var textFieldOne: UITextField = {
        let tf: UITextField = UITextField.init(frame: CGRect(x: 100, y: 140, width: 300, height: 30))//UITextField.init(frame: CGRect(x:100, y:140, width:self.textFiledWidth!, height:30))
        tf.borderStyle = .roundedRect
        
        return tf
    }()
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
