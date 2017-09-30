//
//  AnimationController.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/9/6.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

/*
 CALayer的功能：
 阴影，圆角，带颜色的边框
 3D变换
 非矩形范围
 透明遮罩
 多级非线性动画
 */

//资料:https://www.kancloud.cn/manual/ios/97767

import UIKit

class AnimationController: UIViewController {
    private lazy var layerView: UIView? = UIView()  //懒加载初始化失败，可以用可选值加上 ？
    private lazy var blueLayer = {() -> CALayer in
        var blueLayer = CALayer()
        blueLayer.frame = CGRect.init(x: 50.0, y: 50.0, width: 100.0, height: 100.0)
        blueLayer.backgroundColor = UIColor.blue.cgColor
        
        return blueLayer
    }()
    
//    装载四个图片的View
    private lazy var fourPhotoOfView: UIView! = {() -> UIView in
        var fourPhotoOfView = UIView()
        fourPhotoOfView.backgroundColor = UIColor.white
        return fourPhotoOfView
    }()
    private lazy var coneView: UIView? = UIView()
    private lazy var shipView: UIView? = UIView()
    private lazy var iglooView: UIView? = UIView()
    private lazy var anchorView: UIView? = UIView()
    
//    拉伸图片
    private lazy var stretcheView1: UIImageView! = UIImageView()
    private lazy var stretcheView2: UIView! = UIView()
    
//    锚点
    private lazy var anchorContentView: UIImageView! = UIImageView(frame: CGRect.zero)
    private lazy var hourHand: UIImageView! = UIImageView(frame: CGRect.zero)
    private lazy var minuteHand: UIImageView! = UIImageView(frame: CGRect.zero)
    private lazy var secondHand: UIImageView! = UIImageView(frame: CGRect.zero)
    private var timer: Timer!
    
    
//    坐标系
    private lazy var coordinateView: UIView! = UIView()
    private lazy var CDGreenView: UIView! = UIView()
    private lazy var CDRedView: UIView! = UIView()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
       
        self.constraintView()
        self.layerView?.layer.addSublayer(blueLayer)
        
//        拼图雏形:contentsRect demo
        self.jigsawConstraint()
        
//        拉伸图层:contentsCenter
        self.strentchPhotoOfLayer()
        
//        锚点
        self.anchorContentOfView()
    }
    
    func constraintView() {
        self.layerView?.backgroundColor = UIColor.white
        let image:UIImage? = UIImage.init(named: "snowman.png")
        self.layerView?.layer.contents = image?.cgImage

//        contentMode:防止图片变形，contentMode是对图层进行操作
//        self.layerView?.contentMode = UIViewContentMode.scaleAspectFit

//        contentGravity
        self.layerView?.layer.contentsGravity = kCAGravityCenter//kCAGravityResizeAspect  //kCAGravityResizeAspect，它的效果等同于UIViewContentMode.scaleAspectFit

//        contentsScale
        self.layerView?.layer.contentsScale = (image?.scale)!
//        图层的transform和affineTransform属性来达到放大图层这个目的
        
//        clipsToBounds:clipsToBounds的属性可以用来决定是否显示超出边界的内容
        self.layerView?.clipsToBounds = true
        
//        contentsRect:允许我们在图层边框里显示寄宿图的一个子域,标准设备上，一个点就是一个像素，但是在Retina设备上，一个点等于2*2个像素
        self.layerView?.layer.contentsRect = CGRect.init(x: 0, y: 0.5, width: 0.5, height: 0.5) //竖的方向是 y，横的方向是 x
        
        self.view.addSubview(self.layerView!)
        self.layerView?.snp.makeConstraints { (make) in
            make.width.height.equalTo(200)
            make.top.equalTo(self.view).offset(70)
        }
    }
    
//    MARK: - 拼图雏形
    func jigsawConstraint() {
        self.view.addSubview(self.fourPhotoOfView)
        self.fourPhotoOfView.snp.makeConstraints { (make) in
            make.top.equalTo(self.layerView!)
            make.size.equalTo(self.layerView!)
            make.left.equalTo((self.layerView?.snp.right)!).offset(10)
        }
        
        self.coneView?.frame = CGRect.init(x: 10, y: 10, width: 85, height: 85)
        self.coneView?.backgroundColor = UIColor.white
        
        self.shipView?.frame = CGRect.init(x: 105, y: 10, width: 85, height: 85)
        self.shipView?.backgroundColor = UIColor.white
        
        self.iglooView?.frame = CGRect.init(x: 10, y: 105, width: 85, height: 85)
        self.iglooView?.backgroundColor = UIColor.white
        
        self.anchorView?.frame = CGRect.init(x: 105, y: 105, width: 85, height: 85)
        self.anchorView?.backgroundColor = UIColor.white

        self.fourPhotoOfView.addSubview(coneView!)
        self.fourPhotoOfView.addSubview(shipView!)
        self.fourPhotoOfView.addSubview(iglooView!)
        self.fourPhotoOfView.addSubview(anchorView!)
        
        let image: UIImage! = UIImage.init(named: "jigsaw.png")
        self.addSprite(Image: image, withContentRect: CGRect.init(x: 0, y: 0, width: 0.5, height: 0.5), toLayer: (self.iglooView?.layer)!)
        self.addSprite(Image: image, withContentRect: CGRect.init(x: 0.5, y: 0, width: 0.5, height: 0.5), toLayer: (self.coneView?.layer)!)
        self.addSprite(Image: image, withContentRect: CGRect.init(x: 0, y: 0.5, width: 0.5, height: 0.5), toLayer: (self.anchorView?.layer)!)
        self.addSprite(Image: image, withContentRect: CGRect.init(x: 0.5, y: 0.5, width: 0.5, height: 0.5), toLayer: (self.shipView?.layer)!)
    }
    
    func addSprite(Image image: UIImage, withContentRect rect: CGRect, toLayer layer:CALayer ) {
        layer.contents = image.cgImage
        layer.contentsGravity = kCAGravityResizeAspect
        layer.contentsRect = rect
    }
    
    
