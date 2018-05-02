//
//  TrafficConditionsViewController.h
//  SocialCar
//
//  Created by  Kostas Kalogirou (CERTH) on 24/07/17.
//  Copyright © 2017  Kostas Kalogirou (CERTH) . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SharedProfileData.h"
#import "CommonData.h"
#import "MyTools.h"

@interface TrafficConditionsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,MKMapViewDelegate, CLLocationManagerDelegate>{
    SharedProfileData *sharedProfile;
    CommonData *commonData;
    NSArray *reportsArray;
    float lastLat;
    float lastLng;
    int case_call_API;
    __weak IBOutlet UITableView *tableView;
    
    UIActivityIndicatorView *indicatorView;
    
    MyTools *myTools;
}

@property (retain,nonatomic) CLLocationManager *locationManager;


@end
