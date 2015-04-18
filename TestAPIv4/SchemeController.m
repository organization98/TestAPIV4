//
//  SchemeController.m
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 01/30/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "SchemeController.h"
#import "Constants.h"
#import "WebViewController.h"
#import "SchemeType40.h"

@interface SchemeController ()

@end

@implementation SchemeController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = NSStringFromClass([SchemeController class]);
    
    // внешний вид кнопок "корзины", "купить"
    for (UIButton *buttons in self.buttonStyle) {
        buttons.backgroundColor = SorbusColor;
        buttons.tintColor = WhiteColor;
        buttons.layer.cornerRadius = 5;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scrollView.contentSize = CGSizeMake(1043, 211);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    NSLog(@"Width: %.f px, Height: %.f px", self.scrollView.contentSize.width, self.scrollView.contentSize.height);
}

// передаем параметры в WebViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showWebView"]) {
        WebViewController *controller = (WebViewController *)segue.destinationViewController;
        
        // Test URLs
        NSString *testURL = @"http://api.ibp.org.ua/";
        NSString *plategkaURL = @"http://booking.ibp.org.ua/payment/pay?price=14560&description=Hello!/";
        
        controller.url = [NSURL URLWithString:testURL];
    }
}

@end