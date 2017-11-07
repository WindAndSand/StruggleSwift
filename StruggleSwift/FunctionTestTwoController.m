//
//  FunctionTestTwoController.m
//  StruggleSwift
//
//  Created by HuangGang on 2017/11/6.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

#import "FunctionTestTwoController.h"

@interface FunctionTestTwoController ()

@property(nonatomic, assign) NSUInteger textX;
@property(nonatomic, assign) NSUInteger textWidth;
@property(nonatomic, assign) NSUInteger textHeight;

@property(nonatomic, assign) NSUInteger btnX;
@property(nonatomic, assign) NSUInteger btnWidth;
@property(nonatomic, assign) NSUInteger btnHeight;

@property(nonatomic, retain)UIButton *btnOne;
@property(nonatomic, retain)UITextField *textOne;


@end

@implementation FunctionTestTwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.textX = 100;
    self.textWidth = 394;
    self.textHeight = 30;
    
    self.btnX = 10;
    self.btnWidth = 88;
    self.btnHeight = 30;
    
    [self addControlsInTheView];
}

- (void)addControlsInTheView{
    [self.view addSubview:self.btnOne];
    [self.view addSubview:self.textOne];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)returnText:(ReturnTextBlock)block{
    self.returnTextBlock = block;
}

- (UIButton *)btnOne{
    if (!_btnOne) {
        _btnOne = [[UIButton alloc] initWithFrame:CGRectMake(self.btnX, 74, self.btnWidth, self.btnHeight)];
        [_btnOne setTitle:@"blockOne" forState:UIControlStateNormal];
        [_btnOne setTintColor:[UIColor redColor]];
        [_btnOne addTarget:self action:@selector(popUpViewController) forControlEvents:UIControlEventTouchUpInside];
        _btnOne.backgroundColor = [UIColor redColor];
    }
    return _btnOne;
}

- (UITextField *)textOne{
    if (!_textOne) {
        _textOne = [[UITextField alloc] initWithFrame:CGRectMake(self.textX, 74, self.textWidth, self.textHeight)];
//        [_textOne setTintColor:[UIColor redColor]];
        _textOne.backgroundColor = [UIColor grayColor];
    }
    return _textOne;
}

- (void)popUpViewController{
    [self.navigationController popViewControllerAnimated:true];
//    只要在变量前面增加__block，在block里面就可以修改该变量的值。当然也有其他方法如添加static等。
//    在使用block前需要对block指针做判空处理，不判空直接使用，一旦指针为空直接产生崩溃
    if (self.returnTextBlock != nil) {
        self.returnTextBlock(self.textOne.text);
    }
}

@end
