//
//  LiftRequestViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH)  on 29/09/17.
//  Copyright © 2017 CERTH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SafariServices/SafariServices.h>

#import "CommonData.h"
#import "MyTools.h"
#import "ParseObjects.h"
#import "SharedProfileData.h"
#import "SharedRoutesAsPassenger.h"
#import "SharedRoutesAsDriver.h"
#import "SharedLiftNotified.h"
#import "ShareRoutes.h"
#import "Feedback.h"
#import "MyTripsViewController.h"

#define CANCELLED @"CANCELLED"
#define ACTIVE @"ACTIVE"

@interface LiftRequestViewController : UIViewController
{
    CommonData *commonData;
    MyTools *myTools;
    UIActivityIndicatorView *indicatorView;
    
    ParseObjects *parseObjects;
    
    SharedProfileData *sharedProfile;
    SharedRoutesAsPassenger *sharedRoutesAsPassenger;
    SharedRoutesAsDriver *sharedRoutesAsDriver;
    SharedLiftNotified *sharedLiftNotified;
    ShareRoutes *sharedRoutes;

    
}

@property (strong, nonatomic) IBOutlet UIImageView *image_driver;
@property (strong, nonatomic) IBOutlet UILabel *label_driver_name;
@property (strong, nonatomic) IBOutlet UILabel *label_feedback;

@property (strong, nonatomic) IBOutlet UILabel *label_date_time;
@property (strong, nonatomic) IBOutlet UILabel *label_origin;
@property (strong, nonatomic) IBOutlet UILabel *label_destiantion;

@property (strong, nonatomic) IBOutlet UIButton *btn_message;

@property (strong, nonatomic) IBOutlet UIButton *btn_phone;

@property (strong, nonatomic) IBOutlet UIButton *btn_social_media;




- (IBAction)btn_accept_pressed:(id)sender;
- (IBAction)btn_decline_pressed:(id)sender;

- (IBAction)btn_facebook_pressed:(id)sender;
- (IBAction)btn_phone_pressed:(id)sender;
- (IBAction)btn_message_pressed:(id)sender;



@end
