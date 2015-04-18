//
//  CustomButton.h
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 01/30/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton

@property (nonatomic, strong) NSString *number;

+ (CustomButton *)buttonWithNumber:(NSString *)number with:(CGRect)rect and:(NSString *)orientation;

@end