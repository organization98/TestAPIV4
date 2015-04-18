
//  RoutesCustomCell.m
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 01/28/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "RoutesCustomCell.h"
#import "DejalActivityView.h"

@implementation RoutesCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)updatePrice:(NSNotification *)notification {
    [self addPriceToLabel:notification.userInfo];
}

- (void)addPriceToLabel:(NSDictionary *)dict {
    if ([[dict objectForKey:self.wagonType] objectForKey:@"cost"]) {
        self.activityView.hidden = YES;
        self.labelCost = [[UILabel alloc] initWithFrame:CGRectMake(20, 171, 60, 21)];
        self.labelCost.text = [[dict objectForKey:self.wagonType] objectForKey:@"cost"];
        [self addSubview:self.labelCost];
    }
}

@end