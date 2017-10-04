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
import AVFoundation

class AnimationController: UIViewController,UIAlertViewDelegate {
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

    
//    Hit Testing
    private lazy var hitTestingView: UIView! = UIView()
    private lazy var hitBlueLayer: CALayer! = CALayer()
    
//    Mask 图层蒙版
    private lazy var maskImageView: UIImageView! = UIImageView(image:UIImage(named: "8.jpg"))
    
//    仿射变换
    private lazy var transformImageView: UIImageView! = UIImageView(image: UIImage(named: "neteaseCloudMusic.png"))
    
//    CATextLayer
    private lazy var textLayerView: UIView! = UIView()
    
//    CAGradientLayer
    private lazy var gradientView: UIView! = UIView()
    
//    CAReplicatorLayer
    private lazy var replicatorView: UIView! = UIView()
    
//    AVPlayerLayer
    private lazy var avPlayerView: UIView! = UIView()
    
//    MARK: - 方法
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
        
//        hitTessting
        self.hitTestingOfView()
        
//        mask
        self.maskOfView()
        
//        仿射变换
        self.transformOfView()
        
//        CATextLayer
        self.textLayerOfView()
        
//        CAGradientLayer
        self.gradientLayerOfView()
        
//        CAReplicatorLayer
        self.replicatorLayerOfView()
        
//        AVPlayerLayer
        self.avPlayerOfView();
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
    
//    MARK: 图层几何学--内容
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
    
//    MARK: ~~~~~~~~~~~~~~~~~~图层几何学~~~~~~~~~~~~~~~~~~
//    MARK: - 锚点
    func anchorContentOfView()  {
        self.view.addSubview(self.anchorContentView)
        self.anchorContentView.image = UIImage.init(named: "clock.png")
        self.anchorContentView.backgroundColor = UIColor.white
        self.anchorContentView.snp.makeConstraints { (make) in
            make.top.equalTo(self.stretcheView2.snp.bottom).offset(5)
            make.left.equalTo(self.stretcheView1.snp.right).offset(85)
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
    
//    MARK: - zPosition提高一个像素就可以让一个视图的图层前置，
//    移动位置，在3D视图中用的较多
    
//    MARK: -- Hit Testing
    func hitTestingOfView()  {
        self.hitTestingView.backgroundColor = UIColor.red
        self.hitBlueLayer.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        self.hitBlueLayer.backgroundColor = UIColor.blue.cgColor
        self.hitTestingView.layer.addSublayer(self.hitBlueLayer)
        self.view.addSubview(self.hitTestingView)
        self.hitTestingView.snp.makeConstraints { (make) in
            make.right.equalTo(self.view)
            make.top.equalTo(self.fourPhotoOfView.snp.bottom).offset(5)
            make.height.equalTo(200)
            make.width.equalTo(150)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var point = touches.first?.location(in: view)        
        point = self.hitTestingView.layer.convert(point!, from: self.view.layer)
        if self.hitTestingView.layer.contains(point!) {
            point = self.hitBlueLayer.convert(point!, from: self.hitTestingView.layer)
            if self.hitBlueLayer.contains(point!)
            {
                let alertView = UIAlertView(title: "点击了blue", message: "再点击范围", delegate: self , cancelButtonTitle: "取消", otherButtonTitles: "确定")
                alertView.show()
            }else{
                let alertView = UIAlertView(title: "点击了RED", message: "再点击范围2", delegate: self , cancelButtonTitle: "取消", otherButtonTitles: "确定")
                alertView.show()
                
            }
        }
    }
    
//    MARK: -自动布局
//    当图层的bounds发生改变，或者图层的-setNeedsLayout方法被调用的时候，这个- (void)layoutSublayersOfLayer:(CALayer *)layer;函数将会被执行。这使得你可以手动地重新摆放或者重新调整子图层的大小，但是不能像UIView的autoresizingMask和constraints属性做到自适应屏幕旋转。
    
    
//    MARK: ~~~~~~~~~~~~~~~~~~视觉效果~~~~~~~~~~~~~~~~~~
//    MARK: - 圆角
//    CALayer有一个叫做conrnerRadius的属性控制着图层角的曲率。它是一个浮点数，默认为0（为0的时候就是直角），但是你可以把它设置成任意值。默认情况下，这个曲率值只影响背景颜色而不影响背景图片或是子图层。不过，如果把masksToBounds设置成YES的话，图层里面的所有东西都会被截取。
    
//     MARK: 图层边框
/*
    CALayer另外两个非常有用属性就是borderWidth和borderColor。二者共同定义了图层边的绘制样式。这条线（也被称作stroke）沿着图层的bounds绘制，同时也包含图层的角。
    borderWidth是以点为单位的定义边框粗细的浮点数，默认为0.borderColor定义了边框的颜色，默认为黑色。
    borderColor是CGColorRef类型，而不是UIColor，所以它不是Cocoa的内置对象。不过呢，你肯定也清楚图层引用了borderColor，虽然属性声明并不能证明这一点。CGColorRef在引用/释放时候的行为表现得与NSObject极其相似。但是Objective-C语法并不支持这一做法，所以CGColorRef属性即便是强引用也只能通过assign关键字来声明。
 */
    
//    MARK: 阴影
   /*
   shadowOpacity是一个必须在0.0（不可见）和1.0（完全不透明）之间的浮点数。如果设置为1.0，将会显示一个有轻微模糊的黑色阴影稍微在图层之上。若要改动阴影的表现，你可以使用CALayer的另外三个属性：shadowColor，shadowOffset和shadowRadius。
   shadowColor属性控制着阴影的颜色，和borderColor和backgroundColor一样，它的类型也是CGColorRef
   shadowOffset属性控制着阴影的方向和距离。它是一个CGSize的值，宽度控制这阴影横向的位移，高度控制着纵向的位移。shadowOffset的默认值是 {0, -3}，意即阴影相对于Y轴有3个点的向上位移
   shadowRadius属性控制着阴影的模糊度，当它的值是0的时候，阴影就和视图一样有一个非常确定的边界线。当值越来越大的时候，
     
     
     如果你想沿着内容裁切，你需要用到两个图层：一个只画阴影的空的外图层，和一个用masksToBounds裁剪内容的内图层
     
     shadowPath属性：如果你事先知道你的阴影形状会是什么样子的，你可以通过指定一个shadowPath来提高性能。shadowPath是一个CGPathRef类型（一个指向CGPath的指针）。CGPath是一个Core Graphics对象，用来指定任意的一个矢量图形。我们可以通过这个属性单独于图层形状之外指定阴影的形状。
     */

    
//    MARK: 图层蒙板(制作各种的图案)
    /*
     CALayer有一个属性叫做mask可以解决以编码的方式动态地生成蒙板，能让子图层或子视图裁剪成同样的形状这个问题。这个属性本身就是个CALayer类型，有和其他图层一样的绘制和布局属性。它类似于一个子图层，相对于父图层（即拥有该属性的图层）布局，但是它却不是一个普通的子图层。不同于那些绘制在父图层中的子图层，mask图层定义了父图层的部分可见区域。
     
     mask图层的Color属性是无关紧要的，真正重要的是图层的轮廓。mask属性就像是一个饼干切割机，mask图层实心的部分会被保留下来，其他的则会被抛弃。
     
     如果mask图层比父图层要小，只有在mask图层里面的内容才是它关心的，除此以外的一切都会被隐藏起来。
     CALayer蒙板图层真正厉害的地方在于蒙板图不局限于静态图。任何有图层构成的都可以作为mask属性，这意味着你的蒙板可以通过代码甚至是动画实时生成。
     */
    func maskOfView() {
        let maskLayer = CALayer()
        maskLayer.frame = CGRect.init(x: 0, y: 0, width: 100.0, height: 100.0)
        let maskImage = UIImage(named: "neteaseCloudMusic.png")
        maskLayer.contentsScale = (maskImage?.scale)!
        maskLayer.contents = maskImage?.cgImage
        self.maskImageView.layer.mask = maskLayer
        self.view.addSubview(self.maskImageView)
        
        self.maskImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.stretcheView1.snp.bottom).offset(10)
            make.width.height.equalTo(100)
            make.left.equalTo(self.view)
        }
    }
    
//    MARK: 拉伸过滤
    /*
     最后我们再来谈谈minificationFilter和magnificationFilter属性。总得来讲，当我们视图显示一个图片的时候，都应该正确地显示这个图片（意即：以正确的比例和正确的1：1像素显示在屏幕上）。原因如下：
     能够显示最好的画质，像素既没有被压缩也没有被拉伸。
     能更好的使用内存，因为这就是所有你要存储的东西。
     最好的性能表现，CPU不需要为此额外的计算。
     
     CALayer为此提供了三种拉伸过滤方法，他们是：
     kCAFilterLinear  默认的过滤器都是kCAFilterLinear，这个过滤器采用双线性滤波算法，它在大多数情况下都表现良好.双线性滤波算法通过对多个像素取样最终生成新的值，得到一个平滑的表现不错的拉伸。但是当放大倍数比较大的时候图片就模糊不清了
     kCAFilterNearest 是一种比较武断的方法。从名字不难看出，这个算法（也叫最近过滤）就是取样最近的单像素点而不管其他的颜色。这样做非常快，也不会使图片模糊。但是，最明显的效果就是，会使得压缩图片更糟，图片放大之后也显得块状或是马赛克严重。
     kCAFilterTrilinear 三线性滤波算法存储了多个大小情况下的图片（也叫多重贴图），并三维取样，同时结合大图和小图的存储进而得到最后的结果。
     
      kCAFilterLinear,kCAFilterTrilinear 线性过滤保留了形状，kCAFilterNearest最近过滤则保留了像素的差异。
     
     */
    
//    MARK: 组透明
    /*
     UIView有一个叫做alpha的属性来确定视图的透明度。CALayer有一个等同的属性叫做opacity，这两个属性都是影响子层级的。也就是说，如果你给一个图层设置了opacity属性，那它的子图层都会受此影响。
     
     设置CALayer的一个叫做shouldRasterize属性来实现组透明的效果，如果它被设置为YES，在应用透明度之前，图层及其子图层都会被整合成一个整体的图片，这样就没有透明度混合的问题了。若不这样，父视图透明，子视图不透明，糟透了！
     为了启用shouldRasterize属性，我们设置了图层的rasterizationScale属性。默认情况下，所有图层拉伸都是1.0， 所以如果你使用了shouldRasterize属性，你就要确保你设置了rasterizationScale属性去匹配屏幕，以防止出现Retina屏幕像素化的问题。
     
     */
    
//    MARK: ~~~~~~~~~~~~~~~~~~变换~~~~~~~~~~~~~~~~~~
//    MARK: 仿射变换
    /*
     UIView的transform属性是一个CGAffineTransform类型，用于在二维空间做旋转，缩放和平移。
     
     当对图层应用变换矩阵，图层矩形内的每一个点都被相应地做变换，从而形成一个新的四边形的形状。CGAffineTransform中的“仿射”的意思是无论变换矩阵用什么值，图层中平行的两条线在变换之后任然保持平行，CGAffineTransform可以做出任意符合上述标注的变换.
     
     UIView可以通过设置transform属性做变换，但实际上它只是封装了内部图层的变换。
     CALayer同样也有一个transform属性，但它的类型是CATransform3D，而不是CGAffineTransform，本章后续将会详细解释。CALayer对应于UIView的transform属性叫做affineTransform
     */
    
    func transformOfView()  {
        var transform = CGAffineTransform.identity
        transform = transform.rotated(by: CGFloat(.pi / 180.0 * 30.0))//翻转
        transform = transform.scaledBy(x: 0.5, y: 0.5)//缩放
//        transform = transform.translatedBy(x: 200, y: -150) //移动
        self.transformImageView.transform = transform
        
        self.view.addSubview(self.transformImageView)
        self.transformImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.maskImageView)
            make.left.equalTo(self.maskImageView.snp.right).offset(10)
            make.width.height.equalTo(100)
        }
    }

