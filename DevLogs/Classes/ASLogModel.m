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

    self.name = [decoder decodeObjectForKey:@"name"];
    self.value = [decoder decodeObjectForKey:@"value"];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.value forKey:@"value"];
}

-(instancetype)initWithName:(NSString*)name value:(NSString*)value{
    self = [super init];
    if(self){
        self.name = name;
        self.value = value;
    }
    return self;
}

- (NSString *)description {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *stringDate = [NSString stringWithFormat:@"[%@] ", [dateFormatter stringFromDate:[NSDate date]]];
    
    NSString *descriptionString = [NSString stringWithFormat:@"date: %@\rname: %@\rvalue: %@", stringDate, self.name, self.value];
    return descriptionString;
}


@end
