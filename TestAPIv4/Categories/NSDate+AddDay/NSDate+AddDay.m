//
//  NSDate+AddDay.m
//  TestAPIv4
//
//  Created by Dmitriy Demchenko on 7/13/15.
//  Copyright (c) 2015 Organization98. All rights reserved.
//

#import "NSDate+AddDay.h"

@implementation NSDate (AddDay)

+ (NSDate *)getDate:(NSDate *)fromDate daysAhead:(NSUInteger)days
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = days;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateByAddingComponents:dateComponents toDate:fromDate options:0];
}


@end
