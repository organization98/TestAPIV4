//
//  WebViewController.m
//  TestAPIv3
//
//  Created by Dmitriy Demchenko on 02/04/15.
//  Copyright (c) 2015 Dmitriy Demchenko. All rights reserved.
//

#import "WebViewController.h"
#import "NSURLRequest+IgnoreSSL.h"
#import "NSString+ContainsStrModernizer.h"

@interface WebViewController () 

@end

@implementation WebViewController
/*
{
    BOOL isDone;
    NSURLRequest *req;
    NSURLConnection *conn;
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSStringFromClass([WebViewController class]);
    // webView
    self.webView.delegate = self;
    self.webView.scalesPageToFit = NO;
    [self loadURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadURL {
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];
    [NSURLRequest allowsAnyHTTPSCertificateForHost:[self.url host]];
    /*
    req = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:req];
    */
}

#pragma mark - UIWebViewDelegate

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"URL: %@", [request URL].absoluteString);
    
    // containsString - iOS8 method!
    // iOS7 used NSString+ContainsStrModernizer category
    if ([[request URL].absoluteString containsString:@"index2.html"] == YES) {
        NSLog(@"TEST");
        [self.navigationController popViewControllerAnimated:YES];
        return YES;
        
    } else if ([[request URL].absoluteString containsString:@"bad.html"] == YES) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"Error payment"
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return YES;
}

/*
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (!isDone) {
        isDone = NO;
        conn = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
        [conn start];
        return NO;
    }
    return YES;
    
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge previousFailureCount] == 0) {
        isDone = YES;
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    isDone = YES;
    [self.webView loadRequest:req];
    [conn cancel];
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqual:NSURLAuthenticationMethodServerTrust];
}
*/

@end
