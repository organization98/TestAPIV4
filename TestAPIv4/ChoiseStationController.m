//
//  ChoiseStationController.m
//  Parovozom.com
//
//  Created by Dmitriy Demchenko on 02/15/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "ChoiseStationController.h"
#import "StartController.h"
//#import "Route.h"
#import "Constants.h"

@interface ChoiseStationController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ChoiseStationController {
    NSArray *stations;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.searchField addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.searchField.delegate = self;
    
    [self initializeTable];
    
    self.navigationItem.title = NSStringFromClass([ChoiseStationController class]);
    self.view.backgroundColor = MintColor;
}

- (void)initializeTable {
    stations = [[NSArray alloc]initWithObjects:
                @{@"name" : @"Donetsk",             @"code" : @"2210700"},
                @{@"name" : @"Dnepropetrovsk",      @"code" : @"2200001"},
                @{@"name" : @"Dneprodzerzhinsk",    @"code" : @"2200003"}, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [stations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *dict = [stations objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"name"];
    
    return cell;
}

#pragma mark - UITableViewDelegate

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Получить название станции и ее код
    [self.delegate setStationName:[[stations objectAtIndex:indexPath.row] objectForKey:@"name"]
                          andCode:[[stations objectAtIndex:indexPath.row] objectForKey:@"code"]];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidChange:(UITextField *)textField {
    [self initializeTable];
    
    if([textField.text length] <= 0 ) {
        [self.tableView reloadData];
        return;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains [cd] %@", textField.text];
    stations = [stations filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
}

@end