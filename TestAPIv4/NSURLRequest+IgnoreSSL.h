//
//  NSURLRequest+IgnoreSSL.h
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 02/05/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (IgnoreSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;

@end