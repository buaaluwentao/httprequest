//
//  ViewController.m
//  HttpRequest
//
//  Created by luwentao on 2018/8/30.
//  Copyright © 2018年 cmb. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "NSURLSessionConfigurationWrapper.h"
#import "HttpClientSession.h"
#import "Monitor+NSURLSessionDelegate.h"
#import "model.h"
@interface ViewController ()<WKNavigationDelegate,NSXMLParserDelegate>
@property NSMutableString *currentElementValue;
@property Temperature *temperature;
@property BOOL storingFlag;
@property NSArray *elementToParse;
@end

@implementation ViewController
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.elementToParse = [[NSArray alloc] initWithObjects:@"city", @"updatetime" ,@"wendu" , @"fengxiang",@"sunrise_1",@"sunset_1",@"environment",@"yestoday",@"forecast" ,@"zhishus", nil];
    self.currentElementValue = [[NSMutableString alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    // 创建configuration，并获取默认配置
    //NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSessionConfiguration * configuration = [NSURLSessionConfigurationWrapper getDefaultURLSessionConfiguration];
    // 创建http会话
    MonitorNSURLSessionDelegate * delegate = [[MonitorNSURLSessionDelegate alloc]init];
    NSURLSession * session = [HttpClientSession sessionWithConfiguration:configuration delegate:delegate];
    //NSURLSession * session = [NSURLSession sessionWithConfiguration:configuration];
    // 创建URL对象
    
    //NSURL * url = [NSURL URLWithString:[NSString stringWithCString:"https://www.sojson.com/open/api/weather/json.shtml?city=北京" encoding:NSUTF8StringEncoding]];
    NSString * http = @"https://www.sojson.com/open/api/weather/xml.shtml?city=北京";
    NSString * encodedHttp = [http stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL * url = [NSURL URLWithString:encodedHttp];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    
    //创建task
    
    NSURLSessionTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        
        parser.delegate = self;
        [parser parse];
     
    }];
    [task resume];
    NSLog(@"launch finish");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSXMLParserDelegate
//1.开始解析XML文件
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"开始解析XML文件");
}
//2.解析XML文件中所有的元素
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
   if([elementName isEqualToString:@"resp"]) {
       Temperature * temperature = [[Temperature alloc] init];
       self.temperature = temperature;
    }
    self.storingFlag = [self.elementToParse containsObject:elementName];
}
//3.XML文件中每一个元素解析完成
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    NSLog(@"XML文件中每一个元素解析完成:elementName:%@,qName:%@",elementName,qName);
    if(self.storingFlag) { // 查询是否是想要的元素
        NSString *trimmedString = [self.currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //将字符串置空
        [self.currentElementValue setString:@""];
        if([elementName isEqualToString:@"city"]){
            self.temperature.city = trimmedString;
        }else if([elementName isEqualToString:@"updatetime"]){
            self.temperature.updatetime = trimmedString;
        }else if([elementName isEqualToString:@"wendu"]){
            self.temperature.wendu = trimmedString;
        }else if([elementName isEqualToString:@"fengxiang"]){
            self.temperature.fengxiang = trimmedString;
        }else if([elementName isEqualToString:@"sunrise_1"]){
            self.temperature.sunrise_1 = trimmedString;
        }else if([elementName isEqualToString:@"sunset_1"]){
            self.temperature.sunset_1 = trimmedString;
        }else if([elementName isEqualToString:@"environment"]){
            self.temperature.environment = trimmedString;
        }else if([elementName isEqualToString:@"yestoday"]){
            self.temperature.yestoday = trimmedString;
        }else if([elementName isEqualToString:@"forecast"]){
            self.temperature.forecast = trimmedString;
        }else if([elementName isEqualToString:@"zhishus"]){
            self.temperature.zhishus = trimmedString;
        }
    }
}
//4.XML所有元素解析完毕
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"XML所有元素解析完毕");
    NSLog(@"什么鬼");
    NSLog(@"%@,%@",self.temperature.updatetime,self.temperature.wendu);
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (self.storingFlag) {
        [self.currentElementValue appendString:string];
    }
}
@end
