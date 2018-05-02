//
//  RouteDetailsStatusViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 21/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RouteDetailsTableViewCell.h"
#import "ShareRoutes.h"
#import "SharedRoutesAsPassenger.h"
#import "SharedRoutesAsDriver.h"
#import "LeaveFeedbackViewController.h"
#import "LocationTracker.h"

#import "CommonData.h"
#import "Driver.h"
#import "Feedback.h"
#import "SharedProfileData.h"
#import "MyTools.h"
//#import "Passenger.h"
//'PENDING', 'ACTIVE', 'REFUSED', 'CANCELLED', 'COMPLETED' 
#define COMPLETED @"COMPLETED"
#define REVIEWED @"REVIEWED"
#define CANCELLED @"CANCELLED"
#define PENDING @"PENDING"
#define ACTIVE @"ACTIVE"
#define REFUSED @"REFUSED"

@interface RouteDetailsStatusViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>//,NSURLSessionDataDelegate>
{
//    NSArray *tableData;
//    NSArray *thumbnails;
   
    ShareRoutes *sharedRoutes;
    SharedRoutesAsPassenger *sharedRoutesAsPassenger;
    SharedRoutesAsDriver *sharedRoutesAsDriver;
   // Passenger *passenger;
    
    //Get the steps from the selected trip(route)
    NSMutableArray *stepsMArray;
    CommonData *commonData;
  //?  Feedback *feedbackData;
    Lift *lift;
    Steps *step;
    
 //?   NSMutableArray *feedbackArray;
    
    NSURLSessionConfiguration *sessionConfiguration;
   // int case_call_API;
    UIActivityIndicatorView *indicatorView;
    
    int getRowContainsCAR_POOLING;
    
    SharedProfileData *sharedProfile;
    MyTools *myTools;
    Driver *driver;

    NSString *comingFromViewController;
    
    BOOL pressed_rating_Banner;
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableViewRouteDetails;
@property (strong, nonatomic) IBOutlet UILabel *label_duration;
@property (strong, nonatomic) IBOutlet UILabel *label_price;
@property (strong, nonatomic) IBOutlet UILabel *label_status;
@property (strong, nonatomic) IBOutlet UILabel *label_driver_status;
@property (strong, nonatomic) IBOutlet UIImageView *image_pending;
@property (strong, nonatomic) IBOutlet UIButton *btn_cancel;
@property (strong, nonatomic) IBOutlet UIButton* btnSendPosition;

@property LocationTracker * locationTracker;

@property (strong, nonatomic) IBOutlet UILabel *label_origin;
@property (strong, nonatomic) IBOutlet UILabel *label_destination;

//@property (strong, nonatomic) IBOutlet UIStackView *stackView_status;
//@property (strong, nonatomic) IBOutlet UIView *view_status;

@property (strong, nonatomic) IBOutlet UIStackView *stackView_ratingBanner;

@property (strong, nonatomic) IBOutlet UIView *view_ratingBanner;
//@property (strong, nonatomic) IBOutlet UIStackView *stackView_table;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view_status_height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *view_ratingBanner_height;

@property (strong, nonatomic) IBOutlet UILabel *label_experience;
//@property (strong, nonatomic) IBOutlet UIStackView *stackView_All;

//@property (strong, nonatomic) IBOutlet UIButton *btn_cancel_pending;
- (IBAction)btn_cancel_pending:(id)sender;

- (IBAction)ratingBanner_touched:(id)sender;
- (IBAction)btnSendPressed:(id)sender;


-(void)comingFrom:(NSString *)viewControllerStr;



@end
