//
//  PreStartController.m
//  TestAPIv4
//
//  Created by Dmitriy Demchenko on 04/19/15.
//  Copyright (c) 2015 Organization98. All rights reserved.
//

#import "PreStartController.h"

@interface PreStartController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewLogo;

@end

@implementation PreStartController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = MintColor;
}

// прячем navigationController в MainController
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Анимируем стандартными средствами UIKit
    [UIView animateWithDuration:1.f delay:0.2f options:0.f animations:^{
        // Перемещаем логотип с позиции SplashScreen на позицию в StartController
        CGRect frame = self.imageViewLogo.frame;
        frame.origin.y = (((CGRectGetHeight([UIScreen mainScreen].bounds) - 99.f) / 2) - 85.f) / 2;
        self.imageViewLogo.frame = frame;
    }
                     completion:^(BOOL completed)
    {
        // По окончанию анимации segue на StartController
        [self performSegueWithIdentifier:@"splash" sender:self];
    }];
}

@end