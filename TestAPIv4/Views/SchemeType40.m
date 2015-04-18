//
//  SchemeType40.m
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 01/30/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "SchemeType40.h"
#import "CustomButton.h"

@implementation SchemeType40 {
    NSMutableArray *array;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Load the interface file from .xib
        [[NSBundle mainBundle] loadNibNamed:@"SchemeType40" owner:self options:nil];
        
        // Add as a subview
        [self addSubview:self.viewScheme];
        
        // Add button(s) a subview
        for (UIButton *topButtons in self.buttonsTop) {
            topButtons.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
            topButtons.layer.cornerRadius = 3;
        }
        
        for (UIButton *lowButtons in self.buttonsLow) {
            lowButtons.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1];
            lowButtons.layer.cornerRadius = 3;
        }
        
        array = [[NSMutableArray alloc] init];
        
        int place = 1;
        while (place <= 1) {
            
            CGRect rect;

            if (place == 1) {
                rect = CGRectMake(215, 173, 30, 30);
            }
            
            CustomButton *btn = [CustomButton buttonWithNumber:[[NSNumber numberWithInt:place] description] with:rect and:nil];
            
            [self.viewScheme addSubview:btn];
            place++;
//            continue;
        }
    }
    return self;
}

@end