//
//  RuntimeController.m
//  StruggleSwift
//
//  Created by HuangGang on 2018/3/25.
//  Copyright © 2018年 HuangGang. All rights reserved.
//

#import "RuntimeController.h"
@interface RuntimeController ()

@end

@implementation RuntimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self createControls];
    
//    运行时交换方法
    int a = [self parameter:10 other:20];
    NSLog(@"a 的值是：%d", a);
    
//    运行时交换类方法
    [RuntimeController classMethodTwo];
    
}


- (void)viewDidAppear:(BOOL)animated {
     [super viewDidAppear:animated];
     NSLog(@"我在 RuntimeController 中的 viewDidAppear 中");
}

- (int) parameter:(int) a other:(int) b {
    NSLog(@"------->RuntimeController 的 a + b = %d", a+b+70);
    return  a + b + 70;
}


- (void) createControls {
    
    
    UIButton *buttonOne = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, 150, 30)];
    buttonOne.backgroundColor = [UIColor redColor];
    [buttonOne setTitle:@"运行时 归档" forState: UIControlStateNormal];
    [buttonOne addTarget:self action:@selector(archiveFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonOne];
    
    UIButton *buttonTwo = [[UIButton alloc] initWithFrame:CGRectMake(170, 70, 150, 30)];
    buttonTwo.backgroundColor = [UIColor redColor];
    [buttonTwo setTitle:@"运行时 解档" forState: UIControlStateNormal];
    [buttonTwo addTarget:self action:@selector(solutionFileFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonTwo];
    
}

//归档
- (void) archiveFunction {
   
    Person *person = [[Person alloc] init];
    person.name = @"wengzilin";
    person.age = 26;
    [person setValue:@"laoweng" forKey:@"_father"];
    //set value of superClass
    person.introInBiology = @"I am a biology on earth";
    person.imagePath = [self saveImageDocuments:[UIImage imageNamed:@"bubble.png"]];
    
//    /Users/huanggang/Library/Developer/CoreSimulator/Devices/7B9AE7A4-4838-495B-964D-560DF760F7E1/data/Containers/Data/Application/DE5085BF-5FA8-466C-8F7A-4AEE9BB58DC5/Documents/bubble.png
    NSLog(@"Before archiver:\n%@", [person description]);
    WZLSERIALIZE_ARCHIVE(person, @"Person", [self filePath]);
    
    
//    Person *person = [[Person alloc] init];
//    person.name = @"王者荣耀--> 荆轲";
//    person.age = 23;
//    [person setValue:@"Harely Created me" forKey:@"_father"];
//    person.introInBiology = @"我最终来自与 Biology";
//    NSLog(@"Before archiver:\n%@", [person description]);
//
//    NSMutableData *data = [NSMutableData data];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
//    [archiver encodeObject:person forKey: @"Person"];
//    [archiver finishEncoding];
//    [data writeToFile:[self filePath] atomically:YES];
}


//解档
- (void) solutionFileFunction {
    
    
     Person *thePerson = nil;
     WZLSERIALIZE_UNARCHIVE(thePerson, @"Person", [self filePath]);
    
    NSString *path_sandox = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *path = [path_sandox stringByAppendingString:thePerson.imagePath];
    
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    NSLog(@"iamge:--------_>%@",image);
     NSLog(@"copyPerson:%@", [thePerson description]);
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 120, 80, 50);
    imageView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:imageView];
    
//    Person *thePerson = nil;
//    NSMutableData *dedata = [NSMutableData dataWithContentsOfFile:[self filePath]];
//    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:dedata];
//    thePerson = [unarchiver decodeObjectForKey:@"Person"];
//    [unarchiver finishDecoding];
//
//    NSLog(@"----->thePerson: name: %@, agee: %ld, introInBiology: %@, _father: %@", thePerson.name, (long)thePerson.age, thePerson.introInBiology, [thePerson valueForKey:@"_father"]);
}

- (NSString *)filePath
{
     NSString *archiverFilePath = [NSString stringWithFormat:@"%@/archiver", NSHomeDirectory()];
    NSString * aa = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSLog(@"----------------------_>^%@, ---- %@", archiverFilePath, aa);
     return archiverFilePath;
    
}

//保存图片
-(NSString *)saveImageDocuments:(UIImage *)image{
    //拿到图片
    UIImage *imagesave = image;
    NSString *path_sandox = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/bubble.png"];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(imagesave) writeToFile:imagePath atomically:YES];
    return @"/Documents/bubble.png";
}

// 读取并存贮到相册
-(UIImage *)getDocumentImage{
    // 读取沙盒路径图片
    NSString *aPath3=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),@"bubble"];
    // 拿到沙盒路径图片
    UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
    // 图片保存相册
    UIImageWriteToSavedPhotosAlbum(imgFromUrl3, self, nil, nil);
    return imgFromUrl3;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

+ (void) classMethodTwo {
    NSLog(@"RuntimeController---------> 我是子类方法");
}


@end
