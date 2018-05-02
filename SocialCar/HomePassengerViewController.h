//
//  HomePassengerViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 23/01/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "SharedProfileData.h"
#import "ShareRoutes.h"
#import "SharedRoutesAsDriver.h"
#import "SharedRoutesAsPassenger.h"
#import "CommonData.h"
#import "MyTools.h"
#import "Ride.h"
#import "CreateRideViewController.h"

@interface HomePassengerViewController : UIViewController <UITextFieldDelegate,MKMapViewDelegate, CLLocationManagerDelegate,NSURLSessionDataDelegate>
{
    UIActivityIndicatorView *indicatorView;
    
    MyTools *myTools;
    
    SharedProfileData *sharedProfile;
    ShareRoutes *sharedRoutes;
    SharedRoutesAsDriver *sharedRoutesAsDriver;
	SharedRoutesAsPassenger *sharedRoutesAsPassenger;

    CommonData *commonData;
    
    NSURLSessionConfiguration *sessionConfiguration;
    
    int case_call_API; //1 = Authenticat euser, 2 = Find user
    
    //In case there are new rides, store values
    Ride *ride;
 
}
//@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (retain,nonatomic) CLLocationManager *locationManager;


@property (strong, nonatomic) IBOutlet UILabel *label_passenger;
@property (strong, nonatomic) IBOutlet UILabel *label_driver;
@property (strong, nonatomic) IBOutlet UITextField *txtfield_startAddress;
@property (strong, nonatomic) IBOutlet UITextField *txtfield_setDestinationAddress;
@property (strong, nonatomic) NSMutableArray<UITextField*>*txtfield_waypoints_array;


@property (strong, nonatomic) IBOutlet UIButton *btn_address;
@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) MKPolyline *routeLineG; //your line
@property (nonatomic, retain) MKPolylineView *routeLineViewG; //overlay view

@property (strong, nonatomic) IBOutlet UIStackView *stackView_setAddresses;

//- (IBAction)segmentChanged:(id)sender;
- (IBAction)btn_setAddress:(id)sender;
//- (IBAction)start:(id)sender;

- (IBAction)btn_current_location:(id)sender;

//My function;fro reverse geocoding
-(void) reverseGeocoding:(CLLocation *)crnLoc;

@property MKMapItem *mapItem;


@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnItem_right;

- (IBAction)btnItem_right_pressed:(id)sender;


/*@property (strong, nonatomic) IBOutlet UIBarButtonItem *nextBarBtnItem;

- (IBAction)nextItem_pressed:(id)sender;
*/

@property int addressStatus; //0 origin, 1 destination
//@property NSMutableArray<MKAnnotationView *> *annotationViews;
@property NSMutableArray *annotationViews;
@property MKPlacemark *annotationViewStart;
@property MKPlacemark *annotationViewStop;

@property NSMutableArray *annotationViewsWaypoints;

//@property NSArray *mapItems; //cehck:to be deleted


//@property BOOL mapItemsContainUserLocation; //check:to be deleted
@property BOOL special_case; //check to be deleted
@property NSString *txtfield_startAddress_previous_text;

//Used to identify the previous ViewContoller
@property NSString *previousViewController;


//@property (nonatomic, strong) id<MKAnnotation> lastAnnotationAdded;
//- (id)initWithName:(NSString *)comingFromViewController;
- (void)comingFrom:(NSString *)viewControllerStr;


//-(NSArray *)coordinatesFromAddress : (NSString *) addressText;

@end

