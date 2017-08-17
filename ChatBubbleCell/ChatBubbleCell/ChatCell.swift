//
//  ChatCell.swift
//  ChatBubbleCell
//
//  Created by HuangGang on 2017/8/17.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

import UIKit
import SnapKit

class ChatCell: UITableViewCell {
    
    let headPortrait = UIButton(frame: CGRect.zero) //头像
    let whole = UIButton(frame: CGRect.zero)    //最下面按钮
    let bubble = UIImageView(frame: CGRect.zero)    //气泡案
    let fileIcon = UIImage(frame: CGRect.zero)    //文件图标
    let fileName = UILabel(frame: CGRect.zero)  //文件名字
    let fileSize  = UILabel(frame: CGRect.zero) //文件大小
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.green
        
        self.createUI()
    }
    
//    offset：偏移， inset：插入
    
    func createUI()
    {
//        添加头像并加约束
        self.addSubview(headPortrait)
//        let iconWhole = UIImage(named:"headPortrait.jpg")?.withRenderingMode(.alwaysOriginal)
//        self.whole.setImage(iconWhole, for: .normal)
        self.headPortrait.backgroundColor = UIColor.orange
        self.headPortrait.layer.cornerRadius = 19
        headPortrait.snp.makeConstraints{(make) in
            make.height.width.equalTo(38)
            make.top.equalTo(self.snp.top).inset(5) //相对于父视图 top 向下偏移5个像素
            make.left.equalTo(self).inset(15)
            
        
        }

        
//        底部 button 加入到视图中
        self.addSubview(whole)
//        let iconWhole = UIImage(named:"bubble@2x.png")?.withRenderingMode(.alwaysOriginal)
//        self.whole.setImage(iconWhole, for: .normal)
//        self.whole.contentMode = UIViewContentMode.scaleToFill
//        let iconWhole = UIImage(named:"bubble@2x.png")
//        self.whole.setBackgroundImage(iconWhole, for: UIControlState.normal)
        self.whole.layer.cornerRadius = 10
        self.whole.backgroundColor = UIColor.yellow
        self.whole.snp.makeConstraints { (make) in
//            make.width.equalTo(189)
//            make.height.equalTo(38)
            make.top.equalTo(headPortrait)
//            make.top.equalTo(self.snp.top).inset(5) //距离顶部 5 个像素
            make.bottom.equalTo(self.snp.bottom).inset(7)
            make.left.equalTo(self.headPortrait.snp.right).inset(-5)    //距离头像 5 个像素
            make.right.greaterThanOrEqualTo(-67) //右边的距离大于等于67
        }
        
        
//        self.whole.addSubview(self.bubble)
        
//        文件图标
        self.whole.addSubview(self.fileIcon)
        
        
//        文件名称
        self.whole.addSubview(self.fileName)
        self.fileName.backgroundColor = UIColor.cyan
        self.fileName.text = "pdf.pdf"
        self.fileName.textColor = UIColor.black
//        设置UILabel的text文字的行数, 如果是0就会自动换行
        self.fileName.numberOfLines = 0
//        设置UILabel的text是否根据UILabel的宽高自适应, true就是自适应, false就不是
        self.fileName.adjustsFontSizeToFitWidth = false
//        字体名称
        self.fileName.font = UIFont(name:"AppleGothic", size:14)
        self.fileName.textAlignment = NSTextAlignment.left
       self.fileName.snp.makeConstraints { (make) in
//            make.width.greaterThanOrEqualTo(30)
//            make.height.greaterThanOrEqualTo(5)
            make.top.equalTo(self.whole).inset(10)
            make.left.equalTo(self.whole).inset(10)
//            make.bottom.equalTo(self.fileSize.snp.top).inset(3)
        }
        
   
//        文件尺寸大小标签
        self.whole.addSubview(self.fileSize)
//        let sizeColor = UIColor(red: , green: , blue: , alpha:1)
        self.fileSize.backgroundColor = UIColor.white
        self.fileSize.text = "22k"
        self.fileSize.textColor = kRGBColorFromHex(rgbValue: 999999)
        //        设置UILabel的text文字的行数, 如果是0就会自动换行
        self.fileSize.numberOfLines = 0
        //        设置UILabel的text是否根据UILabel的宽高自适应, true就是自适应, false就不是
        self.fileSize.adjustsFontSizeToFitWidth = false
        //        字体名称
        self.fileSize.font = UIFont(name:"AppleGothic", size:14)
        self.fileSize.textAlignment = NSTextAlignment.left
        self.fileSize.snp.makeConstraints { (make) in
            make.top.equalTo(self.fileName.snp.bottom).inset(-6)
            make.left.equalTo(self.fileName.snp.left)
            make.bottom.equalTo(self.whole).inset(10)
            
        }
        
        
        
        
        
    }
    
    
//    MARK: 16进制颜色转换
    func kRGBColorFromHex(rgbValue: Int) -> (UIColor) {
        
        return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,
                       alpha: 1.0)
    }
    
  
   

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
