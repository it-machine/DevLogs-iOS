//
//  ASLogModel.m
//  Carousel-iOS
//
//  Created by Антон  Смирнов on 10.11.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "ASLogModel.h"

@interface ASLogModel()<NSCoding>
@end
@implementation ASLogModel

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }

    
    self.date = [decoder decodeObjectForKey:@"date"];
    self.responseBody = [decoder decodeObjectForKey:@"responseBody"];
    self.apiMethod = [decoder decodeObjectForKey:@"apiMethod"];
    self.url = [decoder decodeObjectForKey:@"url"];
    self.info = [decoder decodeObjectForKey:@"info"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeObject:self.responseBody forKey:@"responseBody"];
    [encoder encodeObject:self.apiMethod forKey:@"apiMethod"];
    [encoder encodeObject:self.url forKey:@"url"];
    [encoder encodeObject:self.info forKey:@"info"];
}

- (NSString *)description {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *stringDate = [NSString stringWithFormat:@"[%@] ", [dateFormatter stringFromDate:self.date]];
    
    NSString *descriptionString = [NSString stringWithFormat:@"date: %@\rquery_url: %@\rinfo: %@\rjson_body: %@", stringDate, self.url, self.info, self.responseBody];
    return descriptionString;
}


@end
