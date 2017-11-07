//
//  LXDDownloadManager.h
//  StruggleSwift
//
//  Created by HuangGang on 2017/11/7.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LXDDownloadManager : NSObject<NSURLSessionDownloadDelegate>
//block 命名
typedef  void (^LXDDownloadHandler) (NSData *receiveData, NSError *error);
typedef void (^LXDDownloadProgressHandler)(CGFloat progress);

- (void)downloadWithURL: (NSString *)URL parameters: (NSDictionary *)parameters handler: (LXDDownloadHandler)handler progress: (LXDDownloadProgressHandler)progress;

@end
