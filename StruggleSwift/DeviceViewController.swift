//
//  DeviceViewController.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/10/13.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

class DeviceViewController: UIViewController {
    
    var deviceInfo: [String]!
    private lazy var name = UILabel()//
    private lazy var model = UILabel()//
    private lazy var localizedModel = UILabel()//
    private lazy var systemName = UILabel()//
    private lazy var systemVersion = UILabel()//
    private lazy var orientation = UILabel()//
    private lazy var batteryState = UILabel()//
    @objc private lazy var batteryLevel = UILabel()//
    private lazy var proximityState = UILabel()
    private lazy var userInterfaceIdiom = UILabel()
    private lazy var multitaskingSupported = UILabel()//
    private lazy var identifierForVendor = UILabel()//
    private lazy var proximity = UILabel()
    
    private lazy var userInterfaceStyle = UILabel()
    private lazy var directionOfEquipment = UILabel()
    private lazy var batteryStatus = UILabel()
    private lazy var electricity = UILabel()
    private lazy var isCloseToTheUser = UILabel()
    
    var i = 0, j = 0
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground

        self.createControlUI()
        self.initWithData()
    }
    
    private func createControlUI(){
        self.view.addSubview(name)
        self.name.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(70)
            make.left.equalTo(self.view).offset(30)
            make.right.lessThanOrEqualTo(self.view).offset(-10)
        }
        
        self.view.addSubview(self.model)
        self.model.snp.makeConstraints { (make) in
            make.top.equalTo(self.name.snp.bottom).inset(-10)
            make.left.right.equalTo(self.name)
        }
        
        self.view.addSubview(self.localizedModel)
        self.localizedModel.snp.makeConstraints { (make) in
            make.top.equalTo(self.model.snp.bottom).inset(-10)
            make.left.right.equalTo(self.name)
        }
        
        self.view.addSubview(self.systemName)
        self.systemName.snp.makeConstraints { (make) in
            make.top.equalTo(self.localizedModel.snp.bottom).inset(-10)
            make.left.right.equalTo(self.name)
        }
        
        self.view.addSubview(self.systemVersion)
        self.systemVersion.snp.makeConstraints { (make) in
            make.top.equalTo(self.systemName.snp.bottom).inset(-10)
            make.left.right.equalTo(self.name)
        }
        
        self.view.addSubview(self.identifierForVendor)
        self.identifierForVendor.numberOfLines = 0
        self.identifierForVendor.snp.makeConstraints { (make) in
            make.top.equalTo(self.systemVersion.snp.bottom).inset(-10)
            make.left.right.equalTo(self.name)
        }
        
        self.view.addSubview(self.batteryLevel)
        self.batteryLevel.snp.makeConstraints { (make) in
            make.top.equalTo(self.identifierForVendor.snp.bottom).inset(-10)
            make.left.right.equalTo(self.name)
        }
        
        self.view.addSubview(self.multitaskingSupported)
        self.multitaskingSupported.snp.makeConstraints { (make) in
            make.top.equalTo(self.batteryLevel.snp.bottom).inset(-10)
            make.left.right.equalTo(self.name)
        }
        
        self.view.addSubview(self.userInterfaceIdiom)
        self.userInterfaceIdiom.snp.makeConstraints { (make) in
            make.top.equalTo(self.multitaskingSupported.snp.bottom).inset(-10)
            make.left.right.equalTo(self.name)
        }
        
        self.view.addSubview(self.orientation)
        self.orientation.snp.makeConstraints { (make) in
            make.top.equalTo(self.userInterfaceIdiom.snp.bottom).inset(-10)
            make.left.right.equalTo(self.name)
        }
        
        self.view.addSubview(self.batteryState)
        let batteryStatu = UIDevice.current.batteryState
        self.batteryState.text = "---\(batteryStatu)"
        self.batteryState.snp.makeConstraints { (make) in
            make.top.equalTo(self.orientation.snp.bottom).inset(-10)
            make.left.right.equalTo(self.name)
        }
        
        /*
        self.view.addSubview(self.userInterfaceStyle)
        self.userInterfaceStyle.snp.makeConstraints { (make) in
            make.top.equalTo(self.multitaskingSupported.snp.bottom).inset(-10)
            make.left.right.equalTo(self.name)
        }
        
        self.view.addSubview(self.directionOfEquipment)
        self.directionOfEquipment.snp.makeConstraints { (make) in
            make.top.equalTo(self.userInterfaceStyle.snp.bottom).inset(-10)
            make.left.right.equalTo(self.name)
        }
        
        self.view.addSubview(self.batteryStatus)
        self.batteryStatus.snp.makeConstraints { (make) in
            make.top.equalTo(self.directionOfEquipment.snp.bottom).inset(-10)
            make.left.right.equalTo(self.name)
        }
        
        self.view.addSubview(self.isCloseToTheUser)
        self.isCloseToTheUser.snp.makeConstraints { (make) in
            make.top.equalTo(self.batteryStatus.snp.bottom).inset(-10)
            make.left.right.equalTo(self.name)
        }
 */
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//      监听设备方向变化
        NotificationCenter.default.addObserver(self, selector: #selector(change), name: .UIDeviceOrientationDidChange, object: nil)
       
//     监听电池状态
        NotificationCenter.default.addObserver(self, selector: #selector(battery), name: .UIDeviceBatteryStateDidChange, object: nil)
        
//        监听电量
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevels), name: .UIDeviceBatteryLevelDidChange, object: nil)
//         监听设备是否接近用户
        NotificationCenter.default.addObserver(self, selector: #selector(proximityStates), name: .UIDeviceProximityStateDidChange, object: nil)
    
        
    }
    
    
    
    private func initWithData(){
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true    // 启用电池监控,启用之后有关电池的监测才可以用
        device.isProximityMonitoringEnabled = true  // 启用用户接近
        
        self.name.text = "设备号：" + device.name
        self.model.text = "设备型号：" + device.model
        self.localizedModel.text = "设备定位型号：" + device.localizedModel
        self.systemName.text = "设备系统：" + device.systemName
        self.systemVersion.text = "系统版本：" + device.systemVersion
        self.identifierForVendor.text = " UUID：\(String(describing: device.identifierForVendor))"
        self.batteryLevel.text = "电量：\((UIDevice.current.batteryLevel * 100))%"
        self.multitaskingSupported.text = "是否支持接近用户检测：\(device.isMultitaskingSupported)"
        
        switch device.userInterfaceIdiom {
        case .carPlay:
            userInterfaceIdiom.text = "用户界面风格：车载屏"
        case .pad:
            userInterfaceIdiom.text = "用户界面风格: iPd"
        case .phone:
            userInterfaceIdiom.text = "用户界面：iPhone"
        case .tv:
            userInterfaceIdiom.text = "用户界面风格： 未知"
        default:
            print("咩有这样的风格")
        }
    }
    
    
    func change()  {
        let orienta = UIDevice.current.orientation
        
        switch orienta {
        case .faceDown:
            orientation.text = "设备方向： 脸朝地"
        case .faceUp:
            orientation.text = "设备方向： 脸朝上"
        case .landscapeRight:
            orientation.text = "设备方向： 头朝右"
        case .landscapeLeft:
            orientation.text = "设备方向： 头朝左"
        case .portrait:
            orientation.text = "设备方向：正立"
        case .portraitUpsideDown:
            orientation.text = "设备方向：倒立"
            
        default:
            orientation.text = "设备方向：还在懵逼"
        }
        
    }
    func battery() {
        let batteryStatu = UIDevice.current.batteryState
        
        switch batteryStatu {
        case .charging:
            batteryState.text = "电池状态：正在充电"
        case .full:
            batteryState.text = "电池状态： 满电量"
        case .unplugged:
            batteryState.text = "电池状态：在放电"
        default:
            batteryState.text = "电池状态：我也不知道在干嘛"
        }
        
    }
    
    func batteryLevels()  {
        batteryLevel.text = "通知电量变为：\(UIDevice.current.batteryLevel * 100)%"
    }
    
    func proximityStates()  {
        if UIDevice.current.proximityState {
            i += 1
            proximity.text = "接近了用户\(i)次"
        }else{
            j += 1
            proximityState.text = "离开了\(j)次"
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
