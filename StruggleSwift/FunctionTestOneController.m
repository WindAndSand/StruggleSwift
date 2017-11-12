//
//  FunctionTestOneController.m
//  StruggleSwift
//
//  Created by HuangGang on 2017/11/6.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

//参考资料：http://www.cocoachina.com/ios/20160414/15921.html
#import "FunctionTestOneController.h"
#import "FunctionTestTwoController.h"
#import "LXDDownloadManager.h"
#import "NetRequest.h"

#define QQMUSICURL @"https://www.baidu.com/link?url=UTiLwaXdh_-UZG31tkXPU62Jtsg2mSbZgSPSR3ME3YwOBSe97Hw6U6DNceQ2Ln1vXnb2krx0ezIuziBIuL4fWNi3dZ02t2NdN6946XwN0-a&wd=&eqid=ce6864b50004af120000000656fe235f"

@interface FunctionTestOneController ()

@property(nonatomic, assign) NSUInteger labelX;
@property(nonatomic, assign) NSUInteger labelWidth;
@property(nonatomic, assign) NSUInteger labelHeight;

@property(nonatomic, assign) NSUInteger btnX;
@property(nonatomic, assign) NSUInteger btnWidth;
@property(nonatomic, assign) NSUInteger btnHeight;

@property(nonatomic, retain)UIButton *btnOne;
@property(nonatomic, retain)UILabel *labelOne;

@property(nonatomic, retain) NSMutableArray *array;

@end

@implementation FunctionTestOneController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.labelX = 100;
    self.labelWidth = 394;
    self.labelHeight = 30;
    
    self.btnX = 10;
    self.btnWidth = 88;
    self.btnHeight = 30;
    
    
    [self addControlsInTheView];
    [[LXDDownloadManager alloc] downloadWithURL: QQMUSICURL parameters: nil handler: ^(NSData * receiveData, NSError * error) {
        if (error) { NSLog(@"下载失败：%@", error); }
        else {
            //处理下载数据
        }
    } progress: ^(CGFloat progress) {
        NSLog(@"下载进度%f%%", progress*100);
    }];
    
    [self getDataFromNetRequest];
}

- (void)addControlsInTheView{
    [self.view addSubview:self.btnOne];
    [self.view addSubview:self.labelOne];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - 获取 NetRequest 的数据
- (void)getDataFromNetRequest {
    self.array = [NSMutableArray array];
    self.title = @"新闻";
    NSString *urlStr = @"http://ipad-bjwb.bjd.com.cn/DigitalPublication/publish/Handler/APINewsList.ashx";
    NSString *bodyStr = @"date=20131129&startRecord=1&len=30&udid=1234567890&terminalType=Iphone&cid=213";
    [NetRequest PostWithUrl:urlStr BodyOfRequestForString:bodyStr block:^(id result) {
        self.array = [result objectForKey:@"news"];
        
    }];
}

- (UIButton *)btnOne{
    if (!_btnOne) {
        _btnOne = [[UIButton alloc] initWithFrame:CGRectMake(self.btnX, 74, self.btnWidth, self.btnHeight)];
        [_btnOne setTitle:@"blockOne" forState:UIControlStateNormal];
        [_btnOne setTintColor:[UIColor redColor]];
        [_btnOne addTarget:self action:@selector(pushNextViewController) forControlEvents:UIControlEventTouchUpInside];
        _btnOne.backgroundColor = [UIColor purpleColor];
    }
    return _btnOne;
}

- (UILabel *)labelOne{
    if (!_labelOne) {
        _labelOne = [[UILabel alloc] initWithFrame:CGRectMake(self.labelX, 74, self.labelWidth, self.labelHeight)];
        [_labelOne setTintColor:[UIColor redColor]];
        _labelOne.backgroundColor = [UIColor cyanColor];
    }
    return _labelOne;
}

- (void)pushNextViewController{
    
//    用weakSelf修饰weakSelf.label 避免block块内部_label被循环引用
//    __weak FunctionTestOneController *weakSelf = self;
    __weak typeof (*& self) weakSelf = self;
    FunctionTestTwoController *fttc = [FunctionTestTwoController new];
//    block返回值(跟代理写法挺类似的,就是语法不同,代理的话是此处是self.delegate=self;)
    [fttc returnText:^(NSString *showText) {
        weakSelf.labelOne.text = showText;
    }];
    [self.navigationController pushViewController:fttc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
