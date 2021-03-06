//
//  ChoiseStationController.h
//  Parovozom.com
//
//  Created by Dmitriy Demchenko on 02/15/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChoiseStationControllerDelegate <NSObject>

@required

- (void)setStationName:(NSString *)name andCode:(NSString *)code;
//- (void)setDepartureDate:(NSString *)date;

@end


@interface ChoiseStationController : UITableViewController

@property (strong, nonatomic) NSString *navigationItemTitle;
@property (strong, nonatomic) id <ChoiseStationControllerDelegate> delegate;

@end