//
//  CollectionCell.swift
//  yourdoctor
//
//  Created by HuangGang on 2017/8/30.
//  Copyright © 2017年 heartsquare. All rights reserved.
//

import UIKit

class CollectionCell: UITableViewCell {
    
    var collectionImage = UIImageView(frame: CGRect.zero)
    let collectionTitle = UILabel(frame: CGRect.zero)
    let collectionTime = UILabel(frame: CGRect.zero)
    let collectionDelte = UIButton(frame: CGRect.zero)
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.groupTableViewBackground
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        self.setUpUI()
        
    }
    
    private func setUpUI() {
        self.contentView.addSubview(collectionImage)
        self.collectionImage.layer.cornerRadius = 3
        self.collectionImage.layer.masksToBounds = true
        self.collectionImage.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).inset(12)
            make.left.equalTo(self.contentView).inset(12)
            make.right.equalTo(self.contentView).inset(12)
            make.height.equalTo(self.contentView.snp.width).multipliedBy(0.4)
            
        }
        
        self.contentView.addSubview(collectionTitle)
        self.collectionTitle.font = UIFont.boldSystemFont(ofSize: 12)
        self.collectionTitle.font = UIFont.systemFont(ofSize: 17)
        self.collectionTitle.snp.makeConstraints { (make) in
            make.top.equalTo(self.collectionImage.snp.bottom).inset(-10)
            make.left.equalTo(self.collectionImage)
            make.width.lessThanOrEqualTo(self.contentView)
            
        }
        
        
        self.contentView.addSubview(collectionTime)
        self.collectionTime.font = UIFont.systemFont(ofSize: 12)
        self.collectionTime.textColor = UIColor.gray
        self.collectionTime.snp.makeConstraints { (make) in
            make.top.equalTo(self.collectionTitle.snp.bottom).inset(-3)
            make.left.equalTo(self.collectionTitle)
            make.right.lessThanOrEqualTo(self.contentView)
        }
        
        
        self.contentView.addSubview(collectionDelte)
        self.collectionDelte.setImage(UIImage(named: "delete1.png"), for: UIControlState.normal)
        self.collectionDelte.contentMode = UIViewContentMode.center
        self.collectionDelte.imageEdgeInsets = UIEdgeInsetsMake(-5, -5, -5, -5)
        self.collectionDelte.snp.makeConstraints { (make) in
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.bottom.equalTo(self.collectionTime)
            make.right.equalTo(self.collectionImage)
        }
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
