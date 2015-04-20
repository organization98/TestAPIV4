//
//  RoutesCustomCell.h
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 01/28/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoutesCustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *activityView;

@property (strong, nonatomic)  UILabel *labelCost;

@property (weak, nonatomic) IBOutlet UILabel *labelRouteTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelNumber;
@property (weak, nonatomic) IBOutlet UILabel *labelDepartureDate;
@property (weak, nonatomic) IBOutlet UILabel *labelArrivalDate;
@property (weak, nonatomic) IBOutlet UILabel *labelTravelTime;
@property (weak, nonatomic) IBOutlet UILabel *labelWagonType;
@property (weak, nonatomic) IBOutlet UILabel *labelCountPlaces;

@property (weak, nonatomic) IBOutlet UIImageView *clockImage;

@property (strong, nonatomic) NSString *wagonType;
@property (strong, nonatomic) NSString *trainNumber;

- (void)updatePrice:(NSNotification *)n;
- (void)addPriceToLabel:(NSDictionary *)dict;

@end