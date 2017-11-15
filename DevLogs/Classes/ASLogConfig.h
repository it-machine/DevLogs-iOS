//
//  ASLogConfig.h
//  Carousel-iOS
//
//  Created by Антон  Смирнов on 15.11.2017.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASLogConfig : NSObject
@property(nonatomic) BOOL loggingEnabled;
@property(nonatomic) NSString* user_token;
@property(nonatomic) NSString* app_token;

-(instancetype)initWithUserToken:(NSString*)userToken appToken:(NSString*)appToken;

@end
