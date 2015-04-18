//
//  WebViewController.h
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 02/04/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate/*, NSURLConnectionDelegate*/>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSURL *url;

@end
