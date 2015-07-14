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
#import "RoutesController.h"

@interface StartController () <ChoiseStationControllerDelegate, DateDepartureControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *doubleButtonView;

@property (weak, nonatomic) IBOutlet UIButton *buttonFromStation;
@property (weak, nonatomic) IBOutlet UIButton *buttonToStation;
@property (weak, nonatomic) IBOutlet UIButton *buttonChange;
@property (weak, nonatomic) IBOutlet UIButton *buttonDateDeparture;
@property (weak, nonatomic) IBOutlet UIButton *buttonFindTickets;

@property (strong, nonatomic) NSString *direction;

@property (assign, nonatomic) BOOL fromStationSelected;
@property (assign, nonatomic) BOOL toStationSelected;
@property (assign, nonatomic) BOOL startDateSelected;

@end


@implementation StartController

// segue: StartController
static NSString *const ShowDateDeparture    = @"showDateDeparture";
static NSString *const ShowFromStation      = @"showFromStation";
static NSString *const ShowToStation        = @"showToStation";
static NSString *const ShowRoute            = @"showRoute";

// button title
static NSString *const FromStationTitle     = @"Откуда";
static NSString *const ToStationTitle       = @"Куда";
static NSString *const DateDepartureTitle   = @"Дата отправления";
static NSString *const FindTicketsTitle     = @"Найти билеты";

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.stationFrom = nil;
    self.stationTo = nil;
    
    self.fromStationSelected = NO;
    self.toStationSelected = NO;
    self.startDateSelected = NO;
    
    // MAIN VIEW
    self.view.backgroundColor = MintColor;
    
    // LOGO
    [self setupAppLogoView];
    
    // DOUBLE BUTTON VIEW
    self.doubleButtonView.backgroundColor = SilverTreeColor;
    self.doubleButtonView.layer.cornerRadius = CornerRadius;
    self.doubleButtonView.layer.borderColor = WhiteColor.CGColor;
    self.doubleButtonView.layer.borderWidth = BorderWidth;
    
    // BUTTON FROM STATION
    [self customizeButton:self.buttonFromStation
           withIdentifier:@"from"
                 setImage:@"carFrom"
                 setTitle:FromStationTitle];
    
    // BUTTON TO STATION
    [self customizeButton:self.buttonToStation
           withIdentifier:@"to"
                 setImage:@"carTo"
                 setTitle:ToStationTitle];
    
    // BUTTON CHANGE
    self.buttonChange.backgroundColor = OceanGreenColor;
    self.buttonChange.layer.cornerRadius = CornerRadius;
    self.buttonChange.layer.borderColor = WhiteColor.CGColor;
    self.buttonChange.layer.borderWidth = BorderWidth;
    
    // BUTTON DATE DEPARTURE //
    [self customizeButton:self.buttonDateDeparture
           withIdentifier:nil
                 setImage:@"calendar"
                 setTitle:DateDepartureTitle];
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
    [self.buttonFindTickets setTitle:FindTicketsTitle forState:UIControlStateNormal];
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

#warning Добавить валидацию перед переходом в RoutesController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:ShowDateDeparture]) {
        DateDepartureController *controller = (DateDepartureController *)segue.destinationViewController;
        controller.navigationItemTitle = @"Дата";
        controller.delegate = self;
        
    } else if ([segue.identifier isEqualToString:ShowFromStation]) {
        ChoiseStationController *controller = (ChoiseStationController *)segue.destinationViewController;
        controller.navigationItemTitle = @"Откуда";
        controller.delegate = self;
        self.direction = @"from";
        
    } else if ([segue.identifier isEqualToString:ShowToStation]) {
        ChoiseStationController *controller = (ChoiseStationController *)segue.destinationViewController;
        controller.navigationItemTitle = @"Куда";
        controller.delegate = self;
        self.direction = @"to";
        
    } else {
        RoutesController *controller = (RoutesController *)segue.destinationViewController;
        controller.navigationItemTitle = @"Билеты";
        controller.stationFrom = self.stationFrom;
        controller.stationTo = self.stationTo;
        controller.startDate = [NSString stringForRequest:self.startDate];
    }
}

