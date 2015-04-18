//
//  RequestData.m
//  Parovozom.com
//
//  Created by Dmitriy Demchenko on 02/17/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "Route.h"

@implementation Route

+ (Route *)sharedManager {
    static Route *manager = nil;
    static dispatch_once_t onceTaken;
    dispatch_once (&onceTaken, ^{
        manager = [[Route alloc] init];
    });
    return manager;
}

@end