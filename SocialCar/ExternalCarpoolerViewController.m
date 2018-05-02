//
//  ExternalCarpoolerViewController.m
//  SocialCar
//
//  Created by Vittorio Tauro on 20/07/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "ExternalCarpoolerViewController.h"

@interface ExternalCarpoolerViewController () <UIWebViewDelegate, UIScrollViewDelegate>

@end

@implementation ExternalCarpoolerViewController
@synthesize extCarpoolerURL;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;

    NSMutableURLRequest * request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:extCarpoolerURL]];
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    
    [self.webView loadRequest:request];
    [self.webView setClipsToBounds:YES];
    [self.webView.scrollView setClipsToBounds:YES];
    [self.webView setScalesPageToFit:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    webView.scrollView.delegate = self;
    float inset = self.navigationController.navigationBar.bounds.size.height +
    [UIApplication sharedApplication].statusBarFrame.size.height;
    webView.scrollView.contentInset = UIEdgeInsetsMake(inset, 0.0, 0.0, 0.0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.contentOffset.y == 0 && !scrollView.zooming)
        [scrollView setContentOffset:CGPointMake(0.0, -(scrollView.contentInset.top))];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
