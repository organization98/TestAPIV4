//
//  RoutesController.h
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 01/26/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Route.h"

@interface RoutesController : UIViewController

@property (strong, nonatomic) NSString *stationFrom;
@property (strong, nonatomic) NSString *stationTo;
@property (strong, nonatomic) NSString *startDate;

@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *wagonNumber;
@property (strong, nonatomic) NSString *wagonType;
//@property (strong, nonatomic) NSDictionary *placesDict;

@end