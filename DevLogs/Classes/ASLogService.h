//
//  ASLogService.h
//  Carousel-iOS
//
//  Created by Антон  Смирнов on 31.10.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASLogModel.h"
#import "ASLogConfig.h"
#import "ASTransportLayer.h"

typedef void(^ASLogServiceComplete)(ASTransportResponseStatus status);

@interface ASLogService : NSObject

+ (instancetype)sharedInstance;

@property(nonatomic) ASLogConfig* config;

-(void)addLog:(ASLogModel*)model;


@end
