//
//  SignUpViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 29/11/16.
//  Copyright © 2016 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SafariServices/SafariServices.h>


@interface SignUpViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *view_lineLeft;

@property (strong, nonatomic) IBOutlet UIView *view_lineRight;

@property (strong, nonatomic) IBOutlet UIView *view_social;

@property (strong, nonatomic) IBOutlet UIStackView *stackview_social;

@property (strong, nonatomic) IBOutlet UILabel *label_social;

@property (strong, nonatomic) IBOutlet UIStackView *stackView_facebook;

@property (strong, nonatomic) IBOutlet UIStackView *stackView_googlePlus;


- (IBAction)tap_Facebook:(id)sender;
- (IBAction)tap_GooglePlus:(id)sender;

@end