//    MARK: 3D变换
    /*
     透视投影:在真实世界中，当物体远离我们的时候，由于视角的原因看起来会变小，理论上说远离我们的视图的边要比靠近视角的边跟短，但实际上并没有发生，而我们当前的视角是等距离的，也就是在3D变换中任然保持平行，和之前提到的仿射变换类似。CATransform3D的透视效果通过一个矩阵中一个很简单的元素来控制：m34。m34用于按比例缩放X和Y的值来计算到底要离视角多远。
         /*
     CATransform3D transform = CATransform3DIdentity;
     //apply perspective
     transform.m34 = - 1.0 / 500.0;
     //rotate by 45 degrees along the Y axis
     transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
     //apply to layer
     self.layerView.layer.transform = transform;
         */
     
     灭点：
     当在透视角度绘图的时候，远离相机视角的物体将会变小变远，当远离到一个极限距离，它们可能就缩成了一个点，于是所有的物体最后都汇聚消失在同一个点。
     Core Animation定义了这个点位于变换图层的anchorPoint（通常位于图层中心，但也有例外，见第三章）。这就是说，当图层发生变换时，这个点永远位于图层变换之前anchorPoint的位置。
     当改变一个图层的position，你也改变了它的灭点，做3D变换的时候要时刻记住这一点，当你视图通过调整m34来让它更加有3D效果，应该首先把它放置于屏幕中央，然后通过平移来把它移动到指定位置（而不是直接改变它的position），这样所有的3D图层都共享一个灭点。
     
     
     sublayerTransform属性：
     如果有多个视图或者图层，每个都做3D变换，那就需要分别设置相同的m34值，并且确保在变换之前都在屏幕中央共享同一个position，如果用一个函数封装这些操作的确会更加方便，但仍然有限制（例如，你不能在Interface Builder中摆放视图），这里有一个更好的方法。
     CALayer有一个属性叫做sublayerTransform。它也是CATransform3D类型，但和对一个图层的变换不同，它影响到所有的子图层。这意味着你可以一次性对包含这些图层的容器做变换，于是所有的子图层都自动继承了这个变换方法。
     相较而言，通过在一个地方设置透视变换会很方便，同时它会带来另一个显著的优势：灭点被设置在容器图层的中点，从而不需要再对子图层分别设置了。这意味着你可以随意使用position和frame来放置子图层，而不需要把它们放置在屏幕中点，然后为了保证统一的灭点用变换来做平移。
     
     背面：
     CALayer有一个叫做doubleSided的属性来控制图层的背面是否要被绘制。这是一个BOOL类型，默认为YES，如果设置为NO，那么当图层正面从相机视角消失的时候，它将不会被绘制。
     
     扁平化图层：
     
     */
    
