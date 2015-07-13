//
//  DateDepartureController.m
//  Parovozom.com
//
//  Created by Dmitriy Demchenko on 02/15/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "DateDepartureController.h"

@interface DateDepartureController () <RSDFDatePickerViewDelegate, RSDFDatePickerViewDataSource>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation DateDepartureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DesertStormColor;
    
    CALayer *border = [CALayer layer];
    border.borderColor = MintColor.CGColor;
    border.borderWidth = 1.f;
    CALayer *layer = self.navigationController.navigationBar.layer;
    border.frame = CGRectMake(0.f, layer.bounds.size.height, layer.bounds.size.width, 1.f);
    [layer addSublayer:border];
    self.navigationItem.title = self.navigationItemTitle;
    self.navigationController.navigationBar.topItem.title = @""; // delete back
    
    // SEGMENT CHOISE DATE
    self.segmentedControl.tintColor = SorbusColor;
    self.segmentedControl.selectedSegmentIndex = -1;
    
    // CALENDAR
    CGRect datePickerViewRect;
    
    // это начало пиздеца!
    datePickerViewRect.origin.x = 0.f;
    datePickerViewRect.origin.y = 20.f + CGRectGetHeight(self.segmentedControl.frame) + 20.f;
    datePickerViewRect.size.width = CGRectGetWidth([UIScreen mainScreen].bounds);
    datePickerViewRect.size.height = CGRectGetHeight([UIScreen mainScreen].bounds) - CGRectGetHeight(self.tabBarController.tabBar.frame) - CGRectGetHeight(self.navigationController.navigationBar.frame) - datePickerViewRect.origin.y - CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
    // это завершение пиздеца!
    RSDFDatePickerView *datePickerView = [[RSDFDatePickerView alloc] initWithFrame:datePickerViewRect];
    [self.view addSubview:datePickerView];
    
    datePickerView.delegate = self;
    datePickerView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - RSDFDatePickerViewDelegate

// Returns YES if the date should be highlighted or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldHighlightDate:(NSDate *)date
{
    return YES;
}

// Returns YES if the date should be selected or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldSelectDate:(NSDate *)date
{
    return YES;
}

// Prints out the selected date.
- (void)datePickerView:(RSDFDatePickerView *)view didSelectDate:(NSDate *)date
{
    [self.delegate setDepartureDate:date];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - RSDFDatePickerViewDataSource

// Returns YES if the date should be marked or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldMarkDate:(NSDate *)date
{
    // The date is an `NSDate` object without time components.
    // So, we need to use dates without time components.
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *todayComponents = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDate *today = [calendar dateFromComponents:todayComponents];
    
    return [date isEqual:today];
}

// Returns YES if all tasks on the date are completed or NO if they are not completed.
- (BOOL)datePickerView:(RSDFDatePickerView *)view isCompletedAllTasksOnDate:(NSDate *)date
{
    return YES;
}

@end