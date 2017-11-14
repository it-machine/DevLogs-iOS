//
//  ASLogService.h
//  Carousel-iOS
//
//  Created by Антон  Смирнов on 31.10.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASLogModel.h"

@interface ASLogService : NSObject

+ (instancetype)sharedInstance;

-(void)addLog:(ASLogModel*)model;
-(void)sendLogs;


@end
