//
//  RidesViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou on 27/07/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
#import "RideTableViewCell.h"
#import "SharedRoutesAsDriver.h"
#import "SharedProfileData.h"
#import "SharedRoutesAsPassenger.h"

#import "Ride.h"
#import "MyTools.h"

#import "CommonData.h"
#import "DriverDetailsViewController.h"
#import "Lift.h"
#import "PassengerDetailsViewController.h"
#import "RidesMapDetailViewController.h"

@interface RidesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,MKMapViewDelegate>

{
    SharedRoutesAsDriver *sharedRoutesAsDriver;
    SharedRoutesAsPassenger *sharedRoutesAsPassenger;
    SharedProfileData *sharedProfile;
    
    MyTools *myTools;
    CommonData *commonData;
    Lift *lift;
    
    NSMutableArray *rides;
    
    NSMutableArray *getStatus_btn_more_detailsClicked;
    
    UIActivityIndicatorView *indicatorView;
    
    Ride *ride;
    
    int which_btn_pressed;
    
  
    
  //  NSMutableArray <MKMapView *>* cell_mapViews;
   
  
}

//@property (retain, nonatomic) IBOutlet MKMapView *cell_mapView;

@property (strong, nonatomic) IBOutlet UITableView *tabelView;


@property (strong, nonatomic) IBOutlet UIButton *btn_add_new_trip;

- (IBAction)btn_addTrip_pressed:(id)sender;



@end
