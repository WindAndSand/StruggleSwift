//
//  TestView.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/10/15.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

class TestView: UIView {

//    声明一个属性btnClickBlock，type为闭包可选类型
//    闭包类型：()->() ，无参数，无返回值
    var btnClickBlock:(()->())?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        self.closureCall()
    }
    
    
    func closureCall()  {
        
        //        创建闭包按钮控件
        self.createClosureButtonControl()
        
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
        btn.addTarget(self, action: #selector(TestView.btnClick(sender:)), for: .touchDown);
        
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
    func requestData(urlString:String,succeed: ((Any?)->(Void))?,failure:((Any?)->(Void))?){
        
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
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
