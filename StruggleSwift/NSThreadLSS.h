//
//  NSThreadLSS.h
//  StruggleSwift
//
//  Created by HuangGang on 2018/4/2.
//  Copyright © 2018年 HuangGang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSThreadLSS : NSObject

#pragma mark - 创建、启动线程
- (void) createThread;

//创建线程后自动启动线程
- (void) createThradOne;

//线程之间的通信
- (void)downloadImageOnSubThread;

//非线程安全
- (void)initTicketStatusNotSave;

//线程安全
- (void)initTicketStatusSave;

@end
