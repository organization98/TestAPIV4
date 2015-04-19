//
//  SplashSegue.m
//  TestAPIv4
//
//  Created by Dmitriy Demchenko on 04/19/15.
//  Copyright (c) 2015 Organization98. All rights reserved.
//

#import "SplashSegue.h"

@implementation SplashSegue

- (void)perform {
    // Параметр animated:NO, т.к. анимацию перехода мы выполнили в PreStartController
    [[self sourceViewController] presentModalViewController:[self destinationViewController] animated:NO];
}

@end