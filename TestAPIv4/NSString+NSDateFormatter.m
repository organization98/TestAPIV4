//
//  NSString+NSDateFormatter.m
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 02/06/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "NSString+NSDateFormatter.h"

@implementation NSString (NSDateFormatter)

+ (NSString *)dateFromString:(NSString *)string {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:string];
    /*
    NSLocale *ruLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
    NSLocale *ukLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"uk_UA"];
    NSLocale *enLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    */
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]]; // [NSLocale currentLocale]
    [dateFormatter2 setDateFormat:@"E, d MMM, HH:mm"];
    
    return [dateFormatter2 stringFromDate:dateFromString];
}

+ (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]]; // [NSLocale currentLocale]
    [dateFormatter2 setDateFormat:@"E, d MMMM yyyy"];
    return [dateFormatter2 stringFromDate:date];
}

+ (NSString *)travelTimeFromString:(NSString *)string {
    NSArray *array = [string componentsSeparatedByString:@":"];
    NSString *hours = [array objectAtIndex:0];
    NSString *mins = [array objectAtIndex:1];
    return [NSString stringWithFormat:@"%li ч : %li м", [hours integerValue], [mins integerValue]];
}

@end