//    MARK: 固体对象
    /*
     旋转这个6个面的立方体将会显得很笨重，因为我们要单独对每个面做旋转。另一个简单的方案是通过调整容器视图的sublayerTransform去旋转照相机。
     添加如下几行去旋转containerView图层的perspective变换矩阵：
     perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
     perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
     这就对相机（或者相对相机的整个场景，你也可以这么认为）绕Y轴旋转45度，并且绕X轴旋转45度。现在从另一个角度去观察立方体，就能看出它的真实面貌
     
     
     光亮和阴影：
     Core Animation可以用3D显示图层，但是它对光线并没有概念。如果想让立方体看起来更加真实，需要自己做一个阴影效果。你可以通过改变每个面的背景颜色或者直接用带光亮效果的图片来调整。
     如果需要动态地创建光线效果，你可以根据每个视图的方向应用不同的alpha值做出半透明的阴影图层，但为了计算阴影图层的不透明度，你需要得到每个面的正太向量（垂直于表面的向量），然后根据一个想象的光源计算出两个向量叉乘结果。叉乘代表了光源和图层之间的角度，从而决定了它有多大程度上的光亮。
     */
    
    
//    MARK: ~~~~~~~~~~~~~~~~~~专用图层~~~~~~~~~~~~~~~~~~
//    MARK: CAShapeLayer
    /*
     CAShapeLayer是一个通过矢量图形而不是bitmap来绘制的图层子类。你指定诸如颜色和线宽等属性，用CGPath来定义想要绘制的图形，最后CAShapeLayer就自动渲染出来了。
     创建一个CGPath:
     CAShapeLayer可以用来绘制所有能够通过CGPath来表示的形状。这个形状不一定要闭合，图层路径也不一定要不可破，事实上你可以在一个图层上绘制好几个不同的形状。你可以控制一些属性比如lineWith（线宽，用点表示单位），lineCap（线条结尾的样子），和lineJoin（线条之间的结合点的样子）；但是在图层层面你只有一次机会设置这些属性。如果你想用不同颜色或风格来绘制多个形状，就不得不为每个形状准备一个图层了。
         /*
     下面这段代码绘制了一个有三个圆角一个直角的矩形：
     //define path parameters
     CGRect rect = CGRectMake(50, 50, 100, 100);
     CGSize radii = CGSizeMake(20, 20);
     UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
     //create path
     UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
         */
     
     */
