//
//  NSArray+Stations.m
//  TestAPIv4
//
//  Created by Dmitriy Demchenko on 7/11/15.
//  Copyright (c) 2015 Organization98. All rights reserved.
//

#import "NSArray+Stations.h"

@implementation NSArray (Stations)

static NSString *const kStationCode = @"code";
static NSString *const kStationNameLT = @"name_lt";
static NSString *const kStationNameUK = @"name_uk";
static NSString *const kStationNameRU = @"name_ru";

+ (NSArray *)stationsArray
{
    static dispatch_once_t onceToken;
    static NSArray *stationsArray = nil;
    dispatch_once(&onceToken, ^{
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"all_stations" ofType:@"plist"];
        stationsArray = [NSArray arrayWithContentsOfFile:filePath];
    });
    // сортировка массива по ключу значений
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:kStationNameRU ascending:YES];
    return [stationsArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor, nil]];
}

@end