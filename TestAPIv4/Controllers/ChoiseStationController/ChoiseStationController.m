//
//  ChoiseStationController.m
//  Parovozom.com
//
//  Created by Dmitriy Demchenko on 02/15/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "ChoiseStationController.h"
#import "StartController.h"

@interface ChoiseStationController () <UISearchDisplayDelegate>

@property (strong, nonatomic) NSArray *stations;
@property (strong, nonatomic) NSMutableArray *searchResults;

@end

static NSString *const ReuseIdentifier = @"Cell";

@implementation ChoiseStationController

#pragma mark - Life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializeTable];
    self.searchResults = [[NSMutableArray alloc] init];
    
    CALayer *border = [CALayer layer];
    border.borderColor = MintColor.CGColor;
    border.borderWidth = 1.f;
    CALayer *layer = self.navigationController.navigationBar.layer;
    border.frame = CGRectMake(0.f, layer.bounds.size.height, layer.bounds.size.width, 1.f);
    [layer addSublayer:border];
    self.navigationItem.title = self.navigationItemTitle;
    self.navigationController.navigationBar.topItem.title = @""; // delete back
    
    self.navigationController.view.backgroundColor = [UIColor lightGrayColor];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (SEARCH_RESULT_TABLE_VIEW) ? [self.searchResults count] : [self.stations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseIdentifier];
    
    NSDictionary *station = (SEARCH_RESULT_TABLE_VIEW) ? [self.searchResults objectAtIndex:indexPath.row] : [self.stations objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [[station objectForKey:kStationNameRU] capitalizedString];
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow-orange"]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *station = (SEARCH_RESULT_TABLE_VIEW) ? [self.searchResults objectAtIndex:indexPath.row] : [self.stations objectAtIndex:indexPath.row];
    [self.delegate setStationName:[[station objectForKey:kStationNameRU] capitalizedString] andCode:[station objectForKey:kStationCode]];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IOS8_AND_LETER) {
        cell.preservesSuperviewLayoutMargins = NO;
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    // iOS 7 and later
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        [cell setSeparatorInset:UIEdgeInsetsZero];
}

#pragma mark - UISearchDisplayDelegate

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    return YES;
}

#pragma mark - Private methods

- (void)initializeTable
{
    self.stations = [[NSArray alloc] init];
    self.stations = [NSArray stationsArray];
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    /*
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];
     self.searchResults = [self.stations filteredArrayUsingPredicate:predicate];
     */
    
    /*
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        NSString *stationName = [evaluatedObject objectForKey:kStationNameRU];
        if([stationName rangeOfString:searchText].location != NSNotFound) {
            return YES;
        }
        return NO;
    }];
    self.searchResults = [self.stations filteredArrayUsingPredicate:predicate];
     */
    
    for (NSDictionary *station in self.stations) {
        NSRange textRange = [[station objectForKey:kStationNameRU] rangeOfString:searchText options:NSCaseInsensitiveSearch];
        if (textRange.location != NSNotFound) {
            [self.searchResults addObject:station];
        } else {
            [self.searchResults removeObjectIdenticalTo:station];
        }
    }
}

@end