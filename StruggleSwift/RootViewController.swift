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
    let tableView = UITableView()
    let controllerArrays = NSArray()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        self.view.addSubview(tableView)
        
        let box = UIView()
        box.backgroundColor = UIColor.yellow
        self.view.addSubview(box)
        
        box.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.center.equalTo(self.view)
        }
        
        
//        tableView.mas_makeConstraints { (make) in
//
//            make?.top.equalTo()(self.view)?.setOffset(100)
//            make?.left.equalTo()(self.view)?.setOffset(100)
//            make?.right.equalTo()(self.view)?.setOffset(100)
//            make?.bottom.equalTo()(self.view)?.setOffset(100)
//        }        
        

    }
    
//    MARK:(=>pragma) - TableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return controllerArrays.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "cellIdentifier"
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        if cell == nil
        {
//            cell = UITableViewCell(s)
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)

        }
        
        return cell!
        
    }
    
//    MARK:(=>#pragma)  - TableViewDelegate
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