#pragma mark - ChoiseStationControllerDelegate

// изменяем Title для кнопок From и To
- (void)setStationName:(NSString *)name andCode:(NSString *)code
{
    if ([self.direction isEqual:@"from"]) {
        [self buttonFromTitle:name];
        self.stationFrom = code;
        self.fromStationSelected = YES;
    } else {
        [self buttonToTitle:name];
        self.stationTo = code;
        self.toStationSelected = YES;
    }
}

#pragma mark - DateDepartureControllerDelegate

// изменяем Title для кнопоки Departure Date
- (void)setDepartureDate:(NSDate *)date
{
    [self buttonDateTitle:[NSString stringForDepartureDateButton:date]];
    self.startDate = date;
    self.startDateSelected = YES;
}

#pragma mark - IBActions

- (IBAction)reroutingAction:(UIButton *)sender
{
    NSString *fromTitle = self.buttonFromStation.titleLabel.text;
    NSString *fromCode  = self.stationFrom;
    
    NSString *toTitle   = self.buttonToStation.titleLabel.text;
    NSString *toCode    = self.stationTo;
    
    if (!self.stationFrom && self.stationTo)
    {
        self.stationFrom = toCode;
        [self.buttonFromStation setTitle:toTitle forState:UIControlStateNormal];
        self.fromStationSelected = YES;
        
        [self.buttonToStation setTitle:ToStationTitle forState:UIControlStateNormal];
        self.stationTo = nil;
        self.toStationSelected = NO;
        
        return;
    }
    
    if (!self.stationTo && self.stationFrom)
    {
        self.stationTo = fromCode;
        [self.buttonToStation setTitle:fromTitle forState:UIControlStateNormal];
        self.toStationSelected = YES;
        
        [self.buttonFromStation setTitle:FromStationTitle forState:UIControlStateNormal];
        self.stationFrom = nil;
        self.fromStationSelected = NO;
        
        return;
    }
    
    if (self.stationFrom && self.stationTo)
    {
        self.stationFrom = toCode;
        self.stationTo = fromCode;
        
        [self.buttonFromStation setTitle:toTitle forState:UIControlStateNormal];
        [self.buttonToStation setTitle:fromTitle forState:UIControlStateNormal];
        
        return;
    }
}

#pragma mark - Private methods

- (void)setupAppLogoView
{
    CGRect appLogoRect;
    appLogoRect.origin.x = (CGRectGetWidth([UIScreen mainScreen].bounds) - 249.f) / 2,
    appLogoRect.origin.y = (((CGRectGetHeight([UIScreen mainScreen].bounds) - 99.f) / 2) - 85) / 2;
    appLogoRect.size.width = 249.f;
    appLogoRect.size.height = 85.f;
    UIImageView *appLogoView = [[UIImageView alloc] initWithFrame:appLogoRect];
    appLogoView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:appLogoView];
}

#warning Уточнить у Макса цвета для состояния UIControlStateHighlighted
- (void)customizeButton:(UIButton *)button withIdentifier:(NSString *)identifier setImage:(NSString *)image setTitle:(NSString *)title
{
    button.restorationIdentifier = identifier;
    
    button.backgroundColor = SilverTreeColor;
    
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

/*
 UITabBarController *tabBarController = segue.destinationViewController;
 
 UINavigationController *navController1 = [tabBarController.viewControllers objectAtIndex:0];
 RoutesController *c1 = (RoutesController *)navController1.topViewController;
 c1.stationFrom = self.stationFrom;
 c1.stationTo = self.stationTo;
 c1.startDate = @"2015-04-28"; //self.startDate; // нужно изменить формат даты для запроса
*/
