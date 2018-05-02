//
//  RequestedTripsViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 22/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiftsTableViewCell.h"
#import "SharedRoutesAsPassenger.h"
#import "SharedRoutesAsDriver.h"

#import "Lift.h"
#import "Steps.h"
#import "RouteDetailsViewController.h"
#import "MyTripsNavigationController.h"


//[ 'PENDING', 'ACTIVE', 'REFUSED', 'CANCELLED', 'COMPLETED'
#define PENDING @"PENDING"
#define ACTIVE @"ACTIVE"
#define REFUSED @"REFUSED"
#define COMPLETED @"COMPLETED"
#define CANCELLED @"CANCELLED"


@interface RequestedTripsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
   // NSArray *tableData_tripStatus;
   // NSArray *tableData_tripInfo;
    NSArray *thumbnails_tripStatus;
    
    NSArray *feedback;
    
    NSMutableArray *lifts;
    NSMutableArray *steps;
    
    SharedRoutesAsPassenger *sharedRoutesAsPassenger;
    SharedRoutesAsDriver *sharedRoutesAsDriver;
    
    NSString *isComingFrom;
    
}
//Passenger or Driver
- (void)comingFrom:(NSString *)viewControllerStr;

@property (strong, nonatomic) IBOutlet UITableView *tableView_requestedTrips;

@end
