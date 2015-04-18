//
//  StartController.h
//  TestAPIv4
//
//  Created by Dmitriy Demchenko on 04/18/15.
//  Copyright (c) 2015 Organization98. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"

@interface StartController : UIViewController

@property (strong, nonatomic) Route *route;

@property (strong, nonatomic) NSString *stationFrom;
@property (strong, nonatomic) NSString *stationTo;
@property (strong, nonatomic) NSString *startDate;

@end