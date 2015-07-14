
//  RoutesCustomCell.m
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 01/28/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "RoutesCustomCell.h"

@implementation RoutesCustomCell

+ (instancetype)initializeCell
{
    NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return [nibObjects objectAtIndex:0];
}

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)updatePrice:(NSNotification *)notification
{
    [self addPriceToLabel:notification.userInfo];
}

- (void)addPriceToLabel:(NSDictionary *)dict
{
    if ([[dict objectForKey:self.wagonType] objectForKey:@"cost"]) {
        self.activityView.hidden = YES;
        self.labelCost = [[UILabel alloc] initWithFrame:CGRectMake(14.f, 157.f, 78.f, 24.f)];
        self.labelCost.font = [UIFont appFontWithSize:17.f];
        self.labelCost.text = [[dict objectForKey:self.wagonType] objectForKey:@"cost"];
        [self addSubview:self.labelCost];
    }
}


//-------------------------

- (void)configForItem:(id)object
{
    NSLog(@"%@", object);
    
//    self.fullName.text = items.name;
//    self.age.text = [items.age stringValue];
//    self.department.text = items.department;
//    self.position.text = items.position;
//    self.salary.text = [items.salary stringValue];
}


@end