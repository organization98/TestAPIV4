//
//  NSDate+AddDay.h
//  TestAPIv4
//
//  Created by Dmitriy Demchenko on 7/13/15.
//  Copyright (c) 2015 Organization98. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (AddDay)

+ (NSDate *)getDate:(NSDate *)fromDate daysAhead:(NSUInteger)days;

@end