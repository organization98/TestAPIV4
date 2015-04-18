//
//  NSString+NSDateFormatter.h
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 02/06/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSDateFormatter)

+ (NSString *)dateFromString:(NSString *)string;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)travelTimeFromString:(NSString *)string;

@end