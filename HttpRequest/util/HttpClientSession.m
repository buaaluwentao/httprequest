//
//  HttpClient.m
//  HttpRequest
//
//  Created by luwentao on 2018/8/30.
//  Copyright © 2018年 cmb. All rights reserved.
//

#import "HttpClientSession.h"

@interface HttpClientSession ()

@end

@implementation HttpClientSession
+ (NSURLSession * ) sessionWithConfiguration:(NSURLSessionConfiguration*)configuration delegate:(id<NSURLSessionDelegate>)sessionDelegate{
    NSURLSession *  session = [NSURLSession sessionWithConfiguration:configuration delegate:sessionDelegate delegateQueue:[NSOperationQueue mainQueue]];
    return session;
}

@end
