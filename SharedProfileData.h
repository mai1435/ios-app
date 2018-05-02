//
//  SharedProfileData.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 14/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>

//to be accessed in whole application
@interface SharedProfileData : NSObject

@property (nonatomic,strong) NSString *userID;
@property (nonatomic,strong) NSString *authCredentials;

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
@property (nonatomic,strong) NSString *platform;

@property (nonatomic,strong) NSMutableArray *tableTravelModesValues;
@property (nonatomic,strong) NSMutableArray *tableOptimiseTravelSolutions;
@property (nonatomic,strong) NSMutableArray *tableSpecialNeeds;

@property (nonatomic,strong) NSMutableArray *tableFilters;

@property (nonatomic) BOOL hasCar;

@property (nonatomic) BOOL useFacebook;
@property (nonatomic,strong) NSString *facebook_userID;
@property (nonatomic,strong) NSString *facebook_tokenID;

@property (nonatomic) BOOL useGoogle;
// @property (nonatomic) BOOL userGoogleNil;
@property (nonatomic,strong) NSString *google_userID;
@property (nonatomic,strong) NSString *google_idToken;
@property (nonatomic,strong) NSURL *google_picture_URL;

@property (nonatomic) BOOL alreadyloggeIn;

@property (nonatomic,strong) NSMutableArray *cars_ids;

@property (nonatomic,strong) NSURLSession *sessionGlobal;
//-(id) initWithAllData:(NSString *) uname andEmail:(NSString *)uemail;

//+(instancetype) setSharedProfileData:(NSString *) uname andEmail:(NSString *)uemail;

//Singleton?
+(SharedProfileData *) sharedObject;

@end
