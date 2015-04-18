//
//  UIColor+ConvertHEX.m
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 02/07/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "UIColor+ConvertHEX.h"

@implementation UIColor (ConvertHEX)

+ (UIColor *)colorWithHexString:(NSString *)colorString {
    
    colorString = [colorString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    if (colorString.length == 3) {
        colorString = [NSString stringWithFormat:@"%c%c%c%c%c%c",
                       [colorString characterAtIndex:0], [colorString characterAtIndex:0],
                       [colorString characterAtIndex:1], [colorString characterAtIndex:1],
                       [colorString characterAtIndex:2], [colorString characterAtIndex:2]];
    }
        
    
    if (colorString.length == 6) {
        int r, g, b;
        sscanf([colorString UTF8String], "%2x%2x%2x", &r, &g, &b);
        return [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0];
    }
    return nil;
}

+ (UIColor *)colorWithHexValue:(int)hexValue {
    
    float red   = ((hexValue & 0xFF0000) >> 16)/255.0;
    float green = ((hexValue & 0xFF00) >> 8)/255.0;
    float blue  = (hexValue & 0xFF)/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end