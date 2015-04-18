//
//  StartController.m
//  TestAPIv4
//
//  Created by Dmitriy Demchenko on 04/18/15.
//  Copyright (c) 2015 Organization98. All rights reserved.
//

#import "StartController.h"
#import "Constants.h"

// categories
#import "NSString+NSDateFormatter.h"
#import "UIImage+ImageWithColor.h"

// controllers
#import "ChoiseStationController.h"
#import "DateDepartureController.h"

// tabBarControllers
#import "RoutesController.h"
#import "MyTicketsController.h"
#import "MoreController.h"

@interface StartController () <ChoiseStationControllerDelegate, DateDepartureControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *doubleButtonView;

@property (weak, nonatomic) IBOutlet UIButton *buttonFromStation;
@property (weak, nonatomic) IBOutlet UIButton *buttonToStation;
@property (weak, nonatomic) IBOutlet UIButton *buttonChange;
@property (weak, nonatomic) IBOutlet UIButton *buttonDateDeparture;
@property (weak, nonatomic) IBOutlet UIButton *buttonFindTickets;

@property (strong, nonatomic) NSString *direction;

@end


@implementation StartController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // MAIN VIEW
    self.view.backgroundColor = MintColor;
    
    // LOGO
    UIImageView *logoView = [[UIImageView alloc]
                             initWithFrame:CGRectMake((self.view.bounds.size.width - 249) / 2,
                                                      (((self.view.bounds.size.height - 99) / 2) - 85) / 2,
                                                      249,
                                                      85)];
    logoView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:logoView];
    
    // DOUBLE BUTTON VIEW
    self.doubleButtonView.backgroundColor = SilverTreeColor;
    self.doubleButtonView.layer.cornerRadius = 4.5f;
    self.doubleButtonView.layer.borderColor = WhiteColor.CGColor;
    self.doubleButtonView.layer.borderWidth = 2.f;
    
    // BUTTON FROM STATION
    self.buttonFromStation.restorationIdentifier = @"from";
    [self.buttonFromStation setBackgroundImage:[UIImage imageWithColor:MintColor]
                                      forState:UIControlStateHighlighted];
    [self.buttonFromStation setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];    
    [self.buttonFromStation setTitle:@"Откуда" forState:UIControlStateNormal];
    
    // BUTTON TO STATION
    self.buttonToStation.restorationIdentifier = @"to";
    [self.buttonToStation setBackgroundImage:[UIImage imageWithColor:MintColor]
                                    forState:UIControlStateHighlighted];
    [self.buttonToStation setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.buttonToStation setTitle:@"Куда" forState:UIControlStateNormal];
    
    // BUTTON CHANGE
    self.buttonChange.backgroundColor = OceanGreenColor;
    self.buttonChange.layer.cornerRadius = 4.5f;
    self.buttonChange.layer.borderColor = [UIColor whiteColor].CGColor;
    self.buttonChange.layer.borderWidth = 2.f;
    
    // BUTTON DATE DEPARTURE
    self.buttonDateDeparture.backgroundColor = SilverTreeColor;
    [self.buttonDateDeparture setBackgroundImage:[UIImage imageWithColor:MintColor]
                                        forState:UIControlStateHighlighted];
    self.buttonDateDeparture.layer.cornerRadius = 4.5f;
    self.buttonDateDeparture.layer.borderColor = [UIColor whiteColor].CGColor;
    self.buttonDateDeparture.layer.borderWidth = 2.f;
    [self.buttonDateDeparture setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.buttonDateDeparture setTitle:@"Дата отправления" forState:UIControlStateNormal];
    
    // BUTTON FIND TICKETS
    self.buttonFindTickets.backgroundColor = WhiteColor;
    self.buttonFindTickets.layer.cornerRadius = 4.5f;
    [self.buttonFindTickets setTitle:@"Найти билеты" forState:UIControlStateNormal];
    [self.buttonFindTickets.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium.ttf" size:16.f]];
    self.buttonFindTickets.tintColor = MintColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)buttonDateTitle:(NSString *)name {
    [self.buttonDateDeparture setTitle:name forState:UIControlStateNormal];
}

- (void)buttonFromTitle:(NSString *)name {
    [self.buttonFromStation setTitle:name forState:UIControlStateNormal];
}

- (void)buttonToTitle:(NSString *)name {
    [self.buttonToStation setTitle:name forState:UIControlStateNormal];
}

// прячем navigationController в MainController
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDateDeparture"]) {
        DateDepartureController *controller = (DateDepartureController *)segue.destinationViewController;
        controller.delegate = self;
    } else if ([segue.identifier isEqualToString:@"showFromStation"]) {
        ChoiseStationController *controller = (ChoiseStationController *)segue.destinationViewController;
        controller.delegate = self;
        self.direction = @"from";
    } else if ([segue.identifier isEqualToString:@"showToStation"]) {
        ChoiseStationController *controller = (ChoiseStationController *)segue.destinationViewController;
        controller.delegate = self;
        self.direction = @"to";
    } else if ([segue.identifier isEqualToString:@"tabSegue"]) {
        
        UITabBarController *tabBarController = segue.destinationViewController;
        
        UINavigationController *navController1 = [tabBarController.viewControllers objectAtIndex:0];
        RoutesController *c1 = (RoutesController *)navController1.topViewController;
        c1.stationFrom = self.stationFrom;
        c1.stationTo = self.stationTo;
        c1.startDate = @"2015-04-28"; //self.startDate; // нужно изменить формат даты для запроса
        
        /*
         UITabBarController *tabBarController = segue.destinationViewController;
         tabBarController.title = @"TabBar";
         RoutesController *c1 = (RoutesController *)[tabBarController.viewControllers objectAtIndex:0];
         c1.stationFrom = self.stationFrom;
         c1.stationTo = self.stationTo;
         c1.startDate = @"2015-03-28"; //self.startDate; // нужно изменить формат даты для запроса
         */
    }
}

// изменяем Title для кнопок From и To
- (void)setStationName:(NSString *)name andCode:(NSString *)code {
    if ([self.direction isEqual:@"from"]) {
        [self buttonFromTitle:name];
        self.stationFrom = code;
    } else {
        [self buttonToTitle:name];
        self.stationTo = code;
    }
}

// изменяем Title для кнопоки Departure Date
- (void)setDepartureDate:(NSDate *)date {
    [self buttonDateTitle:[NSString stringFromDate:date]];
    self.startDate = [NSString stringWithFormat:@"%@", date];
}

@end