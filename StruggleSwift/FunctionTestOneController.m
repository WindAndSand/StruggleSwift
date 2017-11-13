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
    
    [self compareAlertViewAndActionSheet];
}

- (void)addControlsInTheView{
    [self.view addSubview:self.btnOne];
    [self.view addSubview:self.labelOne];
    [self.view addSubview:[self btnTwo]];
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

- (UIButton *)btnTwo{
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    tempBtn.frame = CGRectMake(self.btnX,100 + self.btnHeight, self.btnWidth, self.btnHeight);
    [tempBtn setTitle:@"点我创建一个window" forState:UIControlStateNormal];
    // 通过按钮的点击事件生成不同windowLevel级别的window
    [tempBtn addTarget:self action:@selector(createUIWindow) forControlEvents:UIControlEventTouchUpInside];
    return  tempBtn;
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

# pragma  mark - useAndLearnUIWindow
- (void)compareAlertViewAndActionSheet {
//    根据window显示级别优先的原则，级别高的会显示在上面，级别低的在下面，我们程序正常显示的view位于最底层
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert View" message:@"Hello Wolrd, i'm AlertView!!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    
    [alertView show];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"ActionSheet" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Don't do that!" otherButtonTitles:@"Hello Wolrd", nil];
    
    [actionSheet showInView:self.view];
    
  
}

- (void)createUIWindow {
    // 创建window
    if (self.myWindow1 == nil) {
        
        NSString *iOS9 = [UIDevice currentDevice].systemVersion;
        if (iOS9.doubleValue >= 9.0) {//>=iOS9
            self.myWindow1 =  [UIWindow new]; // 以后 默认了 window的大小
        } else {
            self.myWindow1 =  [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];//这么写在哪个版本系统上，一点毛病都没有
        }
        
        UIButton *windowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [windowBtn setTitle:@"点我 销毁黄色 window" forState:UIControlStateNormal];
        windowBtn.backgroundColor = [UIColor redColor];
        windowBtn.frame = CGRectMake(15, 64, self.view.frame.size.width - 15 * 2, 64);
        [windowBtn addTarget:self action:@selector(clickWindowBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.myWindow1 addSubview:windowBtn];
        
    }
    // 设置window的颜色，这里设置成黄色，方便查看window的层级关系
    self.myWindow1.backgroundColor = [UIColor yellowColor];
    // 设置 window 的 windowLevel
    self.myWindow1.windowLevel = UIWindowLevelStatusBar; //TODO: Normal，StatusBar，Alert 分别 为 0，1000，2000 可以修改这里体验 层级变化 对 展示 window的影响
    self.myWindow1.hidden = NO;
    [self.myWindow1  makeKeyAndVisible]; //成为keyWindow
}

- (void)clickWindowBtn:(id)sender
{
    //window 销毁
    self.myWindow1.hidden = YES; //可有可无 看 UI效果
    self.myWindow1 = nil; // 这个方法是真正移除 UIWindow
}

@end
