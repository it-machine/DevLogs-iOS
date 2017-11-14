//
//  ASTransportLayer.h
//  mimigram
//
//  Created by Artem Konarev on 07.02.17.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ASTransportResponseStatus){
    ASTransportResponseStatusSuccess,
    ASTransportResponseStatusUnAuthorized,
    ASTransportResponseStatusBadRequest,
    ASTransportResponseStatusServerError,
    ASTransportResponseStatusNoInternet,
    ASTransportResponseStatusConflict,
    ASTransportResponseStatusNotFound,
};

@interface ASTransportLayer : NSObject

+(void)fetchRequest:(NSMutableURLRequest*)request
           complete:(void(^)(NSDictionary* dicReponse, ASTransportResponseStatus status, NSData* data))complete;


@end


