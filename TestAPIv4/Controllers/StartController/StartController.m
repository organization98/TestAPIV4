//
//  StartController.m
//  TestAPIv4
//
//  Created by Dmitriy Demchenko on 04/18/15.
//  Copyright (c) 2015 Organization98. All rights reserved.
//

#import "StartController.h"

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

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // MAIN VIEW
    self.view.backgroundColor = MintColor;
    
    // LOGO
    UIImageView *logoView = [[UIImageView alloc]
                             initWithFrame:CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds) - 249.f) / 2,
                                                      (((CGRectGetHeight([UIScreen mainScreen].bounds) - 99.f) / 2) - 85) / 2,
                                                      249.f,
                                                      85.f)];
    logoView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:logoView];
    
    // DOUBLE BUTTON VIEW
    self.doubleButtonView.backgroundColor = SilverTreeColor;
    self.doubleButtonView.layer.cornerRadius = CornerRadius;
    self.doubleButtonView.layer.borderColor = WhiteColor.CGColor;
    self.doubleButtonView.layer.borderWidth = BorderWidth;
    
    
    // BUTTON FROM STATION
    [self customizeButton:self.buttonFromStation
           withIdentifier:@"from"
                 setImage:@"carFrom"
                 setTitle:@"Откуда"];
    
    // BUTTON TO STATION
    [self customizeButton:self.buttonToStation
           withIdentifier:@"to"
                 setImage:@"carTo"
                 setTitle:@"Куда"];
    
    // BUTTON CHANGE
    self.buttonChange.backgroundColor = OceanGreenColor;
    self.buttonChange.layer.cornerRadius = CornerRadius;
    self.buttonChange.layer.borderColor = WhiteColor.CGColor;
    self.buttonChange.layer.borderWidth = BorderWidth;
    
    // BUTTON DATE DEPARTURE //
    [self customizeButton:self.buttonDateDeparture
           withIdentifier:nil
                 setImage:@"calendar"
                 setTitle:@"Дата отправления"];
    // обводка и радиус скругления кнопки
    self.buttonDateDeparture.layer.cornerRadius = CornerRadius;
    self.buttonDateDeparture.layer.borderColor = WhiteColor.CGColor;
    self.buttonDateDeparture.layer.borderWidth = BorderWidth;
    
    
    // BUTTON FIND TICKETS
    self.buttonFindTickets.backgroundColor = WhiteColor; // цвета кнопки
    self.buttonFindTickets.layer.cornerRadius = CornerRadius; // радиус скругления кнопки
    // шрифт и текст кнопки
    [self.buttonFindTickets setTitleColor:MintColor forState:UIControlStateNormal];
    [self.buttonFindTickets setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.buttonFindTickets setTitle:@"Найти билеты" forState:UIControlStateNormal];
    [self.buttonFindTickets.titleLabel setFont:[UIFont appFontWithSize:17.f]];
}

// прячем navigationController в MainController
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showDateDeparture"]) {
        DateDepartureController *controller = (DateDepartureController *)segue.destinationViewController;
        controller.navigationItemTitle = @"Дата";
        controller.delegate = self;
    } else if ([segue.identifier isEqualToString:@"showFromStation"]) {
        ChoiseStationController *controller = (ChoiseStationController *)segue.destinationViewController;
        controller.navigationItemTitle = @"Откуда";
        controller.delegate = self;
        self.direction = @"from";
    } else if ([segue.identifier isEqualToString:@"showToStation"]) {
        ChoiseStationController *controller = (ChoiseStationController *)segue.destinationViewController;
        controller.navigationItemTitle = @"Куда";
        controller.delegate = self;
        self.direction = @"to";
    } else if ([segue.identifier isEqualToString:@"tabSegue"]) {
        
        UITabBarController *tabBarController = segue.destinationViewController;
        
        UINavigationController *navController1 = [tabBarController.viewControllers objectAtIndex:0];
        RoutesController *c1 = (RoutesController *)navController1.topViewController;
        c1.stationFrom = self.stationFrom;
        c1.stationTo = self.stationTo;
        c1.startDate = @"2015-04-28"; //self.startDate; // нужно изменить формат даты для запроса
    }
}

#pragma mark - ChoiseStationControllerDelegate

// изменяем Title для кнопок From и To
- (void)setStationName:(NSString *)name andCode:(NSString *)code
{
    if ([self.direction isEqual:@"from"]) {
        [self buttonFromTitle:name];
        self.stationFrom = code;
    } else {
        [self buttonToTitle:name];
        self.stationTo = code;
    }
}

#pragma mark - DateDepartureControllerDelegate

// изменяем Title для кнопоки Departure Date
- (void)setDepartureDate:(NSDate *)date
{
    [self buttonDateTitle:[NSString stringFromDate:date]];
    self.startDate = [NSString stringWithFormat:@"%@", date];
}

#pragma mark - Private methods

- (void)customizeButton:(UIButton *)button withIdentifier:(NSString *)identifier setImage:(NSString *)image setTitle:(NSString *)title
{
    button.restorationIdentifier = identifier;
    
    button.backgroundColor = SilverTreeColor;
    // TODO: уточнить у Макса цвета для состояния UIControlStateHighlighted
    [button setBackgroundImage:[UIImage imageWithColor:OceanGreenColor] forState:UIControlStateHighlighted];
    
    // направление контента внутри кновки:слева
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setImageEdgeInsets:UIEdgeInsetsMake(0.f, 16.f, 0.f, 0.f)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0.f, 24.f, 0.f, 0.f)];
    
    // иконка (слева) для кнопки
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    // шрифт и текст кнопки
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button.titleLabel setFont:[UIFont appFontWithSize:16.f]];
    [button setTitle:title forState:UIControlStateNormal];
}

- (void)buttonDateTitle:(NSString *)name
{
    [self.buttonDateDeparture setTitle:name forState:UIControlStateNormal];
}

- (void)buttonFromTitle:(NSString *)name
{
    [self.buttonFromStation setTitle:name forState:UIControlStateNormal];
}

- (void)buttonToTitle:(NSString *)name
{
    [self.buttonToStation setTitle:name forState:UIControlStateNormal];
}

@end