//
//  Person.h
//  RAC
//
//  Created by HuangGang on 2018/3/24.
//  Copyright © 2018年 Harely. All rights reserved.
//

#import "Biology.h"
#import <objc/runtime.h>
@interface Person : Biology
{
    NSString *_father;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@end
