//
//  ViewControllerRouteDetails.h
//  TableViewSocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 22/02/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RouteDetailsTableViewCell.h"

#import "SharedProfileData.h"
#import "ShareRoutes.h"
#import "SharedRoutesAsPassenger.h"

#import "MyTripsNavigationController.h"
#import "MyTripsViewController.h"
#import "MenuTabBarController.h"
#import "ExternalCarpoolerViewController.h"

#import "CommonData.h"
#import "MyTools.h"
#import "Driver.h"
#import "Car.h"
#import "MyTools.h"
#import "ParseObjects.h"


@interface RouteDetailsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSURLSessionDataDelegate>
{
  
    SharedProfileData *sharedProfile;
    
    ShareRoutes *sharedRoutes;
    
    SharedRoutesAsPassenger *sharedRoutesAsPassenger;
    //Create lift object with its id after successful request
    Lift *lift;
    Driver *driver;
    
    //Get the steps from the selected trip(route)
    NSMutableArray *stepsMArray;
    
    MyTools *myTools;
    
    NSURLSessionConfiguration *sessionConfiguration;
    
    NSString *parametersRequest;
   // int case_call_API;
    CommonData *commonData;
    ParseObjects *parseObjects;
    
    UIActivityIndicatorView *indicatorView;
    
}

@property (strong, nonatomic) IBOutlet UITableView *tableViewRouteDetails;
@property (strong, nonatomic) IBOutlet UILabel *label_duration;
@property (strong, nonatomic) IBOutlet UILabel *label_price;
@property (strong, nonatomic) IBOutlet UILabel *label_origin;
@property (strong, nonatomic) IBOutlet UILabel *label_destination;

@property (strong, nonatomic) IBOutlet UIButton *btn_sendRequest;

- (IBAction)btn_sendRequest:(id)sender;

@end
