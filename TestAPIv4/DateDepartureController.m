//
//  DateDepartureController.m
//  Parovozom.com
//
//  Created by Dmitriy Demchenko on 02/15/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "DateDepartureController.h"
#import "Constants.h"

#import "RSDFDatePickerView.h"

@interface DateDepartureController () <RSDFDatePickerViewDelegate, RSDFDatePickerViewDataSource>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentChoiseDate;

@end

@implementation DateDepartureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DesertStormColor;
    
    self.navigationItem.title = NSStringFromClass([DateDepartureController class]);
    
    // SEGMENT CHOISE DATE
    self.segmentChoiseDate.tintColor = SorbusColor;
    self.segmentChoiseDate.selectedSegmentIndex = -1;
    
    // CALENDAR
    RSDFDatePickerView *datePickerView = [[RSDFDatePickerView alloc] initWithFrame:CGRectMake
                                          (0,
                                           20 + self.segmentChoiseDate.bounds.size.height + 20,
                                           self.view.bounds.size.width,
                                           self.view.bounds.size.height -20 - 44 - 20 - self.segmentChoiseDate.bounds.size.height - 20 - 20)];
    datePickerView.delegate = self;
    datePickerView.dataSource = self;
    [self.view addSubview:datePickerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - RSDFDatePickerViewDelegate

// Returns YES if the date should be highlighted or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldHighlightDate:(NSDate *)date {
    return YES;
}

// Returns YES if the date should be selected or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldSelectDate:(NSDate *)date {
    return YES;
}

// Prints out the selected date.
- (void)datePickerView:(RSDFDatePickerView *)view didSelectDate:(NSDate *)date {
    [self.delegate setDepartureDate:date];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - RSDFDatePickerViewDataSource

// Returns YES if the date should be marked or NO if it should not.
- (BOOL)datePickerView:(RSDFDatePickerView *)view shouldMarkDate:(NSDate *)date {
    // The date is an `NSDate` object without time components.
    // So, we need to use dates without time components.
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *todayComponents = [calendar components:unitFlags fromDate:[NSDate date]];
    NSDate *today = [calendar dateFromComponents:todayComponents];
    
    return [date isEqual:today];
}

// Returns YES if all tasks on the date are completed or NO if they are not completed.
- (BOOL)datePickerView:(RSDFDatePickerView *)view isCompletedAllTasksOnDate:(NSDate *)date {
    return YES;
}

@end