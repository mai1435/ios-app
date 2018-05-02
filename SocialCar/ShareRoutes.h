//
//  ShareRoutes.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 23/06/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Steps.h"
#import "TripRetrieved.h"

@interface ShareRoutes : NSObject

//Trips as they come from Back-End
@property (nonatomic,strong) NSArray *tripsBE;
@property (nonatomic,strong) NSString *rertieveTripsInJSON;
@property (nonatomic,strong) NSString *origin_address;
@property (nonatomic,strong) NSString *origin_address_lat;
@property (nonatomic,strong) NSString *origin_address_lon;

@property (nonatomic,strong) NSString *destination_address;
@property (nonatomic,strong) NSString *destination_address_lat;
@property (nonatomic,strong) NSString *destination_address_lon;


//1 trip may have many steps
//@property (nonatomic,strong) NSMutableArray<Steps *>* steps;
@property (nonatomic,strong) NSMutableArray *steps;

//This is my NSMutuable array to store the trips with their steps
//@property (nonatomic,strong) NSMutableArray<Steps *>* steps;
@property (nonatomic,strong) NSMutableArray *tripSteps;
//Strore  NSMutableArray<TripsRetrieved *>* steps;
@property (nonatomic,strong) NSMutableArray *tripsAfter;

//@property (nonatomic,strong) NSMutableArray *duration_per_trip;
//@property (nonatomic,strong) NSMutableArray *price_per_trip;
//@property (nonatomic,strong) NSMutableArray *currency_per_trip;

//Selected trip form TableView
@property  NSInteger trip_selected;

//Selected step form TableView
@property  NSInteger step_selected;


//Lift id if there is
@property (nonatomic,strong) NSString *Lift_id;


//Ride id if there is


//Objects used for RoutViewController for GUI purposes
@property NSInteger invertAddresses_clicked;
@property (nonatomic,strong) NSString *starDateTimeTrip;
@property (nonatomic,strong) NSString *starTimeStampTrip;

@property (nonatomic,strong) NSMutableArray *feedbackArray;

//Identify from where it is comming; for GUI to show the appropriate segment in MyTripsViewController
@property (nonatomic,strong) NSString *comingFrom;

+(ShareRoutes *) sharedObject;

@end
