//
//  ChatCell.m
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/28.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

#import "ChatCell.h"   
//http://www.cnblogs.com/daomul/p/4411141.html

@implementation ChatCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    
    return  self;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
