//
//  DateDepartureController.h
//  Parovozom.com
//
//  Created by Dmitriy Demchenko on 02/15/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateDepartureControllerDelegate <NSObject>

@required
- (void)setDepartureDate:(NSDate *)date;

@end


@interface DateDepartureController : UIViewController

@property (strong, nonatomic) NSString *dateDeparture;

@property (nonatomic, strong) id <DateDepartureControllerDelegate> delegate;

@end
