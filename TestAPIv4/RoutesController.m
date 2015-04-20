//
//  RoutesController.m
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 01/26/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "RoutesController.h"
#import "RoutesCustomCell.h"
#import "SessionManager.h"
#import "PricesManager.h"
#import "DejalActivityView.h"
#import "SchemeController.h"
#import "NSString+NSDateFormatter.h"
#import "Constants.h"

#import "StartController.h"

@interface RoutesController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation RoutesController {
    NSArray *routesArray;
    NSDictionary *route;
    NSDictionary *placesDict;
    PricesManager *pricesManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        placesDict = [[NSDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.navigationItem.title = NSStringFromClass([RoutesController class]);
    
    pricesManager = [[PricesManager alloc] init];
    
    // ActivityView
    [self.tableView setHidden:YES];
    UIView *viewToUse = self.view;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [DejalActivityView activityViewForView:viewToUse];
    
    [[SessionManager sharedManager] open:^(BOOL succes, id data, NSError *error) {
        if (succes == NO) {
            return;
        }
        [self removeActivityView];
    }];
}

// Показать таблицу, убрать загрузчик. Выполняет транзакцию получения рейсов
- (void)removeActivityView {
    [[SessionManager sharedManager] getRoutes:self.stationFrom to:self.stationTo forStartDate:self.startDate and:^(BOOL succes, id data, NSError *error) {
        if (!data)
            return;
        routesArray = [[self dictionaryFromJSON:data with:error] objectForKey:@"items"];
        NSLog(@"%@", routesArray);
        
        [self.tableView reloadData];
        [DejalActivityView removeView];
        [self.tableView setHidden:NO];
    }];
}

// передаем параметры в SchemeController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showScheme"]) {
        SchemeController *controller = (SchemeController *)segue.destinationViewController;
        controller.wagonType = @"П";
        controller.placesDict = @{@"01" : @"free",
                                  @"01" : @"free",};
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary *)dictionaryFromJSON:(NSData *)data with:(NSError *)error {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
}

#pragma mark - UITableViewDataSource
// задаем кол-во секций
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [routesArray count];
}

// сколько рядов в секции под индексом section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

// задаем ячеку для строки с индексом
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RoutesCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"RoutesCustomCell" bundle:nil] forCellReuseIdentifier:@"myCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    }
    route = [routesArray objectAtIndex:indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(RoutesCustomCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WagonTypes" ofType:@"plist"];
    NSDictionary *wagonTypesDict = [[NSDictionary alloc] initWithContentsOfFile:path];
    cell.labelWagonType.text = [wagonTypesDict objectForKey:[route objectForKey:@"wagon_type"]];
    
    // блок места
    cell.labelCountPlaces.text = [route objectForKey:@"count"];
    
    // --------------------------------------------------------------------------------------
    self.number = [route objectForKey:@"number"];
    self.wagonNumber = [route objectForKey:@"wagon_number"];
    self.wagonType = [route objectForKey:@"wagon_type"];
//    self.placesDict = [route objectForKey:@""]
    NSLog(@"Поезд %@, Вагон %@, Тип вагона %@", [route objectForKey:@"number"], [route objectForKey:@"wagon_number"], [route objectForKey:@"wagon_type"]);
    // --------------------------------------------------------------------------------------
    
    cell.trainNumber = [route objectForKey:@"number"];
    cell.wagonType = [route objectForKey:@"wagon_type"];
    
    [[NSNotificationCenter defaultCenter] addObserver:cell selector:@selector(updatePrice:) name:cell.labelNumber.text object:pricesManager];
    
    if([pricesManager getPrice:cell.trainNumber from:cell]) {
        NSDictionary *prices = [pricesManager getPrice:cell.trainNumber from:cell];
        [cell addPriceToLabel:prices];
    }
}

@end