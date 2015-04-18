//
//  NSString+ContainsStrModernizer.h
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 02/13/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000

@interface NSString (PSPDFModernizer)

// Added in iOS8, retrofitted for iOS7
- (BOOL)containsString:(NSString *)aString;

@end

#endif