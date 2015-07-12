//
//  UIFont+AppFont.m
//  TestAPIv4
//
//  Created by Dmitriy Demchenko on 7/12/15.
//  Copyright (c) 2015 Organization98. All rights reserved.
//

#import "UIFont+AppFont.h"

@implementation UIFont (AppFont)

+ (instancetype)appFontWithSize:(float)size
{
    UIFont *appFont = [UIFont fontWithName:@"Roboto-Medium" size:size];
    return appFont;
}

@end