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
#import "SessionManager.h"
#import "NSArray+Stations.h"

@interface ChoiseStationController () <UITextFieldDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UISearchController *searchField;
@property (strong, nonatomic) NSArray *stations;

@property (strong, nonatomic) UISearchController *searchController;

@end

static NSString *const kStationCode = @"code";
static NSString *const kStationNameLT = @"name_lt";
static NSString *const kStationNameUK = @"name_uk";
static NSString *const kStationNameRU = @"name_ru";

static NSString *const cellIdentifier = @"Cell";

@implementation ChoiseStationController

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    self.searchController.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    
    [self.searchController.searchBar sizeToFit];
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [[[self.stations objectAtIndex:indexPath.row] objectForKey:kStationNameRU] capitalizedString];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Получить название станции и ее код
    [self.delegate setStationName:[[[self.stations objectAtIndex:indexPath.row] objectForKey:kStationNameRU] capitalizedString] andCode:[[self.stations objectAtIndex:indexPath.row] objectForKey:kStationCode]];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISearchDisplayController delegate methods

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateSearchResultsForSearchController:self.searchController];
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    
    if([searchString length] <= 0 ) {
        [self.tableView reloadData];
        return;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains [cd] %@", searchString];
    self.stations = [self.stations filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
}

#pragma mark - Private methods

- (void)initializeTable
{
    self.stations = [[NSArray alloc] init];
    self.stations = [NSArray stationsArray];
}

@end