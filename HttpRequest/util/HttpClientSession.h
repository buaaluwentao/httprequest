//
//  HttpClient.h
//  HttpRequest
//
//  Created by luwentao on 2018/8/30.
//  Copyright © 2018年 cmb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HttpClientSession : NSObject
@property NSURLSessionConfiguration * configuration;
@property NSURLSession * session;
//@property NSURLSessionUploadTask * uploadSession;
//@property NSURLSessionDataTask * dataTask;
//@property NSURLSessionDownloadTask * downloadTask;
+ (NSURLSession * ) sessionWithConfiguration:(NSURLSessionConfiguration*)configuration delegate:(id<NSURLSessionDelegate>)sessionDelegate;
@end
