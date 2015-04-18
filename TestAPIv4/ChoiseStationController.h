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


@interface ChoiseStationController : UIViewController

@property (nonatomic, strong) id <ChoiseStationControllerDelegate> delegate;

@end