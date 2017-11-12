//
//  NetRequest.m
//  StruggleSwift
//
//  Created by HuangGang on 2017/11/12.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

#import "NetRequest.h"

@implementation NetRequest

- (void)requestNetWithUrl:(NSString *)urlStr BodyOfRequestForString:(NSString *)bodyStr block:(BLOCK)bl
{
    self.bl = bl;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    request.HTTPMethod = @"post";
    NSData *bodyData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = bodyData;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options :NSJSONReadingMutableContainers error:nil];
        NSLog(@"%lu", [[dic objectForKey:@"news"] count]);
        self.bl(dic);
        
    }];
    
}
+ (void)PostWithUrl:(NSString *)urlStr BodyOfRequestForString:(NSString *)bodyStr block:(BLOCK)bl
{
    NetRequest *netRequest = [[NetRequest alloc] init];
    [netRequest requestNetWithUrl:urlStr BodyOfRequestForString:bodyStr block:bl];
}

@end
