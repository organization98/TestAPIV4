//
//  RequestData.h
//  Parovozom.com
//
//  Created by Dmitriy Demchenko on 02/17/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Route : NSObject

@property (strong, nonatomic) NSString *fromStationName;
@property (strong, nonatomic) NSString *fromStationCode;
@property (strong, nonatomic) NSString *toStationName;
@property (strong, nonatomic) NSString *toStationCode;
@property (strong, nonatomic) NSString *dateDeparture;

+ (Route *)sharedManager;

@end