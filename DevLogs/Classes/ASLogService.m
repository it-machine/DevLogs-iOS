//
//  ASLogService.m
//  Carousel-iOS
//
//  Created by Антон  Смирнов on 31.10.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import "ASLogService.h"
#import "ASLogService+Utils.h"
#import "ASTransportLayer.h"
#import <AVFoundation/AVFoundation.h> 



typedef void(^LogServiceResponse)(NSDictionary*dicReponse, ASTransportResponseStatus status);

@interface ASLogService()

@property(nonatomic) NSDate* lastClickDate;
@property(nonatomic) BOOL responseInProgress;


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

-(instancetype)init{
    self = [super init];
    if(self){
        AVAudioSession* audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive:YES error:nil];
        [audioSession addObserver:self
                       forKeyPath:@"outputVolume"
                          options:0
                          context:nil];
    }
    return self;
}


-(void)addLog:(ASLogModel*)model{
    
    if(!self.config.loggingEnabled){
        return;
    }
    
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         [self receiveLog:model];
     });
}

-(void)sendLogs{
    
    if(!self.config.loggingEnabled){
        return;
    }
    
    [self startIndicator];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSMutableURLRequest* request = [self createRequest:self.config];
    
        if(!request){
            self.responseInProgress = NO;
            return;
        }
       
        [ASTransportLayer fetchRequest:request complete:^(NSDictionary *dicReponse, ASTransportResponseStatus status, NSData* data) {
            if(status == ASTransportResponseStatusSuccess){
                [self deleteLogs];
            }
            self.responseInProgress = NO;
        }];
    });
}



-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if(!self.config.loggingEnabled){
        return;
    }
    
    if ([keyPath isEqual:@"outputVolume"]) {
        if(!self.lastClickDate){
            self.lastClickDate = [NSDate date];
            return;
        }
        
        NSTimeInterval intervalLast = self.lastClickDate.timeIntervalSince1970;
        NSTimeInterval intervalNow = [NSDate date].timeIntervalSince1970;
        
        if(intervalLast+1 >= intervalNow && !self.responseInProgress){
            [self sendLogs];
            self.responseInProgress = YES;
        }
        
         self.lastClickDate = [NSDate date];
    }
}


#pragma Indicator
-(void)startIndicator{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    [self performSelector:@selector(hideIndicator) withObject:nil afterDelay:2];
}

-(void)hideIndicator{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
}

@end
