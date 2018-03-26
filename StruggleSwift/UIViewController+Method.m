//
//  UIViewController+Method.m
//  StruggleSwift
//
//  Created by HuangGang on 2018/3/26.
//  Copyright © 2018年 HuangGang. All rights reserved.
//

#import "UIViewController+Method.h"

@implementation UIViewController (Method)

+ (void)load
{
    SEL origSel = @selector(viewDidAppear:);
    SEL swizSel = @selector(swiz_viewDidAppear:);
    [UIViewController swizzleMethods:[self class] originalSelector:origSel swizzledSelector:swizSel];
}


+ (void)swizzleMethods:(Class)class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel
{
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method swizMethod = class_getInstanceMethod(class, swizSel);
    
    //class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        //origMethod and swizMethod already exist
        method_exchangeImplementations(origMethod, swizMethod);
    }
}

- (void)swiz_viewDidAppear:(BOOL)animated
{
    NSLog(@"我在 UIViewController+swizzling.m 中的 swiz_viewDidAppear 中");
    
    //需要注入的代码写在此处
    
    [self swiz_viewDidAppear:animated];
}


@end
