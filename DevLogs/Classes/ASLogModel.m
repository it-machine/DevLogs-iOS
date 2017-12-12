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
    self.response = [decoder decodeObjectForKey:@"response"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.code forKey:@"code"];
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeObject:self.info forKey:@"info"];
    [encoder encodeObject:self.response forKey:@"response"];
}

-(NSString*)getCurrentDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *stringDate = [NSString stringWithFormat:@"[%@] ", [dateFormatter stringFromDate:[NSDate date]]];
    return stringDate;
}


- (NSString *)description
{
    
    NSMutableString* mutString = [NSMutableString new];
    
    if(self.name){
        [mutString appendString:[NSString stringWithFormat:@"name: %@\r", self.name]];
    }
    
    if(self.code){
        [mutString appendString:[NSString stringWithFormat:@"code: %@\r", self.code]];
    }
    
    if(self.info){
        [mutString appendString:[NSString stringWithFormat:@"info: %@\r", self.info]];
    }
    
    if(self.date){
        [mutString appendString:[NSString stringWithFormat:@"date: %@\r", self.date]];
    }
    
    if(self.response){
        [mutString appendString:[NSString stringWithFormat:@"response: %@\r\r", self.response]];
    }
    
    return mutString;
}


@end
