//
//  NSDateFormatter+SetDateFormat.m
//  TestAPIv4
//
//  Created by Dmitriy Demchenko on 7/14/15.
//  Copyright (c) 2015 Organization98. All rights reserved.
//

#import "NSDateFormatter+SetDateFormat.h"

@implementation NSDateFormatter (SetDateFormat)

+ (NSDateFormatter *)dateFormatterSetDateFormat:(NSString *)dateFormat withLocaleIdentifier:(NSString *)localeIdentifier
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier]];
    [dateFormatter setDateFormat:dateFormat];
    return dateFormatter;
}

@end
