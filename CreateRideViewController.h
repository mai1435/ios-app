//
//  CreateRideViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH)on 26/07/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedProfileData.h"
#import "SharedDriverProfileData.h"
#import "SharedRoutesAsDriver.h"

#import "CommonData.h"
#import "Ride.h"
#import "Car.h"
#import "MyTools.h"
#import "HomePassengerViewController.h"

@interface CreateRideViewController : UIViewController <UITextFieldDelegate>

{
    CommonData *commonData;
    MyTools *myTools;
    
    //In case there are new rides, store values
    Ride *ride;
    
    UIActivityIndicatorView *indicatorView;
    
    SharedProfileData *sharedProfile;
    SharedDriverProfileData *sharedDriverPofile;
    SharedRoutesAsDriver *sharedRoutesAsDriver;
    
    NSArray *coordinates;
    //for the start of the trip
    UIDatePicker *datepicker;
    
    NSTimeInterval start_timeTimeInterval;
    //NSString *dateTimeForPicker;
   
}

@property (strong, nonatomic) IBOutlet UITextField *txtfield_trip_name;


@property (strong, nonatomic) IBOutlet UITextField *txtfield_date_time;

@property (strong, nonatomic) IBOutlet UILabel *label_driver_name;

@property (strong, nonatomic) IBOutlet UILabel *label_car_model;

@property (strong, nonatomic) IBOutlet UILabel *label_origin;

@property (strong, nonatomic) IBOutlet UILabel *label_destination;
@property (strong, nonatomic) IBOutlet UIStackView *stackview_line;
@property (strong, nonatomic) IBOutlet UILabel *label_line;

- (IBAction)btn_create_pressed:(id)sender;

@end
