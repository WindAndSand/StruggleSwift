//
//  SSKeyChainController.swift
//  StruggleSwift
//
//  Created by 黄刚 on 2017/12/24.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

class SSKeyChainController: UIViewController, UITextFieldDelegate {
    let KEY_USERNAME_PASSWORD: String = "com.company.app.usernamepassword"
    let KEY_USERNAME: String = "com.company.app.username"
    let KEY_PASSWORD: String = "com.company.app.password"
    let saveInfomation = NSMutableDictionary()
    
    lazy var userText: UITextField = {
        let textField = UITextField()
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.placeholder = "userName"
        textField.textColor = UIColor.blue
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textAlignment = NSTextAlignment.center // 居中对齐
        // 设置 文字超出文本框时自适应大小
        textField.adjustsFontSizeToFitWidth = true
        // 设置 最小可缩小的字号
        textField.minimumFontSize = 13
        // 设置 清理按钮 (.never 从不出现 .whileEditing 编辑时出现 .unlessEditing 编辑时不出现 编辑完后出现 .always 一直出现)
        textField.clearButtonMode = UITextFieldViewMode.whileEditing
        //  设置 键盘样式
        textField.keyboardType = UIKeyboardType.default
        // 设置 代理
        textField.delegate = self
        textField.addTarget(self, action: #selector(oneMethod(textField:)), for: UIControlEvents.editingChanged)
        return textField
    }()
    
    lazy var passwordText: UITextField = {
        let textField = UITextField()
        textField.borderStyle = UITextBorderStyle.roundedRect
        textField.placeholder = "userName"
        textField.textColor = UIColor.blue
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textAlignment = NSTextAlignment.center // 居中对齐
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 13
        textField.clearButtonMode = UITextFieldViewMode.whileEditing
        textField.keyboardType = UIKeyboardType.default
        textField.delegate = self
        textField.addTarget(self, action: #selector(twoMethod(textField:)), for: UIControlEvents.editingChanged)
        return textField
    }()
    
    lazy var saveBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("save", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.backgroundColor = UIColor.brown
        
        //7.文字的位置，图片的位置
        //        btn.imageEdgeInsets = UIEdgeInsets(top: <#T##CGFloat#>, left: <#T##CGFloat#>, bottom: <#T##CGFloat#>, right: <#T##CGFloat#>)
        btn.addTarget(self, action: #selector(clickAction(button:)), for: .touchUpInside)
        return btn
    }()
    
    func clickAction(button: UIButton) {
        SSKeyChain.save("KEY_USERNAME_PASSWORD", data: self.saveInfomation)
    }
    
    func  loadControlsInView() {
        self.view.addSubview(self.userText)
        self.userText.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(10)
            make.width.equalTo(190)
            make.height.equalTo(40)
            make.top.equalTo(64)
        }
        self.view.addSubview(self.passwordText)
        self.passwordText.snp.makeConstraints { (make) in
            make.left.equalTo(self.userText.snp.right).inset(-10)
            make.width.equalTo(190)
            make.height.equalTo(40)
            make.top.equalTo(self.userText)
        }
        self.view.addSubview(self.saveBtn)
        self.saveBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.passwordText.snp.bottom).inset(-20)
            make.width.equalTo(66)
            make.height.equalTo(38)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SSKeyChain"
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        self.loadControlsInView()
    }
    
    func oneMethod(textField: UITextField)  {
        self.saveInfomation.setValue(textField.text ?? "", forKey: KEY_USERNAME)
    }
    func twoMethod(textField: UITextField)  {
        self.saveInfomation.setValue(textField.text, forKey: KEY_PASSWORD)
    }
    
//    读数据
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.readUserNameAndPassword()
    }
    
    func readUserNameAndPassword()  {
//        一般在写程序过程中，应该尽量避免直接访问KeyChain，一般会创建一个NSDictionary来同步对应的数据，所以两者需要做转换。
        let readUserInfoamtion = SSKeyChain.load(KEY_USERNAME_PASSWORD)
//        self.userText.text = readUserInfoamtion?["KEY_USERNAME"] as! String
//        self.passwordText.text = readUserInfoamtion!["KEY_PASSWORD"] as! String
//        
//        print("self.userText.text:\(self.userText.text),---->self.passwordText.text:\(self.passwordText.text)")
        
    }
    
    func deletePassword() {
        SSKeyChain.delete("KEY_USERNAME_PASSWORD")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    MARK: - UITextFieldDelegate
//    输入框按下键盘 return 收回键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
//    该方法当文本框内容出现变化时 及时获取文本最新内容
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
}
