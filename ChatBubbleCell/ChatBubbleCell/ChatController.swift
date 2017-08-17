//
//  ChatController.swift
//  ChatBubbleCell
//
//  Created by HuangGang on 2017/8/17.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

class ChatController: UITableViewController {
    
    let chatIdentifier: String! = "fileCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.backgroundColor = UIColor.red
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        let headView = UIView()
        self.tableView.tableHeaderView = headView
        headView.frame = CGRect(x: 0, y: 0, width: 20, height: 30)
        
//        1.1 自定义cell时，用这个方法。注册 cell， 在没有可重用的Cell时会自动创建，并且不能在需要时手动创建
        self.tableView.register(ChatCell.self, forCellReuseIdentifier: chatIdentifier)
        
        /*
//        xib加载cell用此方法注册
         self.tableView.register(UINib.init(nibName: "testCell", bundle: nil), forCellReuseIdentifier: chatIdentifier)
         
         */
 

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 3
    }
    
/*
//      1.1注意：当在tableView创建时注册了cell，重用时需使用以下方法，而手动创建cell时不能使用此方法重用的，否则程序会崩掉。
//      tableView创建时注册了cell 使用此方法重用
     open func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell
     
//      2.1 手动创建cell使用以下方法重用
//      没有之后的IndexPath参数
     open func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell?
 */

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//      1.1 创建cell，不需要判断是否为空，当没有可重用cell的时候会自动创建
        let cell = tableView.dequeueReusableCell(withIdentifier: chatIdentifier, for: indexPath) as! ChatCell

//        2.2 手动创建 cell
//        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: chatIdentifier)
//        if cell == nil
//        {
////            2.2 自定义cell使用此方法
//            cell = UITableViewCell(style: .subtitle, reuseIdentifier: chatIdentifier)
//            print("------cell:\(String(describing: cell))")
////            2.2 xib加载cell使用此方法
////            cell = Bundle.main.loadNibNamed("chatCell", owner: nil, options: nil)?.last as? ChatCell
//        }
//        if cell == nil
//        {
////            cell = ChatCell(style:UITableViewCellStyle.default, ruseIdentifier:chatIdentifier)
//            cell = ChatCell.init(style: UITableViewCellStyle.default, reuseIdentifier: chatIdentifier)
//        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
