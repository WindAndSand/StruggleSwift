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
}


- (void)viewDidAppear:(BOOL)animated {
         [super viewDidAppear:animated];
    
         NSLog(@"我在 ViewController 中的 viewDidAppear 中");
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
    /*
    Person *person = [[Person alloc] init];
    person.name = @"wengzilin";
    person.age = 26;
    [person setValue:@"laoweng" forKey:@"_father"];
    //set value of superClass
    person.introInBiology = @"I am a biology on earth";
    
    NSLog(@"Before archiver:\n%@", [person description]);
    WZLSERIALIZE_ARCHIVE(person, @"Person", [self filePath]);
    */
    
    Person *person = [[Person alloc] init];
    person.name = @"王者荣耀--> 荆轲";
    person.age = 23;
    [person setValue:@"Harely Created me" forKey:@"_father"];
    person.introInBiology = @"我最终来自与 Biology";
    NSLog(@"Before archiver:\n%@", [person description]);
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:person forKey: @"Person"];
    [archiver finishEncoding];
    [data writeToFile:[self filePath] atomically:YES];
}


//解档
- (void) solutionFileFunction {
    
    /*
     Person *thePerson = nil;
     WZLSERIALIZE_UNARCHIVE(thePerson, @"Person", [self filePath]);
     
     NSLog(@"copyPerson:%@", [copyPerson description]);
     */
    Person *thePerson = nil;
    NSMutableData *dedata = [NSMutableData dataWithContentsOfFile:[self filePath]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:dedata];
    thePerson = [unarchiver decodeObjectForKey:@"Person"];
    [unarchiver finishDecoding];
    
    NSLog(@"----->thePerson: name: %@, agee: %ld, introInBiology: %@, _father: %@", thePerson.name, (long)thePerson.age, thePerson.introInBiology, [thePerson valueForKey:@"_father"]);
}

- (NSString *)filePath
{
     NSString *archiverFilePath = [NSString stringWithFormat:@"%@/archiver", NSHomeDirectory()];
     return archiverFilePath;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
