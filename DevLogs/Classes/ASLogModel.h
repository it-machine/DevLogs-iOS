//
//  ASLogModel.h
//  Carousel-iOS
//
//  Created by Антон  Смирнов on 10.11.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASLogModel : NSObject
@property(nonatomic)NSDate* date;
@property(nonatomic)NSString* responseBody;
@property(nonatomic)NSString* apiMethod;
@property(nonatomic)NSString* url;
@property(nonatomic)NSString* info;


- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;

-(instancetype)initWithUrl:(NSString*)url responseBody:(NSString*)responseBody info:(NSString*)info;

@end
