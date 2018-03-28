//
//  GCD.h
//  StruggleSwift
//
//  Created by HuangGang on 2018/3/26.
//  Copyright © 2018年 HuangGang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCD : NSObject

//同步执行 + 串行队列
- (void)syncSerial;

//异步执行 + 串行队列
- (void)asyncSerial;

//主线程中调用 同步执行 + 主队列
- (void)syncMain;

@end
