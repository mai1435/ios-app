//
//  Car.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 25/06/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Car : NSObject

@property (nonatomic,strong) NSString *car_id;

@property (nonatomic,strong) NSString *ride_id;

@property (nonatomic,strong) NSString *model;
@property (nonatomic,strong) NSString *plate;
@property (nonatomic,strong) NSString *colour;
@property (nonatomic,strong) UIColor *colour_text;
@property (nonatomic,strong) NSString *seats;

//@property NSInteger seats;

@property (nonatomic,strong) NSString *food;
@property (nonatomic,strong) NSString *smoking;

@property (nonatomic,strong) NSString *air_conditioning;
@property (nonatomic,strong) NSString *pets;
@property (nonatomic,strong) NSString *luggage;
@property (nonatomic,strong) NSString *child_seat;
@property (nonatomic,strong) NSString *music;

@property (nonatomic,strong) UIImage *car_image;
//@property (nonatomic,strong) UIImage *car_image_previous;
@property (nonatomic,strong) NSString *car_picture_id;
@property (nonatomic,strong) NSString *car_picture_file;


@end
