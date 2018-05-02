//
//  Lift.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 03/07/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Lift : NSObject

@property (nonatomic,strong) NSString *_id;
@property (nonatomic,strong) NSString *ride_id;
@property (nonatomic,strong) NSString *passenger_id;
@property (nonatomic,strong) NSString *driver_id;
@property (nonatomic,strong) NSString *car_id;

//Start step address
@property (nonatomic,strong) NSString *start_address;
@property (nonatomic,strong) NSString *start_address_lat;
@property (nonatomic,strong) NSString *start_address_lon;
@property (nonatomic,strong) NSString *start_address_date;

//End step address
@property (nonatomic,strong) NSString *end_address;
@property (nonatomic,strong) NSString *end_address_lat;
@property (nonatomic,strong) NSString *end_address_lon;
@property (nonatomic,strong) NSString *end_address_date;

@property (nonatomic,strong) NSString *status;

//For rides
@property (nonatomic,strong) NSString *passenger_image;

//For passenger
@property (nonatomic,strong) UIImage *passenger_picture;
@property (nonatomic,strong) NSString *passenger_name;
@property (nonatomic,strong) NSString *passenger_rating;
@property (nonatomic,strong) NSString *passenger_phone;
@property BOOL passenger_hasGoogleAccount;
@property BOOL passenger_hasFacebookAccount;
@property (nonatomic,strong) NSString *passenger_social_media_id;


//For driver
@property (nonatomic,strong) NSString *driver_image;

//For passenger
@property (nonatomic,strong) UIImage *driver_picture;
@property (nonatomic,strong) NSString *driver_name;
@property (nonatomic,strong) NSString *driver_rating;
@property (nonatomic,strong) NSString *driver_phone;
@property BOOL driver_hasGoogleAccount;
@property BOOL driver_hasFacebookAccount;
@property (nonatomic,strong) NSString *driver_social_media_id;

//1 lift may have many steps
//@property (nonatomic,strong) NSMutableArray<Steps *>* steps;
@property (nonatomic,strong) NSMutableArray *steps;

@property (nonatomic,strong) NSString *lift_total_duration;
@property (nonatomic,strong) NSString *lift_total_price;
@property (nonatomic,strong) NSString *lift_currency;

@end
