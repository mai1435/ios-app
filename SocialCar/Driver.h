//
//  Driver.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 25/06/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Driver : NSObject

@property (nonatomic,strong) NSString *userID;
//@property (nonatomic,strong) NSString *authCredentials;

@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *user_name;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *dateofBirth;
@property (nonatomic,strong) NSString *gender;
@property (nonatomic,strong) UIImage *user_image;

@property (nonatomic,strong) NSString *picture_id;
@property (nonatomic,strong) NSString *picture_file;

@property (nonatomic,strong) NSString *rating;

@property (nonatomic,strong) NSString *max_no_transfers;
@property (nonatomic,strong) NSString *max_cost;
@property (nonatomic,strong) NSString *max_distance;

@property (nonatomic,strong) NSString *carpooler_age;
@property (nonatomic,strong) NSString *carpooler_gender;

@property (nonatomic,strong) NSString *gps_tracking;
@property (nonatomic,strong) NSString *smoking;
@property (nonatomic,strong) NSString *food;
@property (nonatomic,strong) NSString *music;
@property (nonatomic,strong) NSString *pets;
@property (nonatomic,strong) NSString *luggage;

@property (nonatomic,strong) NSString *fcm_token;//To be used later

@property (nonatomic,strong) NSMutableArray *tableTravelModesValues;
@property (nonatomic,strong) NSMutableArray *tableOptimiseTravelSolutions;
@property (nonatomic,strong) NSMutableArray *tableSpecialNeeds;

@property (nonatomic) BOOL hasCar;
@property (nonatomic) BOOL useFacebook;
@property (nonatomic,strong) NSString *facebook_id;

@property (nonatomic,strong) NSMutableArray *cars;
@property (nonatomic,strong) NSString *car_last_id;

//@property (nonatomic,strong) NSURLSession *sessionGlobal;
@end
