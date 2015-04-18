//
//  UIColor+ConvertHEX.h
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 02/07/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ConvertHEX)

+ (UIColor *)colorWithHexString:(NSString *)colorString;
+ (UIColor *)colorWithHexValue:(int)hexValue;

@end