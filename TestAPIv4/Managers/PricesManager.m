//
//  RequestQueue.m
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 01/29/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "PricesManager.h"


@implementation PricesManager  {
    NSMutableDictionary *pricesDict;
}

- (id)init {
    self = [super init];
    if (self) {
        pricesDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSDictionary *)getPrice:(NSString *)train from:(RoutesCustomCell *)cell {
    if ([pricesDict objectForKey:train]) {
        if ([[pricesDict objectForKey:train] isKindOfClass:[NSDictionary class]]) {
            return [pricesDict objectForKey:train];
        }
        return nil;
    }
    [pricesDict setObject:@"" forKey:train];
    [[SessionManager sharedManager] getPrices:train withType:nil andClass:nil and:^(BOOL succes, id data, NSError *error) {
        if (!data) {
            return;
        }
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        NSDictionary *response = [dict objectForKey:@"items"];
        [pricesDict setObject:response forKey:train];
        [[NSNotificationCenter defaultCenter] postNotificationName:train object:self userInfo:response];
    }];
    return nil;
}

@end