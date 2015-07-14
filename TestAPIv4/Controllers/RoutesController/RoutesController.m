//
//  RoutesController.m
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 01/26/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "RoutesController.h"
#import "RoutesCustomCell.h"
#import "SchemeController.h"
#import "StartController.h"

@implementation RoutesController
{
    NSArray *routesArray;
    NSDictionary *route;
    NSDictionary *placesDict;
    PricesManager *pricesManager;
}

#pragma mark - Life cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        placesDict = [[NSDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addRightBarButtonItems];
    
    self.tableView.backgroundColor = DesertStormColor;
    
    CALayer *border = [CALayer layer];
    border.borderColor = MintColor.CGColor;
    border.borderWidth = 1.f;
    CALayer *layer = self.navigationController.navigationBar.layer;
    border.frame = CGRectMake(0.f, layer.bounds.size.height, layer.bounds.size.width, 1.f);
    [layer addSublayer:border];
//    self.navigationItem.title = self.navigationItemTitle;
    self.navigationController.navigationBar.topItem.title = self.navigationItemTitle; // delete back
    
    pricesManager = [[PricesManager alloc] init];
    
    // ActivityView
    [self.tableView setHidden:YES];
    UIView *viewToUse = self.view;
    self.view.backgroundColor = HintOfRedColor;
    [DejalActivityView activityViewForView:viewToUse];
    
    [[SessionManager sharedManager] open:^(BOOL succes, id data, NSError *error) {
        if (!succes)
            return;
        [self removeActivityView];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showScheme"]) {
        SchemeController *controller = (SchemeController *)segue.destinationViewController;
        controller.wagonType = @"П";
        controller.placesDict = @{@"01" : @"free",
                                  @"01" : @"free",};
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [routesArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RoutesCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:[RoutesCustomCell reuseIdentifier]];
    if (!cell) {
        cell = [RoutesCustomCell initializeCell];
    }
    route = [routesArray objectAtIndex:indexPath.section];
    [cell configForItem:route];
    return cell;
}

#pragma mark - UITableViewDelegate
#warning Перенести в RoutesCustomCell в метод configForItem
- (void)tableView:(UITableView *)tableView willDisplayCell:(RoutesCustomCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = DesertStormColor;
    cell.clockImage.image = [UIImage imageNamed:@"time"];
    
    // блок маршрут
    cell.labelNumber.text = [route objectForKey:@"number"];
    cell.labelRouteTitle.text = [[NSString stringWithFormat:@"%@ - %@", [route objectForKey:@"station_from"], [route objectForKey:@"station_to"]] capitalizedString];
    
    // блок время (косяк!)
    cell.labelDepartureDate.text = [NSString dateFromString:[route objectForKey:@"departure_date"]];
    cell.labelArrivalDate.text = [NSString dateFromString:[route objectForKey:@"arrival_date"]];
    cell.labelTravelTime.text = [NSString travelTimeFromString:[route objectForKey:@"travel_time"]];
    
    // блок цена
    cell.labelCost.text = nil;
    
    // блок тип вагона
    cell.labelWagonType.text = [[NSDictionary wagonTypesDictionary] objectForKey:[route objectForKey:@"wagon_type"]];
    
    // блок места
    cell.labelCountPlaces.text = [route objectForKey:@"count"];
    
    // --------------------------------------------------------------------------------------
    self.number = [route objectForKey:@"number"];
    self.wagonNumber = [route objectForKey:@"wagon_number"];
    self.wagonType = [route objectForKey:@"wagon_type"];
//    self.placesDict = [route objectForKey:@""]
//    NSLog(@"Поезд %@, Вагон %@, Тип вагона %@", [route objectForKey:@"number"], [route objectForKey:@"wagon_number"], [route objectForKey:@"wagon_type"]);
    // --------------------------------------------------------------------------------------
    
    cell.trainNumber = [route objectForKey:@"number"];
    cell.wagonType = [route objectForKey:@"wagon_type"];
    
    [[NSNotificationCenter defaultCenter] addObserver:cell selector:@selector(updatePrice:) name:cell.labelNumber.text object:pricesManager];
    
    if([pricesManager getPrice:cell.trainNumber from:cell]) {
        NSDictionary *prices = [pricesManager getPrice:cell.trainNumber from:cell];
        [cell addPriceToLabel:prices];
    }
}

#pragma mark - Private methods

// Показать таблицу, убрать загрузчик. Выполняет транзакцию получения рейсов
- (void)removeActivityView
{
    [[SessionManager sharedManager] getRoutes:self.stationFrom to:self.stationTo forStartDate:self.startDate and:^(BOOL succes, id data, NSError *error) {
        if (!data)
            return;
        routesArray = [[self dictionaryFromJSON:data with:error] objectForKey:@"items"];
        
        [self.tableView reloadData];
        [DejalActivityView removeView];
        [self.tableView setHidden:NO];
    }];
}

- (NSDictionary *)dictionaryFromJSON:(NSData *)data with:(NSError *)error
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
}

- (void)addRightBarButtonItems
{
    UIBarButtonItem *buttonSearch = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    
    UIBarButtonItem *buttonFilter = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"filter"] style:UIBarButtonItemStylePlain target:self action:@selector(filterAction)];
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:buttonSearch, buttonFilter ,nil]];
}

- (void)searchAction
{
    NSLog(@"Search called");
}

- (void)filterAction
{
    NSLog(@"Search called");
}

@end