//    MARK:- CATextLayer
//    Core Animation提供了一个CALayer的子类CATextLayer，它以图层的形式包含了UILabel几乎所有的绘制特性，并且额外提供了一些新的特性。
//    同样，CATextLayer也要比UILabel渲染得快得多。很少有人知道在iOS 6及之前的版本，UILabel其实是通过WebKit来实现绘制的，这样就造成了当有很多文字的时候就会有极大的性能压力。而CATextLayer使用了Core text，并且渲染得非常快。
    
    func  textLayerOfView() {
        self.view.addSubview(self.textLayerView)
        let textLayer = CATextLayer()
        self.textLayerView.layer.addSublayer(textLayer)
        textLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.textLayerView.layer.addSublayer(textLayer)
        
        textLayer.foregroundColor = UIColor.purple.cgColor
        textLayer.backgroundColor = UIColor.white.cgColor
        textLayer.alignmentMode = kCAAlignmentJustified
        textLayer.isWrapped = true
//        如果你仔细看这个文本，你会发现一个奇怪的地方：这些文本有一些像素化了。这是因为并没有以Retina的方式渲染，第二章提到了这个contentScale属性，用来决定图层内容应该以怎样的分辨率来渲染。contentsScale并不关心屏幕的拉伸因素而总是默认为1.0。如果我们想以Retina的质量来显示文字，我们就得手动地设置CATextLayer的contentsScale属性
        textLayer.contentsScale = UIScreen.main.scale
        
        let font = UIFont.systemFont(ofSize: 7.8)
        let fontName = font.fontName
        let fontRef = CGFont(fontName as CFString)
//        CATextLayer的font属性不是一个UIFont类型，而是一个CFTypeRef类型。这样可以根据你的具体需要来决定字体属性应该是用CGFontRef类型还是CTFontRef类型（Core Text字体）。同时字体大小也是用fontSize属性单独设置的，因为CTFontRef和CGFontRef并不像UIFont一样包含点大小。这个例子会告诉你如何将UIFont转换成CGFontRef
        textLayer.font = fontRef
        textLayer.fontSize = font.pointSize
        textLayer.fontSize = font.pointSize
        let text = "被动\n阿轲在敌人身后发起的攻击，必定暴击(包括技能)，但是基础暴击伤害只有125%（阿轲每1%暴击几率将提升额外的0.5%暴击伤害）。阿轲所有的正面发起的进攻，都不能产生暴击效果（对非英雄单位造成最多1500伤害）"
        
//        CATextLayer的string属性并不是你想象的NSString类型，而是id类型。这样你既可以用NSString也可以用NSAttributedString来指定文本了（注意，NSAttributedString并不是NSString的子类）。属性化字符串是iOS用来渲染字体风格的机制，它以特定的方式来决定指定范围内的字符串的原始信息，比如字体，颜色，字重，斜体等
        textLayer.string = text
        
        
        /*
         富文本：
         iOS 6中，Apple给UILabel和其他UIKit文本视图添加了直接的属性化字符串的支持，应该说这是一个很方便的特性。不过事实上从iOS3.2开始CATextLayer就已经支持属性化字符串了。这样的话，如果你想要支持更低版本的iOS系统，CATextLayer无疑是你向界面中增加富文本的好办法，而且也不用去跟复杂的Core Text打交道，也省了用UIWebView的麻烦。
         让我们编辑一下示例使用到NSAttributedString（见清单6.3）.iOS 6及以上我们可以用新的NSTextAttributeName实例来设置我们的字符串属性，但是练习的目的是为了演示在iOS 5及以下，所以我们用了Core Text，也就是说你需要把Core Text framework添加到你的项目中。否则，编译器是无法识别属性常量的。
         */
        
        let textLayer_1 = CATextLayer()
        textLayer_1.frame = CGRect(x: 100, y: 0, width: 94, height: 100)
        textLayer_1.contentsScale = UIScreen.main.scale
        self.textLayerView.layer.addSublayer(textLayer_1)
//        textLayer_1.alignmentMode = kCAAlignmentJustified
        textLayer_1.isWrapped = true
        var text_1 = "弧光 \n冷却值：4/3.8/3.6/3.4/3.2/3消耗：0 \n阿轲立即使用双刺攻击目标（短时间内攻击2次且可触发攻击特效），造成175/200/225/250/275/300（+65%额外物理加成）点物理伤害（施法期间可以移动）。"
        let attributeText_1 = NSMutableAttributedString(string: text_1)
        let count_1 = text_1.characters.count
//        设置属性
//        let textStyple_1 = NSMutableParagraphStyle()
//        textStyple_1.firstLineHeadIndent = 20  //首行缩进距离
//        textStyple_1.baseWritingDirection = .natural //文本排序方向
//         attributeText_1.addAttributes([NSParagraphStyleAttributeName: textStyle_1], range: NSMakeRange(0, count))
        
        let font_1 = UIFont.systemFont(ofSize: 7.8)
        let fontName_1 = font_1.fontName
        let fontSize_1 = font_1.pointSize
        let fontRef_1 = CTFontCreateWithName(fontName_1 as CFString, fontSize_1,nil )
        let attribs_1 = [kCTForegroundColorAttributeName: UIColor.blue.cgColor, kCTFontAttributeName: fontRef_1] as [CFString : Any]
        attributeText_1.addAttributes(attribs_1 as [String : Any], range: NSMakeRange(0,count_1))
        
        let attribs_1_1 = [kCTForegroundColorAttributeName: UIColor.white.cgColor, kCTFontAttributeName: fontRef_1] as [CFString : Any]
        attributeText_1.addAttributes(attribs_1_1 as [String : Any], range: NSMakeRange(26, 38))
        
        textLayer_1.string = attributeText_1

        self.textLayerView.backgroundColor = UIColor.red
        self.textLayerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.transformImageView)
            make.height.equalTo(self.transformImageView)
            make.right.equalTo(self.view)
            make.left.equalTo(self.transformImageView.snp.right).offset(10)
        }
    }
    
