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
//气泡制作：http://blog.csdn.net/kevinpake/article/details/41205715

class BaseController: UIViewController {

    var fileButton:  UIButton!
    
    let typeImage = "image/gif,gif-3.gif"
    
//    chatMessageLeft 测试
    private var bubble_view = UIView(frame: CGRect.zero)
    private var chat_bubble_left = UIImageView(frame: CGRect.zero)
    var message_label = UILabel(frame: CGRect.zero)
    var avatar_button = UIButton(frame: CGRect.zero)
    var contentView = UIView(frame: CGRect.zero)
    
//    chatVoice 测试
    private var voiceBubbleView: UIImageView! = UIImageView(frame: CGRect.zero)
    
//    chatImageBubble测试
    private var imageBubbleView: UIImageView! = UIImageView(frame: CGRect.zero)
    
//    约束更新测试
    private var updateConstraintView: UIView! = UIView(frame: CGRect.zero)
    private var updateAView: UIView! = UIView(frame: CGRect.zero)
    private var updateBView: UIView! = UIView(frame: CGRect.zero)
//  首先添加A,B,C 之间的约束--B,C 是 A 的子控件, B 在 C 上面, A 的高度根据 C 的底部确定
    var CBottomConstrains: Constraint?
    let updateConstraintBtn: UIButton! = UIButton()
    let reConstraintBtn: UIButton! = UIButton()


    
    

    
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
        
        
        
        self.chatMessageLeftTest()
        
        self.voiceTest()
        
        self.chatImageForBubble()
        print("--->self.imageBubbleView:\(self.imageBubbleView.frame)")
        
        self.imageAndBackImageDifferent()
        
        self.updateViewConstraint()
        
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
    
//    MARK: -- chatMessageView 测试
    func chatMessageLeftTest() {
        
        self.view.addSubview(self.contentView)
        self.contentView.backgroundColor = UIColor.orange
        self.contentView.contentMode = UIViewContentMode.center
        self.contentView.snp.makeConstraints { (make) in
            make.width.equalTo(300)
//            make.right.lessThanOrEqualTo(self.view).inset(100)
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
    
    
//    MARK: -- chatVoice 测试: 
//    资源地址：http://www.jianshu.com/p/4c570cd79bd3
    func voiceTest() {
        self.view.addSubview(self.voiceBubbleView)
//        let maskLayer: CAShapeLayer! = CAShapeLayer()
        let maskLayer: CALayer! = CALayer()
        let cgImage1: CGImage! = UIImage.init(named: "bubble.png")?.cgImage
//        设置图层显示的内容为拉伸过的MaskImgae
//        maskLayer.contents = cgImage1
        
        
//        maskLayer.strokeColor = UIColor.clear.cgColor
//        设置图层大小与voiceBubbleView相同
//        maskLayer.frame = self.voiceBubbleView.bounds
//        设置拉伸范围
//        maskLayer.contentsCenter = CGRect.init(x: 0.5, y: 0.5, width: 0.1, height: 0.1)
        self.voiceBubbleView.layer.contentsCenter = CGRect.init(x: 0.5, y: 0.5, width: 0.1, height: 0.1)
//        设置比例
//        maskLayer.contentsScale = UIScreen.main.scale
        self.voiceBubbleView.layer.contents = cgImage1
//        设置裁剪范围
//        self.voiceBubbleView.layer.mask = maskLayer
//        设置裁剪掉超出的区域
        self.voiceBubbleView.layer.masksToBounds = true
        self.voiceBubbleView.backgroundColor = UIColor.yellow
        self.voiceBubbleView.snp.makeConstraints { (make) in
            make.top.equalTo(self.chat_bubble_left.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(80)
            make.left.equalTo(self.view).inset(62)
//            make.width.lessThanOrEqualTo(300)
        }
        
        let subView: UIImageView! = UIImageView()
        let image: CGImage! = UIImage.init(named: "6.jpg")?.cgImage
        subView.layer.contentsCenter = CGRect.init(x: 0.5, y: 0.5, width: 0.1, height: 0.1)
        subView.layer.contents = image
        subView.layer.masksToBounds = true

        self.voiceBubbleView.addSubview(subView)
        subView.snp.makeConstraints{(make) in
        make.top.left.bottom.right.equalTo(self.voiceBubbleView)
            
        }
    }
    
    
//    MARK: -- 发送图片气泡
    private func chatImageForBubble() {
        
        self.view.addSubview(self.imageBubbleView)
        self.imageBubbleView.backgroundColor = UIColor.yellow
        self.imageBubbleView.snp.makeConstraints { (make) in
            make.top.equalTo(self.voiceBubbleView.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(80)
            make.left.equalTo(self.view).inset(62)
        }
        
        print("--->^^^^^self.imageBubbleView:\(self.imageBubbleView.frame)")

        //        设置气泡形状
        let shapeLayer = CALayer()

        let maskLayer: CAShapeLayer! = CAShapeLayer()
        maskLayer.fillColor = UIColor.black.cgColor
        maskLayer.strokeColor = UIColor.red.cgColor
//        maskLayer.frame = self.imageBubbleView.bounds
        maskLayer.frame = CGRect.init(x: 0, y: 0, width: 300, height: 80) //设置其气泡的大小，位置可以忽略即：x，和y
        maskLayer.contents = UIImage.init(named: "bubble.png")?.cgImage
        maskLayer.contentsCenter = CGRect.init(x: 0.5, y: 0.5, width: 0.1, height: 0.1)
        maskLayer.contentsScale = UIScreen.main.scale
        
        shapeLayer.mask = maskLayer
        shapeLayer.frame = CGRect.init(x: 0, y: 0, width: 300, height: 80)

        /*
        shapeLayer.contents = UIImage.init(named: "6.jpg")?.cgImage
//        shapeLayer.frame = self.imageBubbleView.frame
 */
        self.imageBubbleView.image = UIImage.init(named: "6.jpg")
        let image:UIImage! = self.imageBubbleView.image
        print("---v\(imageBubbleView)")
        print("---i\(imageBubbleView.image)")
        shapeLayer.contents = image.cgImage
        self.imageBubbleView.image = nil
        
        self.imageBubbleView.layer.addSublayer(shapeLayer)
        

    }
    
    
//    MARK: image和 backImage区别
    private func imageAndBackImageDifferent(){
    
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
            make.width.equalTo(300)
            make.height.equalTo(74)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view.snp.centerY).offset(20)
        }
        

    }
    
    
//    MARK: -- 约束更新
    private func updateViewConstraint() {
        
        self.view.addSubview(self.updateConstraintView)
        self.updateConstraintView.backgroundColor = UIColor.yellow
        self.updateConstraintView.snp.makeConstraints { (make) in
            make.top.equalTo(self.fileButton.snp.bottom).offset(20)
            make.width.equalTo(300)
            make.height.equalTo(100)
            make.left.equalTo(self.view).inset(62)

        }
        
        self.view.addSubview(self.updateConstraintBtn)
        self.updateConstraintBtn.backgroundColor = UIColor.green
        self.updateConstraintBtn.setTitle("Update约束", for: UIControlState.normal)
        self.updateConstraintBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        self.updateConstraintBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.updateConstraintBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.updateConstraintView)
            make.left.equalTo(self.updateConstraintView.snp.right)
            make.height.width.equalTo(40)
        }
        self.updateConstraintBtn.addTarget(self, action: #selector(updateConstraintsInConstraintView(sender:)), for: UIControlEvents.touchUpInside)

        self.view.addSubview(self.reConstraintBtn)
        self.reConstraintBtn.backgroundColor = UIColor.cyan
        self.reConstraintBtn.setTitle("Remake约束", for: UIControlState.normal)
        self.reConstraintBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        self.reConstraintBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        self.reConstraintBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.updateConstraintBtn).offset(40)
            make.left.equalTo(self.updateConstraintView.snp.right)
            make.height.width.equalTo(40)
        }
        self.reConstraintBtn.addTarget(self, action: #selector(remakeConstraintsInConstraintView(sender:)), for: UIControlEvents.touchUpInside)
        
        
        self.updateConstraintView.addSubview(self.updateAView)
        self.updateAView.backgroundColor = UIColor.red
        self.updateAView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.updateConstraintView).offset(40)
            make.height.equalTo(30)
            make.leading.trailing.equalTo(self.updateConstraintView)
        }
        

        self.updateConstraintView.addSubview(self.updateBView)
        self.updateBView.backgroundColor = UIColor.orange
        self.updateBView.snp.makeConstraints { (make) -> Void in
            //记录 updateBView 的顶部约束
            CBottomConstrains =  make.top.equalTo(self.updateAView.snp.bottom).constraint
//            make.height.equalTo(40)
            make.leading.trailing.equalTo(self.updateConstraintView)
            make.bottom.equalTo(self.updateConstraintView)
        }
        
