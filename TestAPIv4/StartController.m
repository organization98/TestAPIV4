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
    self.doubleButtonView.layer.cornerRadius = cornerRadius;
    self.doubleButtonView.layer.borderColor = WhiteColor.CGColor;
    self.doubleButtonView.layer.borderWidth = borderWidth;
    
    
    // BUTTON FROM STATION
    self.buttonFromStation.restorationIdentifier = @"from";
    
    [self.buttonFromStation setBackgroundImage:[UIImage imageWithColor:MintColor]
                                      forState:UIControlStateHighlighted];
    
    // направление контента внутри кновки:слева
    self.buttonFromStation.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.buttonFromStation setImageEdgeInsets:UIEdgeInsetsMake(0.f, 16.f, 0.f, 0.f)];
    [self.buttonFromStation setTitleEdgeInsets:UIEdgeInsetsMake(0.f, 24.f, 0.f, 0.f)];
    
    // иконка (слева) для кнопки
    [self.buttonFromStation setImage:[UIImage imageNamed:@"carFrom"] forState:UIControlStateNormal];
    
    [self.buttonFromStation setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.buttonFromStation.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium.ttf" size:16.f]];
    [self.buttonFromStation setTitle:@"Откуда" forState:UIControlStateNormal];
    
    // BUTTON TO STATION
    self.buttonToStation.restorationIdentifier = @"to";
    
    // цвета состояний
    [self.buttonToStation setBackgroundImage:[UIImage imageWithColor:MintColor]
                                      forState:UIControlStateHighlighted];
    
    // направление контента внутри кновки:слева
    self.buttonToStation.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.buttonToStation setImageEdgeInsets:UIEdgeInsetsMake(0.f, 16.f, 0.f, 0.f)];
    [self.buttonToStation setTitleEdgeInsets:UIEdgeInsetsMake(0.f, 24.f, 0.f, 0.f)];
    
    // иконка (слева) для кнопки
    [self.buttonToStation setImage:[UIImage imageNamed:@"carTo"] forState:UIControlStateNormal];
    
    [self.buttonToStation setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.buttonToStation.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium.ttf" size:16.f]];
    [self.buttonToStation setTitle:@"Куда" forState:UIControlStateNormal];
    
    
    // BUTTON CHANGE
    self.buttonChange.backgroundColor = OceanGreenColor;
    self.buttonChange.layer.cornerRadius = cornerRadius;
    self.buttonChange.layer.borderColor = [UIColor whiteColor].CGColor;
    self.buttonChange.layer.borderWidth = borderWidth;
    
    
    // BUTTON DATE DEPARTURE //
    
    // цвета состояний
    self.buttonDateDeparture.backgroundColor = SilverTreeColor;
    [self.buttonDateDeparture setBackgroundImage:[UIImage imageWithColor:MintColor]
                                        forState:UIControlStateHighlighted];
    
    // обводка и радиус скругления кнопки
    self.buttonDateDeparture.layer.cornerRadius = cornerRadius;
    self.buttonDateDeparture.layer.borderColor = WhiteColor.CGColor;
    self.buttonDateDeparture.layer.borderWidth = borderWidth;
    
    // направление контента внутри кновки:слева
    self.buttonDateDeparture.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.buttonDateDeparture setImageEdgeInsets:UIEdgeInsetsMake(0.f, 16.f, 0.f, 0.f)];
    [self.buttonDateDeparture setTitleEdgeInsets:UIEdgeInsetsMake(0.f, 31.f, 0.f, 0.f)];
    
    // иконка (слева) для кнопки
    [self.buttonDateDeparture setImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
    
    // шрифт и текст кнопки
    [self.buttonDateDeparture setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.buttonDateDeparture.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium.ttf" size:16.f]];
    [self.buttonDateDeparture setTitle:@"Дата отправления" forState:UIControlStateNormal];
    
    
    // BUTTON FIND TICKETS
    
    // цвета кнопки
    self.buttonFindTickets.backgroundColor = WhiteColor;
    
    // радиус скругления кнопки
    self.buttonFindTickets.layer.cornerRadius = cornerRadius;
    
    // шрифт и текст кнопки
    [self.buttonFindTickets setTitleColor:MintColor forState:UIControlStateNormal];
    [self.buttonFindTickets setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.buttonFindTickets setTitle:@"Найти билеты" forState:UIControlStateNormal];
    [self.buttonFindTickets.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium.ttf" size:17.f]];
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