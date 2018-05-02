//
//  DriverDetailsViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou(CERTH) on 11/04/17.
//  Copyright © 2017 Kostas Kalogirou(CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SafariServices/SafariServices.h>
#import "ShareRoutes.h"
#import "SharedRoutesAsPassenger.h"
#import "SharedRoutesAsDriver.h"

#import "Driver.h"
#import "Car.h"
#import "DriverFeedback.h"
#import "Feedback.h"
//#import "SharedProfileData.h"
#import "MyTools.h"


#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface DriverDetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,NSURLSessionDataDelegate>
{
    ShareRoutes *sharedRoutes;
    
    SharedRoutesAsPassenger *sharedRoutesAsPassenger;
    SharedRoutesAsDriver *sharedRoutesAsDriver;
    //Get the steps from the selected trip(route)
    //NSMutableArray *stepsMArray;
    Driver *driver;
    Car *car;
    
    MyTools *myTools;
    
    NSString *viewControllerComesFrom;
}


@property (strong, nonatomic) IBOutlet UIImageView *image_photo;

@property (strong, nonatomic) IBOutlet UIButton *btn_facebook;

@property (strong, nonatomic) IBOutlet UIButton *btn_phone;

@property (strong, nonatomic) IBOutlet UIButton *btn_message;

@property (strong, nonatomic) IBOutlet UILabel *label_name;
@property (strong, nonatomic) IBOutlet UILabel *label_feedback;


@property (strong, nonatomic) IBOutlet UILabel *label_model;
@property (strong, nonatomic) IBOutlet UILabel *label_plate;
@property (strong, nonatomic) IBOutlet UIButton *btn_colour;
@property (strong, nonatomic) IBOutlet UILabel *label_seats;

//-(UIColor *) colourFromHexValue: (float) rgbValue;
@property (strong, nonatomic) IBOutlet UITableView *table_driver_feedback;


- (IBAction)btn_facebook_pressed:(id)sender;

- (IBAction)btn_phone_pressed:(id)sender;

- (IBAction)btn_message_pressed:(id)sender;

- (void) comingFrom:(NSString *)viewControllerString;

@end
