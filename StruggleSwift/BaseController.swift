//
//  BaseController.swift
//  StruggleSwift
//
//  Created by 黄刚 on 2017/8/17.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit
import SnapKit

//UIImageView 博客：http://www.jianshu.com/p/f7fca80a7235
//字符分割：http://www.jianshu.com/p/022f632e89bd

class BaseController: UIViewController {

    var fileButton:  UIButton!
    
    let typeImage = "image/gif,gif-3.gif"
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let a = 30.8
        let b = 20.2
        
        let ab = String.init(format:"%.f,%.f", a,b)
        print("测试的ab值是：\(ab)")
        
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
//        image/gif,gif-3.gif
        let startRange = typeImage.range(of: "/")
        let endRange = typeImage.range(of: ",")
        let destinationStr = Range(uncheckedBounds: (lower: (startRange?.upperBound)!, upper: (endRange?.lowerBound)!))
        let result = typeImage.substring(with: destinationStr)
        
        print("--startRange:\(String(describing: startRange))\n-----endRange:\(String(describing: endRange))\n---result:\(result)")
        
        
//        setBackgroundImage 和 seetImage 的区别：
        /*
        setBackgroundDrawable（drawable） 代表以这个drawable为背景来填充ImageView的宽高   及ImageView多高多宽，drawable也相应放大至多高多宽
        setImageDrawable（drawable） 代表以这个drawable的实际大小放到ImageView中，并不会放大drawable的实际大小
         */
        
        let backImage = UIImage(named: "bubble@2x.png")?.resizableImage(withCapInsets:  UIEdgeInsetsMake(20, 20, 15, 20), resizingMode: UIImageResizingMode.stretch)
        fileButton = UIButton(frame: CGRect.zero)
        fileButton.setBackgroundImage(backImage, for: UIControlState.normal)
        self.fileButton.layer.cornerRadius = 10
        self.view.addSubview(fileButton)
        self.fileButton.backgroundColor = UIColor.red
        self.fileButton.contentMode = .scaleToFill
        self.fileButton.snp.makeConstraints { (make) in
            make.width.equalTo(289)
            make.height.equalTo(74)
            make.center.equalTo(self.view)
        }
        
//        self.enumeration()
        
//        self.classAndStruct()
        
//        self.properties()
        
//        self.method()
        
//        self.affiliatedScript()
        
//        self.arc()
        
        self.initialization()
    }
    
    
//    类和结构体
    func classAndStruct() {
        let CAS = ClassAndStruct()
        CAS.printSomeThing()
    }
    
//    属性
    func properties()  {
        let properties = Properties()
        properties.printSomeThing()
    }
    
//    方法
    func method()  {
        let metod = Methods()
        metod.printSomeThing()
    }
    
//    附属脚本
    func affiliatedScript() {
        let affiliatedScript = AffiliatedScript()
        affiliatedScript.printSomeThing()
        
        self.arc()

    }
    
//    枚举
    func enumeration() {
        let enumeration = Enumeration()
        enumeration.printSomeThing()
        
    }

    
    
//    构造过程
    func initialization() {
        let initialization = Initialization()
        initialization.printSomeThing()
        
    }
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func arc() {
        let arc = ARC()
        arc.printSomeThing()
    }

}