//        self.updateConstraintView.snp.makeConstraints { (make) -> Void in
//
//            make.bottom.equalTo(self.updateBView)
//        }

    
    }
    
    func updateConstraintsInConstraintView(sender: UIButton){
        self.updateAView.isHidden = !self.updateAView.isHidden
       
       
        if self.updateAView.isHidden == true{
            
         //1.先卸载约束
         CBottomConstrains?.deactivate()
         return
            //2.更新约束
            self.updateConstraintView.snp.makeConstraints { (make) -> Void in
                
                //3.当 updateAView 不显示时, updateBView 的 top就跟 updateConstraintView 的top 对齐
                CBottomConstrains = make.top.equalTo(self.updateBView.snp.top).constraint
            }
            
            
        }
        
        if self.updateAView.isHidden == false{
            
            //1.先卸载约束
            self.CBottomConstrains?.deactivate()
            
            //2.更新约束
            self.updateBView.snp.makeConstraints { (make) -> Void in
                //3.当 updateAView 显示时, updateBView 的 top 就更 updateAView 的 bottom 对齐
                CBottomConstrains = make.top.equalTo(self.updateAView.snp.bottom).constraint
            }
            
        }
 
    }
    
    func remakeConstraintsInConstraintView(sender: UIButton){
        self.updateAView.isHidden = !self.updateAView.isHidden
        
        if self.updateAView.isHidden {
            self.updateBView.snp.remakeConstraints({ (make) in
                make.top.equalTo(self.updateConstraintView).offset(25)
                make.left.right.equalTo(self.updateConstraintView)
                make.bottom.equalTo(self.updateConstraintView).offset(-25)
            })
        }else{
            
            self.updateAView.snp.remakeConstraints({ (make) in
                make.top.equalTo(self.updateConstraintView)
                make.height.width.equalTo(self.updateConstraintView).multipliedBy(0.5)
                make.left.equalTo(self.updateConstraintView)
            })
            
            self.updateBView.snp.remakeConstraints({ (make) in
                make.top.equalTo(self.updateAView.snp.bottom)
                make.left.right.equalTo(self.updateConstraintView)
                make.bottom.equalTo(self.updateConstraintView)
            })
        }
        
        
        
    }
    
    
//    MARK: -- 调用基础知识测试案例
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
