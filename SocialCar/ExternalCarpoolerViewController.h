//
//  ExternalCarpoolerViewController.h
//  SocialCar
//
//  Created by Vittorio Tauro on 20/07/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ExternalCarpoolerViewController : UIViewController

@property (nonatomic,retain) NSString* extCarpoolerURL;
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end
