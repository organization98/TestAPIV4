//
//  NSURLRequest+IgnoreSSL.m
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 02/05/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "NSURLRequest+IgnoreSSL.h"

@implementation NSURLRequest (IgnoreSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host {

    if ([host hasSuffix:@"test.plategka.com"]) {
        return YES;
    } else {
        return NO;
    }
}

@end