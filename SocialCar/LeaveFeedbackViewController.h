//
//  LeaveFeedbackViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 20/07/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedRoutesAsPassenger.h"
#import "SharedRoutesAsDriver.h"
#import "Driver.h"
#import "CommonData.h"
#import "SharedProfileData.h"
#import "MyTools.h"
#import "RouteDetailsStatusViewController.h"
#import "RequestedTripsViewController.h"

#define COMPLETED @"COMPLETED"
#define REVIEWED @"REVIEWED"

@interface LeaveFeedbackViewController : UIViewController <UITextViewDelegate>
{
    SharedRoutesAsPassenger *sharedRoutesAsPassenger;
    SharedRoutesAsDriver *sharedRoutesAsDriver;
    SharedProfileData *sharedProfileData;
    
    CommonData *commonData;
    //When user taps a star change it with a black one
    UIImage *image_star_black;
    
    UIImage *image_star_empty;
    
    BOOL star1_isTapped;
    BOOL star2_isTapped;
    BOOL star3_isTapped;
    BOOL star4_isTapped;
    BOOL star5_isTapped;
    
    NSString *ratingValue;
    long start_timeInseconds;
    
    Lift *lift;
    Driver *driver;
    
    MyTools *myTools;
    
    UIActivityIndicatorView *indicatorView;
    
    int case_call_API;
}

@property (strong, nonatomic) IBOutlet UIImageView *image_driver;

@property (strong, nonatomic) IBOutlet UILabel *label_driver_name;

//@property (strong, nonatomic) IBOutlet UIStackView *stackview_stars;
@property (strong, nonatomic) IBOutlet UIView *view_stars;

@property (strong, nonatomic) IBOutlet UITextView *textView_leaveFeedback;

- (IBAction)btn_send_pressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *star_1;
@property (strong, nonatomic) IBOutlet UIImageView *star_2;
@property (strong, nonatomic) IBOutlet UIImageView *star_3;
@property (strong, nonatomic) IBOutlet UIImageView *star_4;
@property (strong, nonatomic) IBOutlet UIImageView *star_5;
- (IBAction)star1_tapped:(id)sender;
- (IBAction)star2_tapped:(id)sender;
- (IBAction)star3_tapped:(id)sender;
- (IBAction)star4_tapped:(id)sender;
- (IBAction)star5_tapped:(id)sender;
//- (IBAction)stackview_stars_tapped:(id)sender;
//- (IBAction)view_stars_tapped:(id)sender;

@property (strong,nonatomic) NSString *comingFromViewController;

@end
