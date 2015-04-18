//
//  Constants.h
//  WeatherTest
//
//  Created by Dmitriy Demchenko on 03/11/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+ConvertHEX.h"

// Base colors
#define MintColor [UIColor colorWithHexString:@"#4BB179"] // base green
#define SilverTreeColor [UIColor colorWithHexString:@"#5DB886"] // button green
#define OceanGreenColor [UIColor colorWithHexString:@"#48A26F"] // button selected green

#define WhiteColor [UIColor colorWithHexString:@"#FFFFFF"] // white

#define SorbusColor [UIColor colorWithHexString:@"#F2854C"] // orange

#define HintOfRedColor [UIColor colorWithHexString:@"#FAFAFA"] // base gray
#define DesertStormColor [UIColor colorWithHexString:@"#F9F9F9"] // gray
#define SilverSandColor [UIColor colorWithHexString:@"#C2C2C2"] // light gray


//

FOUNDATION_EXPORT NSString *const WeatherChangeNotification;

extern NSString *const WeatherTemperatureUserInfoKey;
extern NSString *const WeatherWindyUserInfoKey;
extern NSString *const WeatherHumidityUserInfoKey;

//