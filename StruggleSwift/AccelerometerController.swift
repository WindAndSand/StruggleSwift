//
//  AccelerometerController.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/22.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

class AccelerometerController: UIViewController {
    private var webview = UIView(frame: CGRect.zero)
    var label: UILabel! = nil
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        
        UIDevice.current.endGeneratingDeviceOrientationNotifications() //结束改变设备方向
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        UIApplication.shared.isStatusBarHidden = false
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "文件预览"
        
        self.view.addSubview(self.webview)
        self.webview.backgroundColor = UIColor.groupTableViewBackground
        self.webview.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        label = UILabel()
        label.text = "横竖屏自适应DEMO"
        label.sizeToFit()
        label.textAlignment = .center
        label.backgroundColor = UIColor.red
        self.webview.addSubview(label)
        
        label.snp.makeConstraints({ (make) in
            make.top.equalTo(0)
            make.leading.trailing.equalTo(0)
            make.height.equalTo(label.snp.width).multipliedBy(9.0 / 16.0)
        })


        // Do any additional setup after loading the view.
    }
    
    
    
    private func addNotifications(){
        //        检测设备方向
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
    }
    
    //             设备方向改变
    @objc fileprivate func deviceOrientationChange(){
        
        //             获取当前设备方向
        let orientation = UIDevice.current.orientation
        //             如果手机硬件屏幕朝上或者屏幕朝下或者未知
        if  orientation == UIDeviceOrientation.faceUp || orientation == UIDeviceOrientation.faceDown || orientation == UIDeviceOrientation.unknown
        {
            return
        }
        
        let interfaceOrientation: UIInterfaceOrientation = UIInterfaceOrientation(rawValue: orientation.rawValue)!
        switch interfaceOrientation {
        //            Home 键在上面
        case UIInterfaceOrientation.portraitUpsideDown: break
        //            Home 在下面
        case UIInterfaceOrientation.portrait:
            toOrientation(orientation: UIInterfaceOrientation.portrait);
            break
        //            Home 键在左
        case UIInterfaceOrientation.landscapeLeft:
            toOrientation(orientation: UIInterfaceOrientation.landscapeLeft);
            break
        //            屏幕水平，Home 键在右
        case UIInterfaceOrientation.landscapeRight:
            toOrientation(orientation: UIInterfaceOrientation.landscapeRight);
            break
        default:
            break
            
        }
    }
    
    
    //    旋转的方向
    private func toOrientation(orientation: UIInterfaceOrientation){
        //        获取当前旋转的方向
        let currentOrientation = UIApplication.shared.statusBarOrientation
        //        如果当前的反向与要旋转的方向一致，直接 return
        if currentOrientation == orientation {
            return
        }
        
        //        根据要旋转的方向，用 SnapKit 重新布局
        if orientation != UIInterfaceOrientation.portrait{
            
            //            从全屏的一侧直接到全屏的另一侧不修改
            if currentOrientation == UIInterfaceOrientation.portrait {
                webview.snp.makeConstraints({ (make) in
                    make.width.equalTo(UIScreen.main.bounds.size.height)
                    make.height.equalTo(UIScreen.main.bounds.size.width)
                    make.center.equalTo(UIApplication.shared.keyWindow!)
                })
                
                if currentOrientation == UIInterfaceOrientation.portrait {
                    label.snp.makeConstraints({ (make) in
                        make.width.equalTo(UIScreen.main.bounds.size.height)
                        make.height.equalTo(UIScreen.main.bounds.size.width)
                        make.center.equalTo(UIApplication.shared.keyWindow!)
                    })
                }
                
                
                
            }
        }
        
        
        //        队状态栏进行旋转
        UIApplication.shared.setStatusBarOrientation(orientation, animated: false)
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.35)
        webview.transform = CGAffineTransform.identity
        webview.transform = getTransformRotationAngle()
        UIView.commitAnimations()
        
        
    }
    
    
    //    获取旋转角度
    private func getTransformRotationAngle() -> CGAffineTransform{
        
        let interfaceOrientation = UIApplication.shared.statusBarOrientation
        
        if interfaceOrientation == UIInterfaceOrientation.portrait{
            return CGAffineTransform.identity
        }else if interfaceOrientation == UIInterfaceOrientation.landscapeLeft{
            return CGAffineTransform(rotationAngle: (CGFloat)(-M_PI_2))
        }else if interfaceOrientation == UIInterfaceOrientation.landscapeRight{
            return CGAffineTransform(rotationAngle: CGFloat(M_PI_2))
        }
        
        return CGAffineTransform.identity
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
