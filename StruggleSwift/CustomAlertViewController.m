//
//  CustomAlertViewController.m
//  StruggleSwift
//
//  Created by HuangGang on 2017/12/9.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

#import "CustomAlertViewController.h"

@interface CustomAlertViewController ()

@property (nonatomic, retain) UIButton *alertBtnOne;

@property (nonatomic, retain) UIButton *alertBtnTwo;
@property (nonatomic, retain) UIWindow *windowTwo;


@end

@implementation CustomAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:self.alertBtnOne];
    [self.view addSubview:self.alertBtnTwo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) showAlertOne {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Title"
                                                        message:@"message"
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
    
    UIProgressView *progressView = [[UIProgressView alloc]
                                    initWithProgressViewStyle:UIProgressViewStyleBar];
    progressView.progress = 0.5f;
    
    
    [alertView setValue:progressView forKey:@"accessoryView"];
    
    [alertView show];
}

- (void) showAlertTwo {
    self.windowTwo = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.windowTwo.windowLevel = UIWindowLevelAlert;
        self.windowTwo.backgroundColor = [UIColor colorWithWhite:0 alpha:0.25];
        
        UIView *view = [[UIView alloc]
                        initWithFrame:CGRectMake(60, 160, 200, 100)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc]
                          initWithFrame:CGRectMake(60, 20, 80, 20)];
        label.text = @"message";
        
        UIProgressView *progressView = [[UIProgressView alloc]
                                        initWithProgressViewStyle:UIProgressViewStyleBar];
        progressView.frame = CGRectMake(20, 60, 160, 10);
        progressView.progress = 0.5f;
        
        UIButton *button = [[UIButton alloc]
                            initWithFrame:CGRectMake(80, 70, 40, 20)];
        button.backgroundColor = [UIColor yellowColor];
        [button setTitle:@"OK" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(dismiss)forControlEvents:UIControlEventTouchDown];
        
        [view addSubview:label];
        [view addSubview:progressView];
        [view addSubview:button];
        [self.windowTwo addSubview:view];
    }
}

- (void)show
{
    [self.windowTwo makeKeyAndVisible];
}

- (void)dismiss
{
    self.windowTwo.hidden = YES;
    [self.windowTwo resignKeyWindow];
}

    
- (UIButton *) alertBtnOne{
    if (!_alertBtnOne) {
        _alertBtnOne = [[UIButton alloc] initWithFrame:CGRectMake(14, 70, 100, 30)];
        [_alertBtnOne setTitle:@"UIAlertViewOne" forState:UIControlStateNormal];
        [_alertBtnOne setBackgroundColor:[UIColor blueColor]];
        [_alertBtnOne addTarget:self action:@selector(showAlertOne) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _alertBtnOne;
}

- (UIButton *)alertBtnTwo {
    if (!_alertBtnTwo) {
        _alertBtnTwo = [[UIButton alloc] initWithFrame:CGRectMake(14, 120, 100, 30)];
        [_alertBtnTwo setTitle:@"UIAlertViewTwo" forState:UIControlStateNormal];
        [_alertBtnTwo setBackgroundColor:[UIColor blueColor]];
        [_alertBtnTwo addTarget:self action:@selector(showAlertOne) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _alertBtnTwo;
}


@end
