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
    
//    chatMessageLeft 测试
    private var bubble_view = UIView(frame: CGRect.zero)
    private var chat_bubble_left = UIImageView(frame: CGRect.zero)
    var message_label = UILabel(frame: CGRect.zero)
    var avatar_button = UIButton(frame: CGRect.zero)
    var contentView = UIView(frame: CGRect.zero)
    

    
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
        
        
        self.chatMessageLeftTest()
//        self.enumeration()
        
//        self.classAndStruct()
        
        self.properties()
        
//        self.method()
        
//        self.affiliatedScript()
        
//        self.arc()
        
//        self.initialization()
        
//        self.swiftExtension()
        
//        self.protocols()
        
//        self.generics()
    }
    
    
    func chatMessageLeftTest() {
        
        self.view.addSubview(self.contentView)
        self.contentView.backgroundColor = UIColor.orange
        self.contentView.contentMode = UIViewContentMode.center
        self.contentView.snp.makeConstraints { (make) in
            make.width.equalTo(300)
            make.height.equalTo(80)
            make.top.equalTo(self.view.snp.top).offset(70)
            make.left.equalTo(self.view.snp.left).offset(62)

        }
        
        self.avatar_button.backgroundColor = UIColor.red
        self.contentView.addSubview(self.avatar_button)
        self.avatar_button.snp.makeConstraints { (make) in
            make.width.height.equalTo(38)
            
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-13)
            make.left.equalTo(self.contentView.snp.left).offset(15)
        }
        
        
        self.contentView.addSubview(self.bubble_view)
        self.bubble_view.backgroundColor = UIColor.yellow
        self.bubble_view.snp.makeConstraints { (make) in
            make.top.equalTo(self.avatar_button)
            make.left.equalTo(self.avatar_button.snp.right).inset(-5)
            make.bottom.equalTo(self.contentView).inset(10)
            make.right.lessThanOrEqualTo(self.contentView).inset(67)
        }
        
        
        
        self.bubble_view.addSubview(self.chat_bubble_left)
        self.chat_bubble_left.backgroundColor = UIColor.red
        let text_image = UIImage(named: "6.jpg")?.resizableImage(withCapInsets:  UIEdgeInsetsMake(20, 20, 15, 20), resizingMode: UIImageResizingMode.stretch)
        self.chat_bubble_left.image = text_image
        self.chat_bubble_left.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.bubble_view)
        }
        
        self.bubble_view.addSubview(self.message_label)
        self.message_label.numberOfLines = 0
        self.message_label.font = UIFont.systemFont(ofSize: 14)
        //        self.lineBreakMode = NSLineBreakByWordWrapping
        self.message_label.sizeToFit()
        self.message_label.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.bubble_view)
            make.bottom.equalTo(contentView).offset(20)
            
        }

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
    
    
//    扩展
    func swiftExtension() {
        let extensions = Extension()
        extensions.printSomeThing()
        
    }
    
//    协议
    func protocols() {
        let protocols = Protocols()
        protocols.printSomeThing()
    }
    
//    泛型
    func generics() {
        let generics = Generics()
        generics.printSomeThing()
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
