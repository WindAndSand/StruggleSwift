//
//  TestView.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/10/15.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

//demo: http://blog.csdn.net/minggeqingchun/article/details/54847735, 
import UIKit

class TestViewOne: UIView {

//    声明一个属性btnClickBlock，type为闭包可选类型
//    闭包类型：()->() ，无参数，无返回值
    var btnClickBlock:(()->())?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        self.closureCall()
    }
    
    
    func closureCall()  {
        
        //        创建闭包按钮控件
//        self.createClosureButtonControl()
        
        //        调用函数requestData函数
        self.requestData(urlString: "http://www.baidu.com", succeed: { (data) -> (Void) in
            //            成功的回调
            guard let result = data as? Data else{
                return;
            }
            
            let srt =  NSString(data: result, encoding: String.Encoding.utf8.rawValue);
            
            print(srt!)
            
            
        }) { (error) -> (Void) in
            //            失败的的回调
            print(error ?? "错误");
        }
        
        
        self.datawith(string: "wwww", id: 18) { (result) in
            print(result)
        }
    }
    
    
//    MARK: - 闭包
    func createClosureButtonControl() {
//        创建按钮
        let btn = UIButton(frame: CGRect(x: 15, y: 15, width: 80, height: 32));
        btn.setTitle("按钮", for: .normal);
        btn.backgroundColor = UIColor.blue;
        
//        绑定事件
        btn.addTarget(self, action: #selector(TestViewOne.btnClick(sender:)), for: .touchDown);
        
//        添加
        self.addSubview(btn)
    }
    
    func btnClick(sender: UIButton)  {
        if self.btnClickBlock != nil {
//            点击按钮执行闭包
//            注意：属性btnClickBlock是可选类型，需要先解包
            self.btnClickBlock!();
        }
        
    }
    
    
    /// 定义一个网络请求函数
    ///
    /// - Parameters:
    ///   - urlString: 请求接口    String
    ///   - succeed: 成功的回调  可选闭包
    ///   - failure: 失败的回调  可选闭包
    func requestData(urlString:String, succeed: ((Any?)->(Void))?, failure:((Any?)->(Void))?){
        
        let request = URLRequest(url: URL(string: urlString)!);
        
        //发送网络请求
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue()) { (_, data, error) in
            if error == nil {
                //请求成功，执行成功的回调，并把数据传递出去
                succeed?(data);
            }else{
                //请求失败，执行失败的回调，并把错误传递出去
                failure?(error);
            }
        }
    }
    
//    逃逸闭包
    func datawith(string:String,id:NSInteger,completion: @escaping (_ result : [String]) -> ()) -> () {
        
        let str = string + String(id)
        
        completion([str])
        
    }
    
//    MARK: - 闭包 UI 的demo
    
//    MAKR: - 与 OC 相同的懒加载方法
    lazy var alertWindow: UIWindow = {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
//        显示优先级, 通常会有三个值, 优先级顺序为:UIWindowLevelAlert > UIWindowLevelStatusBar > UIWindowLevelNormal
        alertWindow.windowLevel = UIWindowLevelAlert
        alertWindow.backgroundColor = UIColor.yellow
        alertWindow.becomeKey()
        
        let label = UILabel(frame: CGRect(x: 10.0, y: 10.0, width: (alertWindow.frame.width - 10.0*2.0), height: 180.0))
        alertWindow.addSubview(label)
        label.backgroundColor = UIColor.orange
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.text = "UIWindow继承自UIView, 用来管理和协调各种视图。提供一个区域来显示视图, 将事件event分发给视图。\n每个iOS应用必须包含一个window用于展示APP的交互页面， 且一个APP通常只有一个UIWindow, 包含了APP的可视内容。\n显示优先级, 通常会有三个值, 优先级顺序为:UIWindowLevelAlert > UIWindowLevelStatusBar > UIWindowLevelNormal."
        
        let button = UIButton(frame: CGRect(x: alertWindow.frame.width - 10.0 - 80.0, y: label.frame.minX + label.frame.height + 10.0, width: 80.0, height: 30.0))
        alertWindow.addSubview(button)
        button.backgroundColor = UIColor.green
        button.setTitle("hidden", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.red, for: .highlighted)
        button.addTarget(self, action: #selector(TestViewOne.hiddenClick), for: .touchUpInside)
        return alertWindow
        
    }() //使用一个闭包来实例化该属性
    
    func hiddenClick()  
    {  
        if !(self.alertWindow.isEqual(nil))
        {  
            self.alertWindow.resignKey()
            self.alertWindow.isHidden = true
        }     
    }  
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
