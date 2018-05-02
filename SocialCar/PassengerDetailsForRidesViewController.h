//
//  PassengerDetailsForRidesViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH)  on 26/09/17.
//  Copyright © 2017 CERTH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedRoutesAsDriver.h"
#import "SharedRoutesAsPassenger.h"
#import "Feedback.h"
#import "MyTools.h"
#import "Ride.h"
#import "DriverFeedback.h"


@interface PassengerDetailsForRidesViewController : UIViewController
{
    SharedRoutesAsDriver *sharedRoutesAsDriver;
    SharedRoutesAsPassenger *sharedRoutesAsPassenger;
    
    //Lift *lift;
    MyTools *myTools;
    
    NSMutableArray *rides;
}

@property (strong, nonatomic) IBOutlet UIImageView *image_picture;
@property (strong, nonatomic) IBOutlet UILabel *label_passenger_name;
@property (strong, nonatomic) IBOutlet UILabel *label_feedback_rating;
@property (strong, nonatomic) IBOutlet UITableView *table_feedback;

@end
