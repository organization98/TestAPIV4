//
//  NSString+AppDateManager.m
//  TestAPIv4
//
//  Created by Dmitriy Demchenko on 7/14/15.
//  Copyright (c) 2015 Organization98. All rights reserved.
//

#import "NSString+AppDateManager.h"

@implementation NSString (AppDateManager)

static NSString *const DateFormatFromServer =               @"yyyy-MM-dd HH:mm:ss";
static NSString *const RequestDateFormat =                  @"yyyy-MM-dd";
static NSString *const DepartureDateButtonFormat =          @"E, d MMMM yyyy";
static NSString *const DepartureArrivalLabelDateFormat =    @"E, d MMM, HH:mm";

static NSString *const LocaleIdentifierRU =  @"ru_RU";
static NSString *const LocaleIdentifierUA =  @"uk_UA";
static NSString *const LocaleIdentifierUS =  @"en_US";

+ (NSString *)dateForDepartureArrivalLabel:(NSString *)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DateFormatFromServer];
    
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:string];
    
    return [[NSDateFormatter dateFormatterSetDateFormat:DepartureArrivalLabelDateFormat
                                   withLocaleIdentifier:LocaleIdentifierRU] stringFromDate:dateFromString];
}

+ (NSString *)stringForDepartureDateButton:(NSDate *)date
{
    return [[NSDateFormatter dateFormatterSetDateFormat:DepartureDateButtonFormat
                                   withLocaleIdentifier:LocaleIdentifierRU] stringFromDate:date];
}

+ (NSString *)stringForRequest:(NSDate *)date
{
    return [[NSDateFormatter dateFormatterSetDateFormat:RequestDateFormat
                                   withLocaleIdentifier:LocaleIdentifierRU] stringFromDate:date];
}

+ (NSString *)travelTimeFromString:(NSString *)string
{
    NSArray *array = [string componentsSeparatedByString:@":"];
    NSString *hours = [array objectAtIndex:0];
    NSString *mins = [array objectAtIndex:1];
    return [NSString stringWithFormat:@"%li ч : %li м", [hours integerValue], [mins integerValue]];
}

@end
