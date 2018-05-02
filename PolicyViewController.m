//
//  PolicyViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou on 02/08/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import "PolicyViewController.h"

@interface PolicyViewController ()

@end

@implementation PolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.navigationController.navigationBar.translucent = NO;
    
    NSMutableURLRequest * request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL_PRIVACY_POLICY]];
    
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    
    [self.webView loadRequest:request];
    
    /*[self.webView setClipsToBounds:YES];
    [self.webView.scrollView setClipsToBounds:YES];
    [self.webView setScalesPageToFit:YES];
    */
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
