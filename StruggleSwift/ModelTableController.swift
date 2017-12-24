//
//  ModelTableController.swift
//  StruggleSwift
//
//  Created by 黄刚 on 2017/12/24.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

enum SectionCellType: Int {
    case section_keyChain = 0
    case section_numers
    
}

enum RowCellType: Int {
    case row_keyChain = 0
}

class ModelTableController: UITableViewController {
    let  cellIdentifier = "cellIdentifier"
    var itemArray:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor.groupTableViewBackground
        self.navigationController?.title = "Model"
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        self.loadData()
    }
    
    func loadData() {
        self.itemArray = NSMutableArray.init(array: ["SSKeyChain"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return SectionCellType.section_numers.rawValue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = String(describing: self.itemArray[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
//    MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == SectionCellType.section_keyChain.rawValue {
            if indexPath.row == RowCellType.row_keyChain.rawValue{
                let sskcc = SSKeyChainController()
                self.navigationController?.pushViewController(sskcc, animated: true)
            }
        }
        
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
