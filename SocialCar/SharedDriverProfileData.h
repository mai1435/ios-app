//
//  SharedDriverProfileData.h
//  SocialCar
//
//  Created by Kostas Kalogirou(CERTH) on 03/05/17.
//  Copyright © 2017 Kostas Kalogirou(CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SharedDriverProfileData : NSObject

@property (nonatomic,strong) NSString *car_id;
@property (nonatomic,strong) NSString *model;
@property (nonatomic,strong) NSString *plate;
@property (nonatomic,strong) NSString *colour;
@property (nonatomic,strong) UIColor *colour_text;
@property (nonatomic,strong) NSString *seats;
@property (nonatomic,strong) NSString *food;
@property (nonatomic,strong) NSString *smoking;

@property (nonatomic,strong) NSString *air_conditioning;
@property (nonatomic,strong) NSString *pets;
@property (nonatomic,strong) NSString *luggage;
@property (nonatomic,strong) NSString *child_seat;
@property (nonatomic,strong) NSString *music;

@property (nonatomic,strong) UIImage *car_image;
@property (nonatomic,strong) UIImage *car_image_previous;
@property (nonatomic,strong) NSString *car_picture_id;
@property (nonatomic,strong) NSString *car_picture_file;


//@property (nonatomic,strong) NSMutableArray *tableTravelModesValues;



//Singleton?
+(SharedDriverProfileData *) sharedObject;

@end
