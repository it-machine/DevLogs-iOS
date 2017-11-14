//
//  ASTransportLayer.m
//  mimigram
//
//  Created by Artem Konarev on 07.02.17.
//  Copyright © 2017 it-machine. All rights reserved.
//

#import "ASTransportLayer.h"


@implementation ASTransportLayer

+(void)fetchRequest:(NSMutableURLRequest*)request
           complete:(void(^)(NSDictionary* dicReponse, ASTransportResponseStatus status, NSData* data))complete;{
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession* session = [NSURLSession sessionWithConfiguration:sessionConfig
                                                          delegate:nil
                                                     delegateQueue:nil];
    
    NSURLSessionDataTask*task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse* httpReponse = (NSHTTPURLResponse*)response;
        
        if(error){
            complete(nil, ASTransportResponseStatusNoInternet, data);
            return;
        }
        
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        switch (httpReponse.statusCode) {
            case 500:
                complete(dictionary, ASTransportResponseStatusServerError, data);
                return;
                break;
                
            case 502:
                complete(dictionary, ASTransportResponseStatusServerError, data);
                return;
                break;
                
            case 401:
                complete(dictionary, ASTransportResponseStatusUnAuthorized, data);
                return;
                break;
            case 409:
                complete(dictionary, ASTransportResponseStatusConflict, data);
                return;
                break;
            case 404:
                complete(dictionary, ASTransportResponseStatusNotFound, data);
                return;
                break;
            case 400:
                complete(dictionary, ASTransportResponseStatusBadRequest, data);
                return;
                break;
                
            default:
                break;
        }
        
        
        complete(dictionary, ASTransportResponseStatusSuccess, data);
    }];
    
    [task resume];
}


@end

