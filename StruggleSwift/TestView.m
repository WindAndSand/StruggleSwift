//
//  TestView.m
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/13.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

#import "TestView.h"

@implementation TestView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSLog(@"-------调用了initWithFrame:%@" ,NSStringFromCGRect(frame));
    }
    return self;
}

//    layoutSubviews方便数据计算, 调用先于drawRect
- (void)layoutSubviews
{
    NSLog(@"-------触发了layoutSubviews方法： %@", self);
    [super layoutSubviews];
    
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectMake(self.center.x/2, self.center.y/2, 100, 100)];
    innerView.backgroundColor = [UIColor cyanColor];
    
    [self addSubview:innerView];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    NSLog(@"-----调用了drawRect 方法了");
}


@end