//    MARK: - CATransformLayer
//    CATransformLayer不同于普通的CALayer，因为它不能显示它自己的内容。只有当存在了一个能作用域子图层的变换它才真正存在。CATransformLayer并不平面化它的子图层，所以它能够用于构造一个层级的3D结构，比如我的手臂示例。
    
//    MARK: - CAGradientLayer
//    CAGradientLayer是用来生成两种或更多颜色平滑渐变的。用Core Graphics复制一个CAGradientLayer并将内容绘制到一个普通图层的寄宿图也是有可能的，但是CAGradientLayer的真正好处在于绘制使用了硬件加速。
    func gradientLayerOfView()  {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.gradientView.layer.addSublayer(gradientLayer)
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor, UIColor.cyan.cgColor, UIColor.blue.cgColor, UIColor.purple.cgColor]
//        colors属性可以包含很多颜色，所以创建一个彩虹一样的多重渐变也是很简单的。默认情况下，这些颜色在空间上均匀地被渲染，但是我们可以用locations属性来调整空间。locations属性是一个浮点数值的数组（以NSNumber包装）。这些浮点数定义了colors属性中每个不同颜色的位置，同样的，也是以单位坐标系进行标定。0.0代表着渐变的开始，1.0代表着结束。
        gradientLayer.locations = [0.0,0.4,0.5,0.6,0.7,0.8,1.0]//若没有locations 是基础变化，若有事3重变换
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        self.view.addSubview(self.gradientView)
        self.gradientView.snp.makeConstraints { (make) in
            make.top.equalTo(self.maskImageView.snp.bottom).inset(-10)
            make.size.equalTo(self.maskImageView)
            make.left.equalTo(self.view)
        }
    }
    