//    MARK: -- StrentchPhoto
    func strentchPhotoOfLayer()  {
        self.view.addSubview(self.stretcheView1)
        self.stretcheView1.backgroundColor = UIColor.red
        self.stretcheView1.snp.makeConstraints { (make) in
            make.top.equalTo((self.layerView?.snp.bottom)!).offset(10)
            make.left.equalTo((self.layerView?.snp.left)!)
            make.height.equalTo(200)
            make.width.equalTo(50)
        }
        
        self.view.addSubview(self.stretcheView2)
        self.stretcheView2.snp.makeConstraints { (make) in
            make.top.equalTo(self.stretcheView1)
            make.left.equalTo(self.stretcheView1.snp.right).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        let image: UIImage! = UIImage.init(named: "stretche.png")
        self.addStretchableIamge(image: image, withContentCenterOfRect: CGRect.init(x: 0.25, y: 0.25, width: 0.5, height: 0.5), toLayer: self.stretcheView1.layer)
        self.addStretchableIamge(image: image, withContentCenterOfRect: CGRect.init(x: 0, y: 1, width: 0.5, height: 0.5), toLayer: self.stretcheView2.layer)
        
        self.stretcheView1.image = UIImage.init(named: "8.jpg")
        
    }
    
    func addStretchableIamge(image: UIImage, withContentCenterOfRect rect: CGRect, toLayer layer: CALayer) {
        layer.contents = image.cgImage
        layer.contentsCenter = rect
    }
    
    
//    MARK: - 锚点
    func anchorContentOfView()  {
        self.view.addSubview(self.anchorContentView)
        self.anchorContentView.image = UIImage.init(named: "clock.png")
        self.anchorContentView.backgroundColor = UIColor.white
        self.anchorContentView.snp.makeConstraints { (make) in
            make.top.equalTo(self.stretcheView2.snp.bottom).offset(5)
            make.left.equalTo(self.stretcheView1.snp.right).offset(50)
            make.height.width.equalTo(150)
        }
        
//        图片向右下方移动,anchorPoint用单位坐标来描述，也就是图层的相对坐标，图层左上角是{0, 0}，右下角是{1, 1}，因此默认坐标是{0.5, 0.5}
        self.anchorContentView.layer.anchorPoint = CGPoint(x: 0.5+0.5, y: 0.5)
        
        self.anchorContentView.addSubview(self.hourHand)
        self.hourHand.image = UIImage.init(named: "hour.png")
        self.hourHand.backgroundColor = UIColor.clear
        self.hourHand.snp.makeConstraints { (make) in
            make.center.equalTo(self.anchorContentView)
            make.height.equalTo(60)
            make.width.equalTo(30)
        }
        
        self.anchorContentView.addSubview(self.minuteHand)
        self.minuteHand.backgroundColor = UIColor.clear
        self.minuteHand.image = UIImage.init(named: "minute.png")
        self.minuteHand.snp.makeConstraints { (make) in
            make.center.equalTo(self.anchorContentView)
            make.height.equalTo(70)
            make.width.equalTo(30)
        }

        
        self.anchorContentView.addSubview(self.secondHand)
        self.secondHand.image = UIImage.init(named: "second.png")
        self.secondHand.snp.makeConstraints { (make) in
            make.center.equalTo(self.anchorContentView)
            make.width.equalTo(25)
            make.height.equalTo(75)
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
        
        self.secondHand.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        self.minuteHand.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        self.hourHand.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)


//        self.tick()
    }
    
    func tick()  {
        let calendar: Calendar! = Calendar.init(identifier: .gregorian)
        let date: NSDate! = NSDate()
//        let units = NSCalendar.Unit.hour | NSCalendar.Unit.minute | NSCalendar.Unit.second
//        var components:NSDateComponents = calendar.components(units, from: date as Date)
//        let hoursAngle: CGFloat! = (components.hour / 12.0) * M_PI * 2.0
//        let minsAngle: CGFloat! = (components.minute / 60.0) * M_PI * 2.0
//        let secsAngle: CGFloat! = (components.second / 60.0) * M_PI * 2.0
        
//        self.hourHand.transform = CGAffineTransform(rotationAngle: hoursAngle)
//        self.minuteHand.transform = CGAffineTransform(rotationAngle: minsAngle)
//        self.secondHand.transform = CGAffineTransform(rotationAngle: secsAngle)


    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
