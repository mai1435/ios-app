//
//  Ride.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH)on 24/07/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lift.h"
#import <MapKit/MapKit.h>

@interface Ride : NSObject

@property (nonatomic,strong) NSString *_id; //
@property (nonatomic,strong) NSString *driver_id;//
@property (nonatomic,strong) NSString *car_id; //
@property (nonatomic,strong) NSString *name;//
@property (nonatomic,strong) NSString *polyline;//
@property (nonatomic,strong) NSString *activated;//

//Start ride address
@property (nonatomic,strong) NSString *start_point_lat;
@property (nonatomic,strong) NSString *start_point_lon;

@property (nonatomic,strong) NSString *ride_date;

//End ride address
@property (nonatomic,strong) NSString *end_point_lat;
@property (nonatomic,strong) NSString *end_point_lon;

@property (nonatomic,strong) NSString *origin_address;
@property (nonatomic,strong) NSString *destination_address;

//A ride may have many lifts
@property (nonatomic,strong) NSMutableArray *lifts;

@property (nonatomic,strong) NSArray *coordinates; //coordinates for origin and destination

@property int lift_selected;
@property MKMapView *mapView;
//@property (nonatomic,strong) Lift *lift;


@end
