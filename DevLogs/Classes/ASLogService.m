//
//  ASLogService.m
//  Carousel-iOS
//
//  Created by Антон  Смирнов on 31.10.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "ASLogService.h"
#import "ASLogService+Utils.h"
#import <UIKit/UIKit.h>


@interface ASLogService()
@end

@implementation ASLogService

+ (instancetype)sharedInstance
{
    static ASLogService *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[ASLogService alloc] init];
    });
    
    return obj;
}


-(void)addLog:(ASLogModel*)model{
    
    if(!self.config.loggingEnabled){
        return;
    }
    
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         [self receiveLog:model];
         [self sendLogs];
     });
}

-(void)sendLogs{
    
    if(!self.config.loggingEnabled){
        return;
    }
    
    [self startIndicator];
    
    NSMutableURLRequest* request = [self createRequest:self.config];
    
    if(!request){
        return;
    }
    
    [ASTransportLayer fetchRequest:request complete:^(NSDictionary *dicReponse, ASTransportResponseStatus status, NSData* data) {
        if(status == ASTransportResponseStatusSuccess){
            [self deleteLogs];
        }
        
    }];
}



#pragma Indicator
-(void)startIndicator{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
        [self performSelector:@selector(hideIndicator) withObject:nil afterDelay:2];
    });
}

-(void)hideIndicator{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
}

@end
