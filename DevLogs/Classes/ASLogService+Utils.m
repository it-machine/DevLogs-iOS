//
//  ASLogService+Utils.m
//  Carousel-iOS
//
//  Created by Антон  Смирнов on 31.10.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "ASLogService+Utils.h"
#import <UIKit/UIKit.h>
#import "ASLogModel.h"


static NSString* logFileName = @"outputLogs.txt";

@implementation ASLogService(Utils)

-(void)receiveLog:(ASLogModel*)model
{
    if(!model){
        return;
    }
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:logFileName];
    
#pragma 1
    //чтение из файла
    NSMutableData *pData = [[NSMutableData alloc]initWithContentsOfFile:path];
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:pData];
    
    NSMutableArray* array;
    if(!unArchiver){
        array = [NSMutableArray new];
    }else{
        array  = [[NSMutableArray alloc]initWithCoder:unArchiver];
    }

    [unArchiver finishDecoding];
    
    
    
#pragma 2
    //запись в файл
    NSMutableData *writeData = [[NSMutableData alloc]init];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:writeData];
    
    NSMutableArray* contentArray = [NSMutableArray new];
    [contentArray addObjectsFromArray:array];
    [contentArray addObject:model];
    
    [contentArray encodeWithCoder:archiver];
    [archiver finishEncoding];
    
    [writeData writeToFile:path atomically:YES];
    
}



-(void)deleteLogs
{
    [[NSFileManager defaultManager] removeItemAtPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:logFileName] error:nil];
}

-(NSString*)getContent
{
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:logFileName];
    
    //чтение из файла
    NSMutableData *pData = [[NSMutableData alloc]initWithContentsOfFile:path];
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:pData];
    
    NSMutableArray* array;
    if(!unArchiver){
        array = [NSMutableArray new];
    }else{
        array  = [[NSMutableArray alloc]initWithCoder:unArchiver];
    }
    
    [unArchiver finishDecoding];
    
    NSMutableString* result = [NSMutableString new];
    
    for(NSObject* obj in array){
        [result appendString:[NSString stringWithFormat:@"%@\r\r", obj.description]];
    }
    
    return result;
}

#pragma -
#pragma mark - API

-(NSMutableURLRequest*)createRequest:(ASLogConfig*)config{
#pragma - 1
    //creating Components
    
    NSURLComponents* components = [NSURLComponents new];
    NSString* content = [self getContent];
    
    if(!content || [content isEqualToString:@""]){
        return nil;
    }
    
    NSURLQueryItem* itemBody = [[NSURLQueryItem alloc]initWithName:@"body" value:content];
    

    
    NSURLQueryItem* itemUserToken = [[NSURLQueryItem alloc]initWithName:@"user_token" value:config.user_token];
    NSURLQueryItem* itemAppToken = [[NSURLQueryItem alloc]initWithName:@"app_token" value:config.app_token];
    NSURLQueryItem* itemPlatform = [[NSURLQueryItem alloc]initWithName:@"platform_id" value:@"1"];
    
    NSURLQueryItem* itemOSVersion = [[NSURLQueryItem alloc]initWithName:@"platform_version" value:[NSString stringWithFormat:@"%@(%@)",[[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]]];
    NSURLQueryItem* itemDevice = [[NSURLQueryItem alloc]initWithName:@"device" value:[[UIDevice currentDevice] model]];
    NSURLQueryItem* itemAppVersion = [[NSURLQueryItem alloc]initWithName:@"app_version" value:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    
    components.queryItems = @[itemBody, itemUserToken, itemAppToken, itemPlatform, itemDevice, itemOSVersion, itemAppVersion];
    
#pragma - 2
    //creating Request
    NSString* strURL = @"https://devlogs.it-machine.ru/api/v1/logs";
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strURL]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:60.0];
    request.HTTPMethod = @"POST";
    
    request.URL = [NSURL URLWithString:strURL];
    request.HTTPBody = [[components percentEncodedQuery] dataUsingEncoding:NSUTF8StringEncoding];
    [request addValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    return request;
}


#pragma -
#pragma mark - Private

-(BOOL)isFileExist:(NSString*)fileName{
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.lastPathComponent == %@", fileName];
    NSArray *matchingPaths = [[[NSFileManager defaultManager] subpathsAtPath:documentsDirectory] filteredArrayUsingPredicate:predicate];
    
    return (matchingPaths.count!=0);
}


@end
