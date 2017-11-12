//
//  NetRequest.h
//  StruggleSwift
//
//  Created by HuangGang on 2017/11/12.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BLOCK)(id result);

@interface NetRequest : NSObject

@property (nonatomic, copy) BLOCK bl;
- (void)requestNetWithUrl:(NSString *)urlStr BodyOfRequestForString:(NSString *)bodyStr block:(BLOCK)bl;
+ (void)PostWithUrl:(NSString *)urlStr BodyOfRequestForString:(NSString *)bodyStr block:(BLOCK)bl;

@end