//    MARK: CAReplicatorLayer
    /*
    CAReplicatorLayer的目的是为了高效生成许多相似的图层。它会绘制一个或多个图层的子图层，并在每个复制体上应用不同的变换。看上去演示能够更加解释这些，我们来写个例子吧。
    重复图层（Repeating Layers）
    清单6.8中，我们在屏幕的中间创建了一个小白色方块图层，然后用CAReplicatorLayer生成十个图层组成一个圆圈。instanceCount属性指定了图层需要重复多少次。instanceTransform指定了一个CATransform3D3D变换（这种情况下，下一图层的位移和旋转将会移动到圆圈的下一个点）。
     
     当图层在重复的时候，他们的颜色也在变化：这是用instanceBlueOffset和instanceGreenOffset属性实现的。通过逐步减少蓝色和绿色通道，我们逐渐将图层颜色转换成了红色。这个复制效果看起来很酷，但是CAReplicatorLayer真正应用到实际程序上的场景比如：一个游戏中导弹的轨迹云，或者粒子爆炸（尽管iOS 5已经引入了CAEmitterLayer，它更适合创建任意的粒子效果）。
 */
    func replicatorLayerOfView()  {
        self.view.addSubview(self.replicatorView)
        let replicator = CAReplicatorLayer()
        replicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        self.replicatorView.layer.addSublayer(replicator)
        
        replicator.instanceCount = 10
        
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 0, 20, 0)
        transform = CATransform3DRotate(transform, .pi / 5.0, 0, 0, 1)
        transform = CATransform3DTranslate(transform, 0, -20, 0)
        replicator.instanceTransform = transform
        
        replicator.instanceBlueOffset = -0.1 //当图层在重复的时候，他们的颜色也在变化：这是用instanceBlueOffset和instanceGreenOffset属性实现的
        replicator.instanceGreenOffset = -0.1
        
        let layer = CALayer()
        layer.frame = CGRect(x: 30, y: 30, width: 30, height: 30)
        layer.backgroundColor = UIColor.white.cgColor
        replicator.addSublayer(layer)
        
        self.replicatorView.snp.makeConstraints { (make) in
            make.top.equalTo(self.gradientView)
            make.size.equalTo(self.gradientView)
            make.left.equalTo(self.gradientView.snp.right).inset(-10)
        }
        
    }
    
