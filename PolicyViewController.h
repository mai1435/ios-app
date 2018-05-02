//
//  PolicyViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou on 02/08/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolicyViewController : UIViewController <UIWebViewDelegate, UIScrollViewDelegate>

#define URL_PRIVACY_POLICY @"*"

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
