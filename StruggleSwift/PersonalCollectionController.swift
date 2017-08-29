//
//  PersonalCollectionController.swift
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/29.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit

class PersonalCollectionController: UIViewController, UISearchBarDelegate {
    
    let searchbar = UISearchBar(frame: CGRect.zero)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackground

        
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
