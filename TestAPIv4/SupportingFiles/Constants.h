//
//  Constants.h
//  TestAPIv4
//
//  Created by Dmitriy Demchenko on 04/19/15.
//  Copyright (c) 2015 Organization98. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef TestAPIv4_Constants_h
#define TestAPIv4_Constants_h

//#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] != NSOrderedAscending)
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.f && [[[UIDevice currentDevice] systemVersion] floatValue] < 8.f)
#define IOS8_AND_LETER ([[[UIDevice currentDevice] systemVersion] compare:@"8" options:NSNumericSearch] != NSOrderedAscending)

// base colors
#define MintColor [UIColor colorWithHexString:@"#4BB179"]           // base green
#define SilverTreeColor [UIColor colorWithHexString:@"#5DB886"]     // button green
#define OceanGreenColor [UIColor colorWithHexString:@"#48A26F"]     // button selected green
#define WhiteColor [UIColor colorWithHexString:@"#FFFFFF"]          // white
#define SorbusColor [UIColor colorWithHexString:@"#F2854C"]         // orange
#define HintOfRedColor [UIColor colorWithHexString:@"#FAFAFA"]      // base gray
#define DesertStormColor [UIColor colorWithHexString:@"#F9F9F9"]    // gray
#define SilverSandColor [UIColor colorWithHexString:@"#C2C2C2"]     // light gray

// start controller UI
static float const CornerRadius = 5.f;
static float const BorderWidth = 1.f;

// stationsArray keys
static NSString *const kStationCode     = @"code";
static NSString *const kStationNameLT   = @"name_lt";
static NSString *const kStationNameUK   = @"name_uk";
static NSString *const kStationNameRU   = @"name_ru";

#endif