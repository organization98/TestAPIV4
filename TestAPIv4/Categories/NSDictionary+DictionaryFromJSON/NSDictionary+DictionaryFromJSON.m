//
//  NSDictionary+DictionaryFromJSON.m
//  TestAPIv4
//
//  Created by Dmitriy Demchenko on 7/14/15.
//  Copyright (c) 2015 Organization98. All rights reserved.
//

#import "NSDictionary+DictionaryFromJSON.h"

@implementation NSDictionary (DictionaryFromJSON)

+ (NSDictionary *)dictionaryFromJSON:(NSData *)data with:(NSError *)error
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
}

@end
