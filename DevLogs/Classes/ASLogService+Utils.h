//
//  ASLogService+Utils.h
//  Carousel-iOS
//
//  Created by Антон  Смирнов on 31.10.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASLogService.h"
#import "ASLogModel.h"

@interface ASLogService(Utils)

-(void)receiveLog:(ASLogModel*)model;
-(void)deleteLogs;
-(NSString*)getContent;

-(NSMutableURLRequest*)createRequest;

@end
