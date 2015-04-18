//
//  SchemeType40.h
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 01/30/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchemeType40 : UIView

@property (strong, nonatomic) IBOutlet UIView *viewScheme;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonsTop;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttonsLow;

@end