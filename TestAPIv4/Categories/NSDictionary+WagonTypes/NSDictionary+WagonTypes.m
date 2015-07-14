//
//  NSDictionary+WagonTypes.m
//  TestAPIv4
//
//  Created by Dmitriy Demchenko on 7/14/15.
//  Copyright (c) 2015 Organization98. All rights reserved.
//

#import "NSDictionary+WagonTypes.h"

@implementation NSDictionary (WagonTypes)

+ (NSDictionary *)wagonTypesDictionary
{
    static dispatch_once_t onceToken;
    static NSDictionary *wagonTypesDictionary = nil;
    dispatch_once(&onceToken, ^{
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"wagon_types" ofType:@"plist"];
        wagonTypesDictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
    });
    return wagonTypesDictionary;
}

@end
