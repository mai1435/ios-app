//
//  Steps.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 24/06/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IntermediatePoint.h"

@interface Steps : NSObject
{
//    UIImage *transport_image;
}

@property int distance_step;
@property (nonatomic,strong) NSString *duration_step;

//Start step address
@property (nonatomic,strong) NSString *start_address;
@property (nonatomic,strong) NSString *start_address_date;

@property (nonatomic,strong) NSString *start_address_lat;
@property (nonatomic,strong) NSString *start_address_lon;

//End step address
@property (nonatomic,strong) NSString *end_address;
@property (nonatomic,strong) NSString *end_address_date;
@property (nonatomic,strong) NSString *end_address_lat;
@property (nonatomic,strong) NSString *end_address_lon;

//Price
@property double amount;
@property (nonatomic,strong) NSString *currency;

//Transport
@property (nonatomic,strong) NSString *transport_long_name;
@property (nonatomic,strong) NSString *transport_short_name;
@property (nonatomic,strong) NSString *travel_mode;
@property (nonatomic,strong) UIImage *transport_image;

@property BOOL has_CAR_POOLING;
@property (nonatomic,strong) NSString *ride_id;

@property BOOL has_CAR_POOLING_EXTERNAL;
@property (nonatomic,strong) NSString *public_uri;

//A step may have more than one car poolings => more thanone drivers
@property NSMutableArray *cars;
@property NSMutableArray *driver;
//@property NSMutableArray<IntermediatePoint> *intermediate_pooints;
@property NSMutableArray *intermediate_points;

//Start Time
@property int start_hour;
@property int start_min;

//End Time
@property int end_hour;
@property int end_min;


@end
