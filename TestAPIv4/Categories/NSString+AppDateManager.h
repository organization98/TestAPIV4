//
//  NSString+AppDateManager.h
//  TestAPIv4
//
//  Created by Dmitriy Demchenko on 7/14/15.
//  Copyright (c) 2015 Organization98. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AppDateManager)

+ (NSString *)dateForDepartureArrivalLabel:(NSString *)string;
+ (NSString *)stringForDepartureDateButton:(NSDate *)date;
+ (NSString *)stringForRequest:(NSDate *)date;
+ (NSString *)travelTimeFromString:(NSString *)string;

@end
