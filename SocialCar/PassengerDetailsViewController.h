//
//  PassengerDetailsViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH)  on 25/09/17.
//  Copyright © 2017 CERTH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedRoutesAsDriver.h"
#import "Feedback.h"
#import "MyTools.h"
#import "Lift.h"
#import "DriverFeedback.h"


@interface PassengerDetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    SharedRoutesAsDriver *sharedRoutesAsDriver;
    //Lift *lift;
    MyTools *myTools;
}


@property (strong, nonatomic) IBOutlet UILabel *label_passenger_name;

@property (strong, nonatomic) IBOutlet UILabel *label_feedback_rating
;

@property (strong, nonatomic) IBOutlet UIImageView *image_passenger;

@property (strong, nonatomic) IBOutlet UILabel *label_date;

@property (strong, nonatomic) IBOutlet UILabel *label_line_A;
@property (strong, nonatomic) IBOutlet UILabel *label_origin_point;
@property (strong, nonatomic) IBOutlet UILabel *label_line_B;
@property (strong, nonatomic) IBOutlet UILabel *label_destination_point;
@property (strong, nonatomic) IBOutlet UITableView *table_feedback_passenger;


@property (strong,nonatomic) NSString *comingFromViewController;
@end
