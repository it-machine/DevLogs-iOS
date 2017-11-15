//
//  ASLogConfig.m
//  Carousel-iOS
//
//  Created by Антон  Смирнов on 15.11.2017.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "ASLogConfig.h"

@implementation ASLogConfig

-(instancetype)initWithUserToken:(NSString*)userToken appToken:(NSString*)appToken{
    self = [super init];
    if(self){
        self.user_token = userToken;
        self.app_token = appToken;
    }
    return self;
}

@end
