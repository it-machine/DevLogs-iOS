//
//  ASLogModel.m
//  Carousel-iOS
//
//  Created by Антон  Смирнов on 10.11.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "ASLogModel.h"

@implementation ASLogModel

-(instancetype)init{
    self = [super init];
    if(self){
        self.date = [self getCurrentDate];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (!self) {
        return nil;
    }

    self.name = [decoder decodeObjectForKey:@"name"];
    self.code = [decoder decodeObjectForKey:@"code"];
    self.date = [decoder decodeObjectForKey:@"date"];
    self.info = [decoder decodeObjectForKey:@"info"];
    self.httpBody = [decoder decodeObjectForKey:@"httpBody"];
    self.response = [decoder decodeObjectForKey:@"response"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.code forKey:@"code"];
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeObject:self.info forKey:@"info"];
    [encoder encodeObject:self.httpBody forKey:@"httpBody"];
    [encoder encodeObject:self.response forKey:@"response"];
}

-(NSString*)getCurrentDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *stringDate = [NSString stringWithFormat:@"[%@] ", [dateFormatter stringFromDate:[NSDate date]]];
    return stringDate;
}

-(NSString*)getStringFromHttpBody:(NSData*)httpBody{
    NSString* bodyStr = [[NSString alloc]initWithData:httpBody encoding:NSUTF8StringEncoding];
    return bodyStr;
}


- (NSString *)description
{
    
    NSMutableString* mutString = [NSMutableString new];
    
    if(self.name && self.name.length>0){
        [mutString appendString:[NSString stringWithFormat:@"name: %@\r", self.name]];
    }
    
    if(self.code && self.code.length>0){
        [mutString appendString:[NSString stringWithFormat:@"code: %@\r", self.code]];
    }
    
    if(self.info && self.info.length>0){
        [mutString appendString:[NSString stringWithFormat:@"info: %@\r", self.info]];
    }
    
    if(self.date && self.date.length>0){
        [mutString appendString:[NSString stringWithFormat:@"date: %@\r", self.date]];
    }
    
    if(self.httpBody && self.httpBody.length>0){
        [mutString appendString:[NSString stringWithFormat:@"httpBody: %@\r", self.httpBody]];
    }
    
    if(self.response && self.response.length>0){
        [mutString appendString:[NSString stringWithFormat:@"response: %@\r\r", self.response]];
    }
    
    return mutString;
}


@end
