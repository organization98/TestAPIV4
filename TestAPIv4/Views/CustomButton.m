//
//  CustomButton.m
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 01/30/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "CustomButton.h"
#import "SchemeType40.h"

@implementation CustomButton {
    BOOL isSelected;
    NSString *orientation;
}

+ (CustomButton *)buttonWithNumber:(NSString *)number with:(CGRect)rect and:(NSString *)orientation {
    
    // создаем кнопку, задаем Title для кнопки
    CustomButton *btn = [[CustomButton alloc] init];
    btn.layer.cornerRadius = 5;
    [btn setFrame:rect];
    [btn setTitle:number
         forState:UIControlStateNormal];
    [btn setTitle:number
         forState:UIControlStateSelected];
    [btn setTitle:number
         forState:UIControlStateDisabled];
    return btn;
}

- (id)init {
    self = [super init];
    if (self) {
        
        orientation = @"forward";
        
        // задаем цвет шрифта для трех состояний кнопки
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor greenColor] forState:UIControlStateDisabled];
        
        // задаем, что кнопка в состоянии Disabled
        [self setEnabled:NO];
        
        // задаем свойства и @selector для кнопки с состоянием Selected
        isSelected = NO;
        [self setBackgroundColor:[UIColor grayColor]];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setBackgroundImage:[UIImage imageNamed:@"forward-seat-orange"] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(selectedPlaces) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)selectedPlaces {
    if (isSelected == NO) {
        isSelected = YES;
        [self setSelected:YES];
    } else {
        isSelected = NO;
        [self setSelected:NO];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedPlace"
                                                        object:self
                                                      userInfo:@{@"number":@"4"}];
}

@end
