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
    var controllerArrays = <UIViewController>
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        self.view.addSubview(tableView)
        
        
        
        tableView.backgroundColor = UIColor.yellow
        tableView.snp.makeConstraints { (make) in

        make.top.right.bottom.left.equalTo(self.view)
        }
        

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
