//
//  ViewController.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/11.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let centerView = UIView()
    
    private let viewOne = UIView()
    private let viewTwo = UIView()
    
    private let view1 = UIView()
    private let view2 = UIView()
    
    private let view3 = UIView()
    private let view4 = UIView()
    
    private let view5 = UIView()
    private let view6 = UIView()
    
    private let view7 = UIView()
    private let view8 = UIView()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        
        
        
//        self.centerOfView()
//        
//        self.firstOfView()
//
        self.secondOfViwe()

        self.threeOfView()

//        self.fourOfView()
//
//        self.fiveOfView()
//        
//        self.chatOfBubble()
 
    }
    
//    swift 3.0 后用这个加载视图
    func loadFrameOfView()
    {
        
        let blueView = UIView(frame:CGRect(origin: CGPoint(x: self.view.center.x, y: self.view.center.y),size: CGSize(width:200,height:200)))
        blueView.backgroundColor=UIColor.blue
        self.view .addSubview(blueView)
        
        print("CocoaChina的按钮干货：http://www.cocoachina.com/swift/20150730/12825.html")
        

    }
    
    
//    页面正中央放置一个100*100的正方形view
    func centerOfView()
    {
       let centerView = UIView()
        centerView.backgroundColor = UIColor.red
        self.view.addSubview(centerView)
        
        centerView.snp.makeConstraints { (make) in
            make.height.width.equalTo(100)
            make.center.equalTo(self.view)
            
        }
    }
    
//    子图2位于子图1的右下角
    func firstOfView()  {
        
        viewOne.backgroundColor = UIColor.green
        self.view.addSubview(viewOne)
        
        
        
        viewTwo.backgroundColor = UIColor.yellow
        viewOne.addSubview(viewTwo)
        
        print("---viewOne:\(viewOne)-----viewTwo:\(viewTwo)")
        
        viewOne.snp.makeConstraints { (make) in
            make.height.width.equalTo(100)
            make.bottom.right.equalTo(self.view)

        }
        
        viewTwo.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.bottom.right.equalTo(viewOne)

        }
        
        
        
    }
    
//    子图2与子图1等高等宽，左边顶部对齐
    func secondOfViwe()
    {
        
        view1.backgroundColor = UIColor.green
        self.view.addSubview(view1)
        
        
        view2.backgroundColor = UIColor.cyan
        self.view.addSubview(view2)
        
        view1.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.top.equalTo(74)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        view2.snp.makeConstraints { (make) in
            make.width.height.equalTo(view1)
            make.left.equalTo(view1)    //等同于 make.left.equalTo(view1.snp.left)
            make.top.equalTo(view1.snp.bottom)
            
        }
        
    }
    
//    位移修正与倍率修正
    func threeOfView()
    {
        self.view.addSubview(view3)
        view3.addSubview(view4)
        view3.backgroundColor = UIColor.blue
        view4.backgroundColor = UIColor.purple
        
        view3.snp.makeConstraints { (make) in
            make.height.width.equalTo(100)
//            make.top.equalTo(view2.snp.bottom).inset(-20)
//            make.left.equalTo(self.view).inset(20)
            make.centerY.equalTo(view)
            make.right.equalTo(self.view).inset(40)
            
//            make.left.equalTo((20))
        }
        
        view4.snp.makeConstraints { (make) in
            make.top.right.bottom.left.equalTo(view3).inset(UIEdgeInsetsMake(20, 20, 40, 40))
        }
        
        /*
        等价于：view4 对象相对于父视图的边距(offset)的距离    没有任何效果,仍然紧贴顶部修改为：make.left.equalTo(view3.snp.left).offset(20)，make.left.equalTo(view3.snp.left).inset(20),也没效果
        view4.snp.makeConstraints { (make) in
            make.top.equalTo(view3).offset(20)
            make.left.equalTo(view3).offset(20)
            make.bottom.equalTo(view3).offset(-40)
            make.right.equalTo(view3).offset(-40)
        }
         
         
         
         make.size  //设置大小
         
         make.center //设置中心点
         
         make.topMargin //设置边距
         
         make.baseline //设置基线位置
         
         make.leading//相当于left
         
         make.trailing//相当于right
         
         make.width
         
         make.height
         
         
         链接：http://www.jianshu.com/p/a36180c0e790
*/
        
 
    }
    
    func fourOfView() ->()
    {
        view5.backgroundColor = UIColor.red
        view6.backgroundColor = UIColor.orange
        
        self.view.addSubview(view5)
        view5.addSubview(view6)
        
        
        view5.snp.makeConstraints { (make) in
            make.top.equalTo(view2.snp.bottom).inset(-20)
            make.left.equalTo(view3.snp.right).inset(-20)
            make.width.height.equalTo(100)
        }
        
        view6.snp.makeConstraints { (make) in
            make.center.equalTo(view5)
//            make.height.width.equalTo(50) //约束多了报错
            make.size.equalTo(view5).offset(40)  //size 尺寸
        }
    }
    
//    倍率修正
    func fiveOfView()
    {
        view7.backgroundColor = UIColor.yellow
        view8.backgroundColor = UIColor.green
        
        self.view.addSubview(view7)
        view7.addSubview(view8)
        
        view7.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            
            make.center.equalTo(self.view).offset(120)
        }
        
        view8.snp.makeConstraints { (make) in
            make.center.equalTo(view7)
            make.size.equalTo(view7).multipliedBy(1.5)
        }
        
    }
    
    
//    制作一个发文件的冒泡控件
    func chatOfBubble()
    {
        let whole = UIButton(frame: CGRect.zero)
        let bubble = UIImageView(frame: CGRect.zero)
        let fileIcon = UIImage()
        let fileFont = UILabel(frame: CGRect.zero)
        let fileSize  = UILabel(frame: CGRect.zero)
        
        whole.backgroundColor = UIColor.black
        self.view.addSubview(whole)
        whole.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(-40)
            make.left.equalTo(self.view.snp.left).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(60)
        }
        
        whole.addSubview(bubble)
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

