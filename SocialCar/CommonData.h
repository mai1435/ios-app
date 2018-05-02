//
//  CommonData.h
//  SocialCar
//
//  Created by ostas Kalogirou (CERTH)  on 31/03/17.
//  Copyright © 2017 ostas Kalogirou (CERTH) . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonData : NSObject

#define TRAVEL_MODES @"Travel Modes"
#define OPTIMISE_TRAVEL_SOLUTIONS @"Optimise Travel Solutions by"
#define SPECIAL_NEEDS @"Special needs"
#define FILTERS @"Filters"

#define USER_ID_ @"_id"
#define EMAIL_ @"email"
#define PASSWORD_ @"password"
#define USER_NAME_ @"name"
#define PHONE_ @"phone"
#define DATE_OF_BIRTH_ @"dob"
#define GENDER_ @"gender"
#define FCM_TOKEN_ @"fcm_token"

#define PICTURES_ @"pictures"
#define PICTURE_ID @"_id"
#define PICTURE_FILE @"file"

#define RATING_ @"rating"

#define MAX_TRANSFERS_ @"max_transfers"
#define MAX_COST_ @"max_cost"
#define MAX_WALKING_DISTANCE_ @"max_walk_distance"

#define CARPOOLER_AGE_ @"carpooler_age"
#define CARPOOLER_GENDER_ @"carpooler_gender"
#define GPS_TRACKING_ @"gps_tracking"
#define SMOKING_ @"smoking"
#define FOOD_ @"food"
#define MUSIC_ @"music"
#define PETS_ @"pets"
#define LUGGAGE_ @"luggage"

#define OPTIMISATION_ @"optimisation"
#define TRAVEL_PREFERENCES_ @"travel_preferences"
#define PREFERRED_TRANSPORT_ @"preferred_transport"
#define SPECIAL_REQUEST_ @"special_request"

#define FCM_TOKEN_NOT_INITIALISED @"NOT_INITIALIZED"

#define FCM_TOKEN_IOS_EMULATOR @"grPNkGUVl0:APA91bF3iVPpY6uC."


#define CAR_ID_ @"car_id"
#define ID_ @"_id"
#define PICTURE_CAR_ID @"_id"
#define COLOUR_ @"colour"
#define SEATS_ @"seats"
#define MODEL_ @"model"
#define PLATE_ @"plate"
#define OWNER_ID @"owner_id"

#define CAR_USAGE_PREFERENCES @"car_usage_preferences"
#define AIR_CONDITIONING @"air_conditioning"
#define CHILD_SEAT @"child_seat"
#define FOOD_ALLOWED @"food_allowed"
#define LUGGAGE_TYPE @"luggage_type"
#define PETS_ALLOWED @"pets_allowed"
#define SMOKING_ALLOWED @"smoking_allowed"
#define MUSIC_ALLOWED @"music_allowed"

#define SOCIAL_PROVIDER @"social_provider"
#define SOCIAL_NETWORK @"social_network"
#define SOCIAL_ID @"social_id"

#define HTTP_METHOD_GET @"GET"
#define HTTP_METHOD_PATCH @"PATCH"
#define HTTP_METHOD_PUT @"PUT"
#define HTTP_METHOD_POST @"POST"
#define HTTP_METHOD_DELETE @"DELETE"

#define TRANSPORT_CAR_POOLING @"CAR_POOLING"
#define TRANSPORT_BUS @"BUS"
#define TRANSPORT_RAIL @"RAIL"
#define TRANSPORT_METRO @"METRO"
#define TRANSPORT_TRAM @"TRAM"
#define TRANSPORT_FEET @"FEET"

#define SOCIAL_NETWORK_FACEBOOK @"FACEBOOK"
#define SOCIAL_NETWORK_GOOGLE @"GOOGLE_PLUS"

//CREATE LIFTS
#define PASSENGER_ID @"passenger_id"
#define DRIVER_ID @"driver_id"
#define RIDE_ID @"ride_id"
#define PUBLIC_URI @"public_uri"

#define STATUS @"status"
#define PENDING @"PENDING"

#define START_POINT @"start_point"
#define DATE @"date"
#define POINT @"point"
#define LAT @"lat"
#define LON @"lon"
#define ADDRESS @"address"

#define END_POINT @"end_point"
#define TRIP @"trip"

//URLs fro REST web services
// = @"http://46.101.238.243:5000/rest/v2/";
@property (nonatomic,strong) NSString *BASEURL;
@property (nonatomic,strong) NSString *BASEURL_FOR_PICTURES;
@property (nonatomic,strong) NSString *BASEURL_FOR_TRIPS;
@property (nonatomic,strong) NSString *BASEURL_FOR_FEEDBACKS;
@property (nonatomic,strong) NSString *BASEURL_CHAT;
@property (nonatomic,strong) NSString *BASEURL_LIFTS_PASSENGER;
@property (nonatomic,strong) NSString *BASEURL_LIFTS_DRIVER;
@property (nonatomic,strong) NSString *BASEURL_CREATE_LIFTS;
@property (nonatomic,strong) NSString *BASEURL_UDATE_LIFTS;

@property (nonatomic,strong) NSString *BASEURL_CREATE_RIDES;
@property (nonatomic,strong) NSString *BASEURL_RETRIEVE_RIDES;
@property (nonatomic,strong) NSString *BASEURL_RETRIEVE_REPORTS;
@property (nonatomic,strong) NSString *BASEURL_CREATE_REPORT;
@property (nonatomic,strong) NSString *BASEURL_SEND_POSITION;

@property (nonatomic,strong) NSString *BASEURL_CREATE_FEEDBACK;
@property (nonatomic,strong) NSString *BASEURL_CREATE_FEEDBACKS;

@property (nonatomic,strong) NSString *ROLE_DRIVER;
@property (nonatomic,strong) NSString *ROLE_PASSENGER;

@property (nonatomic,strong) NSString *URL_users;
@property (nonatomic,strong) NSString *URL_cars;
@property (nonatomic,strong) NSString *notAvailable;

@property (nonatomic,strong) NSString *URL_user_pictures;
@property (nonatomic,strong) NSString *URL_car_pictures;

@property (strong,nonatomic) NSArray *tableTravelModes;

@property (strong,nonatomic) NSArray *tableOptimiseTravelSolutions;

@property (strong,nonatomic) NSArray *tableSpecialNeeds;

@property (strong,nonatomic) NSArray *arrayChoicesLuggageTypes;

@property (strong,nonatomic) NSArray *tableFilters;


-(void)initWithValues;

@end
