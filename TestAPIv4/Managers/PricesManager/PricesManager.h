//
//  RequestQueue.h
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 01/29/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RoutesCustomCell;

@interface PricesManager : NSObject

- (NSDictionary *)getPrice:(NSString *)train from:(RoutesCustomCell *)cell;

@end