//
//  SSOperation.m
//  StruggleSwift
//
//  Created by HuangGang on 2018/3/31.
//  Copyright © 2018年 HuangGang. All rights reserved.
//

#import "SSOperation.h"

@implementation SSOperation

- (void)main {
    if (!self.isCancelled) {
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    }
}

@end
