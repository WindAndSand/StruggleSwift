//
//  UIViewController+Method.m
//  StruggleSwift
//
//  Created by HuangGang on 2018/3/26.
//  Copyright © 2018年 HuangGang. All rights reserved.
//

#import "UIViewController+Method.h"
#import "RuntimeController.h"

@implementation UIViewController (Method)

+ (void)load
{
//    viewVillAppear 的运行时测试
    SEL origSel = @selector(viewDidAppear:);
    SEL swizSel = @selector(swiz_viewDidAppear:);
    [UIViewController swizzleMethods:[self class] originalSelector:origSel swizzledSelector:swizSel];

//    运行时交换带有参数的方法，参数数数目相同
    SEL origSel1 = @selector(parameter:other:);
    SEL swizSel1 = @selector(methodParameter:other:);
//    class_getClassMethod,注意这是类方法，不是实例方法
    Method origMethod1 = class_getInstanceMethod([RuntimeController class], origSel1);
    Method swizMethod1 = class_getInstanceMethod([UIViewController class], swizSel1);
    method_exchangeImplementations(origMethod1, swizMethod1);
    
//    运行时交换带有参数的方法，参数数数目不同
//    SEL origSel2 = @selector(parameter:other:);
//    SEL swizSel2 = @selector(methodOriginal);
//    Method origMethod2 = class_getInstanceMethod([RuntimeController class], origSel2);
//    Method swizMethod2 = class_getInstanceMethod([UIViewController class], swizSel2);
//    method_exchangeImplementations(origMethod2, swizMethod2);
    
//    交换类方法
    SEL origSel3 = @selector(classMethodTwo);
    SEL swizSel3 = @selector(classMethodOne);
    //    class_getClassMethod,注意这是类方法，不是实例方法
    Method origMethod3 = class_getClassMethod([RuntimeController class], origSel3);
    Method swizMethod3 = class_getClassMethod([UIViewController class], swizSel3);
    method_exchangeImplementations(origMethod3, swizMethod3);

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

- (int) methodOriginal {
    NSLog(@"---------->UIViewController+Method");
    int  c = [self methodParameter:60 other:50];
    return c;
}

- (void)swiz_viewDidAppear:(BOOL)animated
{
    NSLog(@"我在 UIViewController+swizzling.m 中的 swiz_viewDidAppear 中");
    
    //需要注入的代码写在此处
    
    [self swiz_viewDidAppear:animated];
}


- (int) methodParameter: (int ) a other: (int)b {
    NSLog(@"---------->UIViewController+Method: a + b = %d", a + b);
    int c = [self methodParameter:a other:b];
//    int c = [self methodOriginal];
    return  c;
}

+ (void) classMethodOne {
    NSLog(@"UIViewController+Method  ---->我是父类方法");
}


@end
