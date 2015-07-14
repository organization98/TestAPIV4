//
//  NSDateFormatter+SetDateFormat.h
//  TestAPIv4
//
//  Created by Dmitriy Demchenko on 7/14/15.
//  Copyright (c) 2015 Organization98. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (SetDateFormat)

+ (NSDateFormatter *)dateFormatterSetDateFormat:(NSString *)dateFormat withLocaleIdentifier:(NSString *)localeIdentifier;

@end