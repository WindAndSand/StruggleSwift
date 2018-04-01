//
//  NSOperationAndQueue.h
//  StruggleSwift
//
//  Created by HuangGang on 2018/3/31.
//  Copyright © 2018年 HuangGang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSOperationAndQueue : NSObject

#pragma mark - NSOperation 和 NSOperationQueue 基本使用

//使用子类 NSInvocationOperation
- (void)useInvocationOperation;
//使用子类 NSInvocationOperation 在其他线程中执行
- (void)useInvocationOperationInOtherThread;

//使用子类 NSBlockOperation
- (void)useBlockOperation;
//调用方法 AddExecutionBlock:
- (void)useBlockOperationAddExecutionBlock;

//使用自定义继承自 NSOperation 的子类
- (void)useCustomOperation;

//使用 addOperation: 将操作加入到操作队列中
- (void)addOperationToQueue;

//使用 addOperationWithBlock: 将操作加入到操作队列中
- (void)addOperationWithBlockToQueue;

#pragma mark -  NSOperationQueue 控制串行执行、并发执行
//设置 MaxConcurrentOperationCount（最大并发操作数）
- (void)setMaxConcurrentOperationCount;


#pragma mark -  NSOperation 操作依赖
//操作依赖
//使用方法：addDependency:
- (void)addDependency;


#pragma mark -  NSOperation、NSOperationQueue 线程间的通信
//线程间通信
- (void)communication;

#pragma mark -  NSOperation、NSOperationQueue 线程同步和线程安全
//线程非安全
- (void)initTicketStatusNotSave;
//线程安全
- (void)initTicketStatusSave;

@end
