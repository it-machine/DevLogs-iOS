//
//  ASLogModel.h
//  Carousel-iOS
//
//  Created by Антон  Смирнов on 10.11.17.
//  Copyright © 2017 Сергей Романков. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASLogModel : NSObject

@property (nonatomic) NSString* name;
@property (nonatomic) NSString* code;
@property (nonatomic) NSString* info;
@property (nonatomic) NSString* response;

- (void)encodeWithCoder:(NSCoder *)encoder;
- (id)initWithCoder:(NSCoder *)decoder;

@end