//    MARK: CAScrollLayer
//    CAScrollLayer有一个-scrollToPoint:方法，它自动适应bounds的原点以便图层内容出现在滑动的地方。注意，这就是它做的所有事情。前面提到过，Core Animation并不处理用户输入，所以CAScrollLayer并不负责将触摸事件转换为滑动事件，既不渲染滚动条，也不实现任何iOS指定行为例如滑动反弹（当视图滑动超多了它的边界的将会反弹回正确的地方）。
    
//    MARK: CATiledLayer
//    CATiledLayer为载入大图造成的性能问题提供了一个解决方案：将大图分解成小片然后将他们单独按需载入。让我们用实验来证明一下。
    
//    MARK: CAEmitterLayer
//    CAEmitterLayer是一个高性能的粒子引擎，被用来创建实时例子动画如：烟雾，火，雨等等这些效果。
//    CAEmitterLayer看上去像是许多CAEmitterCell的容器，这些CAEmitierCell定义了一个例子效果。你将会为不同的例子效果定义一个或多个CAEmitterCell作为模版，同时CAEmitterLayer负责基于这些模版实例化一个粒子流。一个CAEmitterCell类似于一个CALayer：它有一个contents属性可以定义为一个CGImage，另外还有一些可设置属性控制着表现和行为。我们不会对这些属性逐一进行详细的描述，你们可以在CAEmitterCell类的头文件中找到。
    
