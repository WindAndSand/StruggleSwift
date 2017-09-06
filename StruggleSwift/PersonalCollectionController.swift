//
//  PersonalCollectionController.swift
//  yourdoctor
//
//  Created by HuangGang on 2017/8/30.
//  Copyright © 2017年 heartsquare. All rights reserved.
//



import UIKit
struct FavoriteTT{
    var title: String?
    var collectionTime: String?
}
class Favorite: NSObject {
    var image: NSString?
    var tiltleAndTime = FavoriteTT()
    
    class func dataArray(imageAddress: String) -> Array<Favorite>
    {
        var favoriteArray = Array<Favorite>()
        
        for index in 0 ..< 11
        {
            let favorite = Favorite()
            favorite.image = imageAddress + "/" + String(format: "%d", index) + ".jpg" as NSString
            favorite.tiltleAndTime.collectionTime = favorite.timestampIsconvertedToFormatTime()
             if (0<=index && index<=3){
                favorite.tiltleAndTime.title = "universel" + String(format: "%d", index)
            }
            if (3<index && index<=7) {
                favorite.tiltleAndTime.title = "星空钱币" + String(format: "%d", index)
            }
            if (7<index && index<11){
                favorite.tiltleAndTime.title = "动漫" + String(format: "%d", index)

            }
            favoriteArray.append(favorite)
            
        }
        
        return favoriteArray
    }
    
    func timestampIsconvertedToFormatTime() -> String {
        let currentDate = NSDate()
        let timeStamp = currentDate.timeIntervalSince1970
        //        转换为时间
        let timeInterval: TimeInterval = TimeInterval(timeStamp)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        //        格式话输出
        let dformatter = DateFormatter()
        dformatter.dateFormat = "收藏时间: yyyy年MM月dd日星期EEE HH:mm:ss"
        let timeStr: String! = dformatter.string(from: date as Date)
        
        return timeStr
    }
   
    
}

class PersonalCollectionController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
    let searchBar: UISearchBar! = UISearchBar(frame: CGRect.zero)
    let contentTable: UITableView! = UITableView(frame: CGRect.zero)

    var favorites: Array<Favorite>!
    var favoriteTitle = NSMutableArray()
    
//    搜索过滤
    var filterFavorites: NSMutableArray?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的收藏"
        
        self.searchBar.delegate = self
    
        self.contentTable.delegate = self
        self.contentTable.dataSource = self
        
       favorites = Favorite.dataArray(imageAddress: "/Users/huanggang/Desktop/资料/测试图片")
          for i in 0 ..< 11
        {
            favoriteTitle.add(favorites[i].tiltleAndTime.title!)
        
        }
        self.filterContentForSearchText("",scope: 0)
        
       self.setUpUI()

    }
    
    
    func setUpUI() {
        self.view.addSubview(self.searchBar)
        self.searchBar.placeholder = "搜索"
//        self.searchBar.barTintColor = UIColor.init(red: 0xd1/255, green: 0xd1/255, blue: 0xd1/255, alpha: 1)
        self.searchBar.barTintColor = UIColor.red
//        let searchTextField = self.searchBar.subviews.first?.subviews.last
        let searchTextField = self.searchBar.subviews[0].subviews[1]

        searchTextField.backgroundColor = UIColor.blue
//        self.searchBar.backgroundColor = UIColor.red
        self.searchBar.snp.makeConstraints { (make) in
            make.width.equalTo(self.view.frame.width).multipliedBy(0.6)
            make.height.equalTo(50)
            make.top.equalTo(self.view).inset(70)
            make.centerX.equalTo(self.view)
        }
        
        
        self.view.addSubview(self.contentTable)
        self.contentTable.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12)
        self.contentTable.backgroundColor = UIColor.yellow
        self.contentTable.snp.makeConstraints { (make) in
            make.top.equalTo(self.searchBar.snp.bottom)
            make.left.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.right.equalTo(self.view)
        }
    }
    
    func filterContentForSearchText(_ searchText: NSString, scope: Int) {
        if searchText.length == 0 {
//            查询所有
            self.filterFavorites = NSMutableArray(array: self.favorites)
            return
        }
        
        let scopePredicate = NSPredicate(format: "SELF CONtAINS %@", searchText)
       let filter = self.favoriteTitle.filtered(using: scopePredicate)
        
//        var tempArray:NSArray!
        filterFavorites?.removeAllObjects()
        for i in 0..<(self.favorites.count)
        {
            for j in 0..<(filter.count)
            {
                if self.favorites?[i].tiltleAndTime.title == (filter[j] as! String ) {
                    filterFavorites?.add(self.favorites?[i])

                }

            }
        }
        
    }
    
//    MARK: - UITableViewDataSource
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let collectionIdentifier = "collectionIdentifier"

        var cell: CollectionCell? = tableView.dequeueReusableCell(withIdentifier: collectionIdentifier) as? CollectionCell
        
        let favorite: Favorite! = self.filterFavorites?[indexPath.row] as! Favorite
        if cell == nil
        {
           cell = CollectionCell(style: UITableViewCellStyle.default, reuseIdentifier: collectionIdentifier)
        }
        
        cell?.collectionDelte.addTarget(self, action: #selector(deleteCell), for: UIControlEvents.touchUpInside)
        cell?.tag = indexPath.row
        let subviews = cell?.contentView.subviews
        
        for view in subviews!
        {
            if view is UIButton
            {
                view.tag = indexPath.row
                
            }
        }
        
        cell?.collectionTitle.text = favorite?.tiltleAndTime.title
        cell?.collectionTime.text = favorite?.tiltleAndTime.collectionTime
        cell?.collectionImage.image = UIImage(named: (favorite?.image)! as String)
        
        return cell!
        
    }
    
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.filterFavorites?.count)!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 240
    }
    
//    MARK: - UITableViewDelegate
        
//    MARK: - UISearchBarDelegate
//    获得焦点时，成为第一响应者，触发显示搜索范围栏
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.searchBar.showsScopeBar = true
        
        return true
    }
    
//    响应点击键盘上的搜索按钮事件
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.showsScopeBar = false
        self.searchBar.resignFirstResponder()
    }

//    输入文本内容改变时调用
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterContentForSearchText(searchText as NSString , scope: -1)
        self.contentTable.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    func deleteCell(delteBtn: UIButton) {
        
        let visibleCells: Array<CollectionCell>! = self.contentTable.visibleCells as! Array<CollectionCell>

        for var cell in visibleCells
        {
            print("cell.tag:\(cell.tag)\n")

            if cell.tag == delteBtn.tag
            {
                
                for (index, value) in self.favorites.enumerated()
                {
                    if value.isEqual(self.filterFavorites?[cell.tag])
                    {
                        self.favorites.remove(at: index)

                    }
                    
                }
                self.filterFavorites?.removeObject(at: cell.tag)
                self.contentTable.reloadData()
                break;
            }
        }
        
    }

}
