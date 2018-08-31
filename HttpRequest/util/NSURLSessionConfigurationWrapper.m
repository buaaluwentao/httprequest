//
//  NSURLSessionConfigurationWrapper.m
//  HttpRequest
//
//  Created by luwentao on 2018/8/30.
//  Copyright © 2018年 cmb. All rights reserved.
//

#import "NSURLSessionConfigurationWrapper.h"

@implementation NSURLSessionConfigurationWrapper
+(NSURLSessionConfiguration *) getDefaultURLSessionConfiguration{
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 2;
    configuration.timeoutIntervalForResource = 5;
    configuration.HTTPMaximumConnectionsPerHost = 5;
    configuration.HTTPShouldUsePipelining = YES;
    configuration.sessionSendsLaunchEvents = YES;
    configuration.HTTPShouldSetCookies = YES;
    configuration.HTTPCookieAcceptPolicy = YES;
    return configuration;
}
@end
