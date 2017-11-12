//
//  LXDDownloadManager.m
//  StruggleSwift
//
//  Created by HuangGang on 2017/11/7.
//  Copyright © 2017年 HuangGang. All rights reserved.
//

#import "LXDDownloadManager.h"
@implementation LXDDownloadManager
{
    LXDDownloadProgressHandler _progress;
}

- (void)downloadWithURL: (NSString *)URL parameters: (NSDictionary *)parameters handler: (LXDDownloadHandler)handler progress: (LXDDownloadProgressHandler)progress
{
    //创建请求对象
    NSURLRequest * request = [self postRequestWithURL: URL params: parameters];
    NSURLSession * session = [NSURLSession sharedSession];
    
    //执行请求任务
    NSURLSessionDataTask * task = [session dataTaskWithRequest: request completionHandler: ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (handler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(data, error);
            });
        }
    }];
    [task resume];
}

- (NSURLRequest *)postRequestWithURL:(NSString *)urlString params:(NSDictionary *)paramsString{
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    NSString *name = [paramsString objectForKey: @"uname"];
    NSString *upas = [paramsString objectForKey: @"upas"];
//    设置要提交的参数
    NSString *args=[NSString stringWithFormat:@"uname=%@&upas=%@&btn=login", name, upas];
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setTimeoutInterval:10];
    
    //设置请求头
    [request setValue:[NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"appVersion"];
    //[request setAllHTTPHeaderFields:nil];
    NSLog(@"header=%@",[request allHTTPHeaderFields]);
    return request;
}

//#pragma mark - 进度协议方法
/**
 进度方法

 @param session 会话
 @param downloadTask 下载任务
 @param bytesWritten 每次写入的data字节数
 @param totalBytesWritten 当前一共写入的data字节数
 @param totalBytesExpectedToWrite 期望收到的所有data字节数
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    double downloadProgress = totalBytesWritten / (double)totalBytesExpectedToWrite;
    if (_progress) { _progress(downloadProgress); }
}

- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    
}

@end
