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
//        self.basicOperation()
//        self.CreatBasicBlockOperation()
//        self.startBasicDemo()
        
        self.controlsTheLayout()

    }
    
    func controlsTheLayout() {
    
        let gcd = UIButton.init(frame: CGRect(x: 0, y: 170, width: 50, height: 30))
        gcd.setTitle("GCD", for: .normal)
        gcd.backgroundColor = UIColor.red
        gcd.addTarget(self, action: #selector(practiceForGCD), for: UIControlEvents.touchUpInside)
        self.view.addSubview(gcd)
        
        let operation = UIButton.init(frame: CGRect(x: 70, y: 170, width: 110, height: 30))
        operation.setTitle("NSOperation", for: .normal)
        operation.backgroundColor = UIColor.orange
        operation.addTarget(self, action: #selector(practiceForNSOperation), for: UIControlEvents.touchUpInside)
        self.view.addSubview(operation)
        
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
//        gcd.otherThreadExecuteForSyncMain()
        
//        异步执行 + 主队列
//        gcd.asyncMain()
        
//        GCD 线程间的通信
//        gcd.communication()
        
//        GCD 栅栏方法
//        gcd.barrier()
        
//        延时执行
//        gcd.after()
        
//         一次性代码（只执行一次）
//        gcd.once()
        
//          快速迭代方法 dispatch_apply
//            gcd.apply()
        
//        监听 group 中任务的完成状态
//        gcd.groupNotify()
        
//        dispatch_group_wait
//        gcd.groupWait()
        
//        队列组 dispatch_group_enter、dispatch_group_leave
//        gcd.groupEnterAndLeave()
        
//        semaphore 线程同步
//        gcd.semaphoreSync()
        
//        非线程安全：不使用 semaphore
//        gcd.initTicketStatusNotSave()
        
//        线程安全
        gcd.initTicketStatusSave();
        
        print("<-------------------------GCD线程结束-------------------------->")
    }
    
    
    //    MARK: NSOperation
    func practiceForNSOperation() {
        let operationAndQueue = NSOperationAndQueue()
        
//        使用子类 NSInvocationOperation
//        operationAndQueue.useInvocationOperation()
//        使用子类 NSInvocationOperation 在其他线程中执行
//        operationAndQueue.useInvocationOperationInOtherThread()
        
//        使用子类 NSBlockOperation
//         operationAndQueue.useBlockOperation()
//        调用方法 AddExecutionBlock:
//         operationAndQueue.useBlockOperationAddExecutionBlock()
        
//        使用自定义继承自 NSOperation 的子类
//         operationAndQueue.useCustomOperation()
        
//        使用 addOperation: 将操作加入到操作队列中
//        operationAndQueue.addOperationToQueue()
        
//        使用 addOperationWithBlock: 将操作加入到操作队列中
//        operationAndQueue.addOperationWithBlockToQueue()
        
//        设置 MaxConcurrentOperationCount（最大并发操作数）
//         operationAndQueue.setMaxConcurrentOperationCount()
        
//        NSOperation 操作依赖
//        operationAndQueue.addDependency()
        
//        线程间的通信
//        operationAndQueue.communication()
        
//        非线程安全：不使用 NSLock
//        operationAndQueue.initTicketStatusNotSave()
//        线程安全：使用 NSLock
        operationAndQueue.initTicketStatusSave()
        
        print("<-------------------------NSOperationAndQueue 线程结束-------------------------->")
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
