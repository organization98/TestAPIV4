//
//  SessionManager.m
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 01/26/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "SessionManager.h"
#import "AFNetworking.h"

@interface SessionManager ()

@end

@implementation SessionManager {
    NSString *username;
    NSString *password;
    NSString *session;
    NSString *domain;
    
    NSDictionary *dict;
}

+ (SessionManager *)sharedManager {
    static SessionManager *manager = nil;
    static dispatch_once_t onceTaken;
    dispatch_once (&onceTaken, ^{
        manager = [[SessionManager alloc] init];
    });    
    return manager;
}

- (id)init {
    self = [super init];
    if (self) {
        username = @"demo";
        password = @"demo";
        domain = @"http://booking.ibp.org.ua/api";
    }
    return self;
}

- (void)requestFromURL:(NSURL *)url completion:(NetworkBlock)block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url.absoluteString parameters:nil success:
     ^(AFHTTPRequestOperation *operation, id responseObject) {
         // проверка RESULT
         if ([[responseObject objectForKey:@"result"] isEqual:@"OK"]) {
             block (YES, responseObject, nil);
         } else if ([[responseObject objectForKey:@"result"] isEqual:@"ERROR"]) {
             NSDictionary *errorDict = @{@"message" : [responseObject objectForKey:@"message"]};
             NSError *error = [NSError errorWithDomain:@"booking.ibp.org.ua" code:(NSInteger)[responseObject objectForKey:@"code"] userInfo:errorDict];
             block (NO, responseObject, error);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@", operation);
     }];
}

- (void)open:(NetworkBlock)block {
    if (session.length >  0){
        block (YES, nil, nil);
        return;
    }
    // Выполнить транзакцию авторизации, сохраниить сессию
    NSURL *urlOffLine = [NSURL URLWithString:[NSString stringWithFormat:@"%@/auth?username=%@&password=%@&mode=offline", domain, username, password]];
    NSURL *urlOnLine = [NSURL URLWithString:[NSString stringWithFormat:@"%@/auth?username=%@&password=%@", domain, username, password]];
    [self requestFromURL: urlOnLine completion:^(BOOL succes, id data, NSError *error) {
        if ([[data objectForKey:@"result"] isEqual:@"OK"]) {
            session = [data objectForKey:@"session"];
            block (succes, data, error);
        }
        NSLog(@"\nавторизация\nresult: %@\nsession: %@\n\n", [data objectForKey:@"result"], session);
    }];
    return;
}

- (void)getRoutes:(NSString *)stationFrom to:(NSString *)stationTo forStartDate:(NSString *)date and:(NetworkBlock)block {
    // выполнение транзакции "trains"
    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/trains?from=%@&to=%@&startDate=%@&session=%@", domain, stationFrom, stationTo, date, session]];
    [self requestFromURL:requestURL completion:^(BOOL succes, id data, NSError *error) {
        if (succes == NO) {
            NSLog(@"%@", [[error userInfo] objectForKey:@"message"]);
        } else {
            block (succes, data, error);
        }
    }];
}

// перенести в категорию
- (NSDictionary *)dictionaryFromJSON:(NSData *)data with:(NSError *)error {
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
}

- (void)getPrices:(NSString *)train withType:(NSString *)type andClass:(NSString *)cls and:(NetworkBlock)block {
    NSString *requestURL = [NSString stringWithFormat:@"%@/prices?train=%@&session=%@", domain, train, session];
    NSURL *url = [NSURL URLWithString:[requestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [self requestFromURL:url completion:^(BOOL succes, id data, NSError *error) {
        if (succes == NO) {
            NSLog(@"%@", [[error userInfo] objectForKey:@"message"]);
        } else {
            block (succes, data, error);
        }
    }];
}

- (NSDictionary *)getPlaces:(NSString *)train withType:(NSString *)type andClass:(NSString *)cls {
    return [NSDictionary new];
}

@end