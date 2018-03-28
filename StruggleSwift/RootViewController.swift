//
//  RootViewController.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/10.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit
import SnapKit

//http://www.cnblogs.com/keqipu/p/6580215.html, http://www.jianshu.com/p/59af697fa6fd
//岁寒博客：https://lvwenhan.com

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    private let tableView = UITableView()
    
    private var controllers = [UIViewController]()
    private var controllerTitles = ["Snapkit 约束","Model", "setLayoutNeeds", "Swift 基础","OC 版chatCell", "视频播放","个人收藏","核心动画", "设备信息", "通信方式", "OC 测试", "多线程", "自定义AlertView", "Runtime"]
    
    private var _controllerTitles = [String]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        self.view.addSubview(tableView)
        
        let viewController = ViewController()
        let layoutViewController = LayoutViewController()
        let modelTableController = ModelTableController()
        let baseController = BaseController()
        let videoController = VideoController()
        let personalCollection = PersonalCollectionController()
        let animationController = AnimationController()
        let ocChat = ChatController()
//        let accelerometerController = AccelerometerController()
        let deviceController = DeviceViewController()
        let testController = TestViewControllerOne()
        let multithreadController = MultithreadingViewController()
        let functionTestOneController = FunctionTestOneController();
        let customAlerView = CustomAlertViewController()
        let runtime = RuntimeController()
        
        
        
        controllers.append(viewController)
        controllers.append(modelTableController)
        controllers.append(layoutViewController)
        controllers.append(baseController)
        controllers.append(ocChat)
        controllers.append(videoController)
        controllers.append(personalCollection)
        controllers.append(animationController)
//        controllers.append(accelerometerController)
        controllers.append(deviceController)
        controllers.append(testController)
        controllers.append(functionTestOneController)
        controllers.append(multithreadController)
        controllers.append(customAlerView)
        controllers.append(runtime)
        
        
        
        tableView.backgroundColor = UIColor.yellow
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in

        make.top.right.bottom.left.equalTo(self.view)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let jsonPare = JSONParse()
        jsonPare.pareJSONOne()
        jsonPare.pareJSONTwo()
        jsonPare.pareJSONFour()
        jsonPare.pareJSONFive()
        jsonPare.pareJSONSeven()
        jsonPare.nativeJSONParsing()
    }
    
//    MARK: - TableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return controllerTitles.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellIdentifier"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)

        if cell == nil
        {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)

        }
        
        cell?.textLabel?.text = controllerTitles[indexPath.row]
        
        return cell!
        
    }
    
//    MARK:  - TableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(controllers[indexPath.row], animated: true)
    }
   

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
}
