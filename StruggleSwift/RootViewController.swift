//
//  RootViewController.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/10.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit
import SnapKit


class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    private let tableView = UITableView()
    
    
    private var controllers = [UIViewController]()
    private var controllerTitles = ["Snapkit 约束", "setLayoutNeeds", "Swift 基础", "重力感应"]
    
    
    
    private var _controllerTitles = [String]()
//    var _name: String?
//    
//    var name: String? {
//        get{
//        return self.name
//        }
//        
//        set{
//        self.name = newValue
//            
//        }
//    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        self.view.addSubview(tableView)
        
        let controllerOne = ViewController()
        let controllerTwo = LayoutViewController()
        let baseController = BaseController()
//        let accelerometerController = AccelerometerController()
        
        
        controllers.append(controllerOne)
        controllers.append(controllerTwo)
        controllers.append(baseController)
//        controllers.append(accelerometerController)
        
        
        
        tableView.backgroundColor = UIColor.yellow
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in

        make.top.right.bottom.left.equalTo(self.view)
        }
        
//        self.name = "黄刚"
//        print("self.name:%@",self.name ?? NSString())
//        

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
   
    
//    MARK: - lodata
//    func loadData(viewControllers controllers:NSArray, titlesArrays titles: NSArray) -> NSArray
//    {
//        var conrollerOne = ViewController()
//        controllers = [conrollerOne]
//        
//        
//    }
    
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
