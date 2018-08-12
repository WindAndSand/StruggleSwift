//
//  LayoutViewController.m
//  StruggleSwift
//
//  Created by HuangGang on 2017/8/13.
//  Copyright © 2017年 HuangGang. All rights reserved.
//


#import "LayoutViewController.h"
#import "TestView.h"

@interface LayoutViewController ()<UIAlertViewDelegate>

@property(nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) TestView  *largeView;
@property (nonatomic, strong) TestView  *smallView;


@end


//资料：http://blog.csdn.net/sinat_25544827/article/details/44521753， http://blog.csdn.net/fg313071405/article/details/51312921



@implementation LayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
//  1、init初始化不会触发layoutSubviews [正确的]
//  2、addSubview会触发layoutSubviews [不完全正确,当frame为0时是不会触发的]
//  3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化 [正确]
    
//    不会触发 layoutSubviews,因 frame 的值为 0
//    [self test_1];
    
//    会触发 layoutSubviews,因 frame 的值不为 0
//    [self test_2];
    
//    不会触发，只有添加到父类时，才会执行
//    [self test_3];
    
//    4、滚动一个UIScrollView会触发layoutSubviews[错误,不用滚动就会触发]
//    [self test_4];
    
    
// 5、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
    [self test_5];
    
    
}

#pragma mark -- 提示视图代理
- (void) remindDelegateAlert {
    NSString *remindMessage = [NSString stringWithFormat:@"确定添加%@为好友？",@"mi_hg"];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:remindMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.delegate = self;
    
    [alertView show];
}

#pragma mark -- 左上角对齐TextField
- (void)createTextView {
    UITextView *contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 300, 300, 60)];
    contentTextView.layer.cornerRadius = 6;
    contentTextView.layer.borderWidth = 0.6;
    contentTextView.layer.borderColor = [UIColor grayColor].CGColor;
    contentTextView.layer.masksToBounds = YES;
    contentTextView.font = [UIFont systemFontOfSize:13];
    //调用私有方法
    [self setPlaceholder:@"这是placeholder文字..." placeholdColor:[UIColor lightGrayColor] textView: contentTextView];
    [self.view addSubview:contentTextView];
}

-(void)setPlaceholder:(NSString *)placeholdStr placeholdColor:(UIColor *)placeholdColor  textView:(UITextView *)textView
{
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = placeholdStr;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = placeholdColor;
    placeHolderLabel.font = textView.font;
    [placeHolderLabel sizeToFit];
    [textView addSubview:placeHolderLabel];
    
    /*
     [self setValue:(nullable id) forKey:(nonnull NSString *)]
     ps: KVC键值编码，对UITextView的私有属性进行修改
     */
    [textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"------->");
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([btnTitle isEqualToString:@"取消"]) {
        return ;
    }else if([btnTitle isEqualToString:@"确定"]){
        NSLog(@"发送成功！");
    }
}

- (void)test_1
{
    /*
     解释:走了initWithFrame:方法,但是又有frame值为{{0, 0}, {0, 0}},并不需要绘制任何的东西。添加了test1,要绘制它,验证了addSubview会触发layoutSubviews是对的,只有当被添加的view有着尺寸的时候才会触发layoutSubviews
     */
//  1.不会调用 layoutSubviews  CGRectMake(70, 70, 100, 100)
//    TestView *test1 = [[TestView alloc] initWithFrame:CGRectMake(70, 70, 100, 100)];
//    [self.view addSubview:test1];
    
   
    
    
//    2.调用 layoutSubviews
//    TestView *test1 = [TestView new];
//    [test1 setNeedsLayout];     //setNeedsLayout会默认调用layoutSubViews，就可以处理子视图中的一些数据。若没有这个方法，不会调用 layoutSubViews 方法，因为 rect 为0.在 test1 标上一个需要被重新布局的标记，在系统runloop的下一个周期自动调用layoutSubviews
//
//
//    [self.view addSubview:test1];
    
     
    
    
    
    
    
//    3. 立即调用 layoutSubviews，有了setNeedsLayout 做标记后，再调用 layoutIfNeeded
//     TestView *test1 = [TestView new];
//     [test1 setNeedsLayout];
//     [test1 layoutIfNeeded];
//     [self.view addSubview:test1];
    
    
    
//    4.直接调用setNeedsDisplay，或者setNeedsDisplayInRect:触发drawRect:，但是有个前提条件是rect不能为0。 CGRectMake(50, 74, 200, 200)
//    TestView *test1 = [[TestView alloc] initWithFrame: CGRectZero]; //只要 rect 不为 0，也可也调用 drawRect
//    [test1 setNeedsDisplay];    //setNeedsDisplay会调用自动调用drawRect方法，这样可以拿到UIGraphicsGetCurrentContext，就可以画画了。
//    [self.view addSubview:test1];

}

- (void)test_2
{
    
//    在UIView初始化时没有设置rect大小，将直接导致drawRect不被自动调用。drawRect 掉用是在Controller->loadView, Controller->viewDidLoad 两方法之后掉用的.所以不用担心在 控制器中,这些View的drawRect就开始画了.这样可以在控制器中设置一些值给View(如果这些View draw的时候需要用到某些变量 值).所以在 test_1 方法中没有调用 drawRect 方法，因为没有设置 rect 大小
    
//    执行
    TestView *test2 = [[TestView alloc] initWithFrame:CGRectMake(0, 64, 100, 100)];
    
    test2.backgroundColor = [UIColor redColor];
    [self.view addSubview:test2];
    
}

- (void)test_3
{
//     layoutSubviews这个方法自身无法调用,是被父类添加的时候才执行的方法
    
    TestView *test = [[TestView alloc] initWithFrame:CGRectMake(157, 74, 100, 100)];
    test.backgroundColor = [UIColor orangeColor];
    UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    showView.backgroundColor = [UIColor yellowColor];
    [test addSubview:showView];
    
}

- (void)test_4
{
    CGRect rect    = self.view.bounds;
    CGFloat height = rect.size.height;
    CGFloat width  = rect.size.width;
    
    UIScrollView *rootScroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    NSArray *data            = @[@"", @"", @"", @""];
    [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TestView *tmp        = [[TestView alloc] initWithFrame:CGRectMake(width*idx, 0, width, height)];
        [rootScroll addSubview:tmp];
    }];
    rootScroll.contentSize   = CGSizeMake(width * data.count, height);
    rootScroll.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:rootScroll];
}

- (void)test_5
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                              target:self
                                            selector:@selector(timerEvent:)
                                            userInfo:nil
                                             repeats:YES];
    _largeView = [[TestView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_largeView];
    
    _smallView = [[TestView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [_largeView addSubview:_smallView];
}

- (void)timerEvent:(id)sender
{
    _smallView.frame = CGRectMake(arc4random()%100 + 20,
                                  arc4random()%100 + 20,
                                  arc4random()%100 + 20,
                                  arc4random()%100 + 20);
    NSLog(@"_smallView %@", _smallView);
    NSLog(@"_smallView %@", _largeView);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
