//
//  NSString+ContainsStrModernizer.m
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 02/13/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "NSString+ContainsStrModernizer.h"
#import <objc/runtime.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000

@implementation NSString (ContainsStrModernizer)

+ (void)load {
    @autoreleasepool {
        [self pspdf_modernizeSelector:NSSelectorFromString(@"containsString:") withSelector:@selector(pspdf_containsString:)];
    }
}

+ (void)pspdf_modernizeSelector:(SEL)originalSelector withSelector:(SEL)newSelector {
    if (![NSString instancesRespondToSelector:originalSelector]) {
        Method newMethod = class_getInstanceMethod(self, newSelector);
        class_addMethod(self, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    }
}

// containsString: has been added in iOS8. We dynamically add this if we run on iOS7.
- (BOOL)pspdf_containsString:(NSString *)aString {
    return [self rangeOfString:aString].location != NSNotFound;
}

@end

#endif