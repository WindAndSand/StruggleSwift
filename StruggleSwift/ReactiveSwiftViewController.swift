//
//  ReactiveSwiftViewController.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/11/28.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit//http://www.jianshu.com/p/3a56d10e99a7

class ReactiveSwiftViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameTextField.delegate = self;
        self.view.addSubview(self.usernameTextField)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //收起键盘
        textField.resignFirstResponder()
        //打印出文本框中的值
        print(textField.text ?? "")
        return true
    }
    
    lazy var usernameTextField: UITextField = {
        let userName = UITextField()
        userName.borderStyle = UITextBorderStyle.roundedRect
        userName.layer.masksToBounds = true
        userName.layer.cornerRadius = 12.0  //圆角半径
        userName.layer.borderWidth = 2.0  //边框粗细
        userName.layer.borderColor = UIColor.red.cgColor //边框颜色
        userName.placeholder="请输入用户名"
        userName.textAlignment = .left //水平左对齐
        userName.borderStyle = .none //先要去除边框样式
        userName.clearButtonMode = .whileEditing  //编辑时出现清除按钮
        return userName
    }()
    
    lazy var passwordTextField: UITextField = {
        let userName = UITextField()
        userName.borderStyle = UITextBorderStyle.roundedRect
        userName.layer.masksToBounds = true
        userName.layer.cornerRadius = 12.0  //圆角半径
        userName.layer.borderWidth = 2.0  //边框粗细
        userName.layer.borderColor = UIColor.red.cgColor //边框颜色
        userName.placeholder="请输入用户名"
        userName.textAlignment = .left //水平左对齐
        userName.borderStyle = .none //先要去除边框样式
        userName.clearButtonMode = .whileEditing  //编辑时出现清除按钮
        return userName
    }()
    lazy var signInFailureTextLabel: UILabel = {
        let signInFailure = UILabel()
        signInFailure.textColor=UIColor.red
        signInFailure.textAlignment=NSTextAlignment.center
        signInFailure.numberOfLines = 0
        signInFailure.adjustsFontSizeToFitWidth = true //当文字超出标签宽度时，自动调整文字大小，使其不被截断
        return signInFailure
    }()
    
    lazy var signInButton: UIButton = {
        let signIn = UIButton()
        signIn.setTitle("嘿嘿", for: .normal)
        signIn.setTitleColor(UIColor.blue, for: .normal)
        signIn.backgroundColor = UIColor.brown
        return signIn
    }()
    

}
