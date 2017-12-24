//
//  SSKeyChain.h
//  StruggleSwift
//
//  Created by 黄刚 on 2017/12/24.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSKeyChain : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;

@end