//    MARK: AVPlayerLayer
//    AVPlayerLayer是用来在iOS上播放视频的。他是高级接口例如MPMoivePlayer的底层实现，提供了显示视频的底层控制。AVPlayerLayer的使用相当简单：你可以用+playerLayerWithPlayer:方法创建一个已经绑定了视频播放器的图层，或者你可以先创建一个图层，然后用player属性绑定一个AVPlayer实例。/Users/huanggang/Downloads/IMG_0007.MOV
    func avPlayerOfView() {
        let filePath = "/Users/huanggang/Desktop/IMG_0007.MOV"
//        let filePath = Bundle.main.path(forResource: "IMG_0007", ofType: ".MOV")
//        let player = AVPlayer(url: NSURL(fileURLWithPath:filePath!) as URL)
        
        let videoURL = URL(fileURLWithPath: filePath)
        //        定义一个视频播放器，通过本地文件路径初始化
        let player = AVPlayer(url: videoURL)
        //        设置大小和位置（全屏
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        //        添加到界面上
        self.avPlayerView.layer.addSublayer(playerLayer)
        //        开始播放
        player.play()
        
        self.view.addSubview(self.avPlayerView)
        self.avPlayerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.replicatorView)
            make.left.equalTo(self.replicatorView.snp.right).inset(-10)
            make.height.width.equalTo(100)
        }
    }
    //    MARK: ~~~~~~~~~~~~~~~~~~隐式动画~~~~~~~~~~~~~~~~~~
//    MARK: 事务
//    事务实际上是Core Animation用来包含一系列属性动画集合的机制，任何用指定事务去改变可以做动画的图层属性都不会立刻发生变化，而是当事务一旦提交的时候开始用一个动画过渡到新值。
//    事务是通过CATransaction类来做管理，这个类的设计有些奇怪，不像你从它的命名预期的那样去管理一个简单的事务，而是管理了一叠你不能访问的事务。CATransaction没有属性或者实例方法，并且也不能用+alloc和-init方法创建它。但是可以用+begin和+commit分别来入栈或者出栈。
//    任何可以做动画的图层属性都会被添加到栈顶的事务，你可以通过+setAnimationDuration:方法设置当前事务的动画时间，或者通过+animationDuration方法来获取值（默认0.25秒）
    
//    MARK: 完成块
//    基于UIView的block的动画允许你在动画结束的时候提供一个完成的动作。CATranscation接口提供的+setCompletionBlock:方法也有同样的功能。我们来调整上个例子，在颜色变化结束之后执行一些操作。我们来添加一个完成之后的block，用来在每次颜色变化结束之后切换到另一个旋转90的动画

//    MARK：图层行为
//    每个UIView对它关联的图层都扮演了一个委托，并且提供了-actionForLayer:forKey的实现方法。当不在一个动画块的实现中，UIView对所有图层行为返回nil，但是在动画block范围之内，它就返回了一个非空值。

//    MARK: ~~~~~~~~~~~~~~~~~~显示动画~~~~~~~~~~~~~~~~~~

    
}

