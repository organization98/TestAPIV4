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

@interface ChoiseStationController () <UITextFieldDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UISearchController *searchField;
@property (strong, nonatomic) NSArray *stations;

@end

@implementation ChoiseStationController

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Above ios 8.0
//    float os_version = [[[UIDevice currentDevice] systemVersion] floatValue];
//    if (os_version >= 8.000000) {
////        Use UISearchController
//        self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchDisplayController];
//    } else {
////        use UISearchDisaplyController
//        self.controller = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
//    }
    
    CALayer *border = [CALayer layer];
    border.borderColor = MintColor.CGColor;
    border.borderWidth = 1.f;
    CALayer *layer = self.navigationController.navigationBar.layer;
    border.frame = CGRectMake(0.f, layer.bounds.size.height, layer.bounds.size.width, 1.f);
    [layer addSublayer:border];
    
    self.navigationController.navigationBar.topItem.title = @""; // delete back
    
    [self initializeTable];
    
    self.searchDisplayController.delegate = self;
    
    self.navigationItem.title = NSStringFromClass([self class]);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.stations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *dict = [self.stations objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"name"];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Получить название станции и ее код
    [self.delegate setStationName:[[self.stations objectAtIndex:indexPath.row] objectForKey:@"name"]
                          andCode:[[self.stations objectAtIndex:indexPath.row] objectForKey:@"code"]];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISearchDisplayController delegate methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@", searchText);
    
    [self initializeTable];
    
    if([searchText length] <= 0 ) {
        [self.tableView reloadData];
        return;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains [cd] %@", searchText];
    self.stations = [self.stations filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
}

#pragma mark - Private methods

- (void)initializeTable
{
    self.stations = [NSArray array];
    self.stations = @[
                      @{@"name" : @"Donetsk",             @"code" : @"2210700"},
                      @{@"name" : @"Dnepropetrovsk",      @"code" : @"2200001"},
                      @{@"name" : @"Dneprodzerzhinsk",    @"code" : @"2200003"}
                      ];
}

@end