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

//其他线程中调用同步执行 + 主队列
- (void)otherThreadExecuteForSyncMain;

//异步执行 + 主队列
- (void)asyncMain;

//GCD 线程间的通信
- (void)communication;

//栅栏方法 dispatch_barrier_async
- (void)barrier;

//延时执行方法：dispatch_after
- (void)after;

//一次性代码（只执行一次）dispatch_once
- (void)once;

//快速迭代方法 dispatch_apply
- (void)apply;

//队列组 dispatch_group_notify
- (void)groupNotify;

//队列组 dispatch_group_wait
- (void)groupWait;

//队列组 dispatch_group_enter、dispatch_group_leave
- (void)groupEnterAndLeave;

//Dispatch Semaphore 线程同步
- (void)semaphoreSync;

//非线程安全：不使用 semaphore
//初始化火车票数量、卖票窗口(非线程安全)、并开始卖票
- (void)initTicketStatusNotSave;

//线程安全：使用 semaphore 加锁
//初始化火车票数量、卖票窗口(线程安全)、并开始卖票
- (void)initTicketStatusSave;

@end
