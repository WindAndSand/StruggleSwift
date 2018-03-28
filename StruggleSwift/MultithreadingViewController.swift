//
//  OperationViewController.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/10/15.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit
//http://www.cocoachina.com/swift/20170906/20481.html
//http://www.jianshu.com/p/2728ae223a5a

class MultithreadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
//        第三方库使用loadingView
        /*
         [SVProgressHUD show];
         [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
         [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
         [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:153/255 green:153/255 blue:153/255 alpha:0.5]];
         [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
         [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
         [SVProgressHUD showWithStatus:@"加载中……"];
         [SVProgressHUD setFont:[UIFont systemFontOfSize:13]];
         
         [SVProgressHUD dismiss];

         */
        
        
//        Operation
        self.basicOperation()
        self.CreatBasicBlockOperation()
        self.startBasicDemo()
        
        self.controlsTheLayout()

    }
    
    func controlsTheLayout() {
    
        let gcd = UIButton.init(frame: CGRect(x: 0, y: 170, width: 50, height: 30))
        gcd.setTitle("GCD", for: .normal)
        gcd.backgroundColor = UIColor.red
        gcd.addTarget(self, action: #selector(practiceForGCD), for: UIControlEvents.touchUpInside)
        self.view.addSubview(gcd)
        
    }
    
//    MARK: GCD
    func practiceForGCD() {
        let gcd = GCD()
        
//        同步执行 + 串行队列
//        gcd.syncSerial()
        
//        异步执行 + 串行队列
//        gcd.asyncSerial()
        
//        同步执行 + 主队列
//        gcd.syncMain();// 卡住不能执行
        
//        其他线程中调用同步执行 + 主队列
        
        
        
        print("<-------------------------线程结束-------------------------->")
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    MARK: - Operation
    private func basicOperation()
    {
        //        第一步：创建Operation
        let op = Operation.init()
        //        第二步：把要执行的代码放入operation中
        op.completionBlock = {
            
            print(#function,#line,Thread.current)
        }
        //        第三步：创建OperationQueue
        let opQueue = OperationQueue.init()
        //        第四步：把Operation加入到线程中
        opQueue.addOperation(op)
    }
    
    private func CreatBasicBlockOperation()
    {
        //使用BlockOperation创建operation
        let operation = BlockOperation.init
        {
            //打印，看看在哪个线程中
//            print(#function,#line,Thread.current)
        }
        
        //直接运行operation，看看运行在哪个线程中
        operation.start()
    }

//    Operation 案例
    fileprivate func startBasicDemo()
    {
        let operationQueue = OperationQueue.init()
        operationQueue.maxConcurrentOperationCount = 3
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        
        let a = UIImageView(frame: CGRect(x: 0, y: 64, width: 70, height: 100))
        self.view.addSubview(a)
        let b = UIImageView(frame: CGRect(x: 80, y: 64, width: 70, height: 100))
        self.view.addSubview(b)
        let c = UIImageView(frame: CGRect(x: 160, y: 64, width: 70, height: 100))
        self.view.addSubview(c)
        let d = UIImageView(frame: CGRect(x: 240, y: 64, width: 70, height: 100))
        self.view.addSubview(d)
        
        
        let imageViews = [a, b, c, d]
        for imageView in imageViews {
            if let url = URL(string: "https://placebeard.it/355/140")
            {
                do {
                    let image = UIImage(data:try Data(contentsOf: url))
                    
                    DispatchQueue.main.async    //放到主线程中异步执行
                        {
                            imageView.image = image
                        }
                }catch
                {
                    print(error)
                }
            }
        }
//        global queue
        DispatchQueue.global().async
            {
                [weak self] in
//            等待所有操作都完成了,回到主线程停止刷新器。
//            wait Until All Operations are finished, then stop animation of activity indicator
                operationQueue.waitUntilAllOperationsAreFinished()
                DispatchQueue.main.async
                {
                    activityIndicator.stopAnimating()
                 }
    
            }
    }
    

}
