//
//  FunctionTestTwoController.h
//  StruggleSwift
//
//  Created by HuangGang on 2017/11/6.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

#import <UIKit/UIKit.h>

//在要传值得那个页面定义含有block参数的方法
typedef void (^ReturnTextBlock)(NSString *showText);

@interface FunctionTestTwoController : UIViewController

@property(nonatomic, copy)ReturnTextBlock returnTextBlock;  //需要用copy属性，因为block一开始是放在栈上的，只有copy后才会放到堆上。

- (void)returnText:(ReturnTextBlock)block;

@end
