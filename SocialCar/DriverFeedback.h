//
//  DriverFeedback.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 27/06/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriverFeedback : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image_driver;
@property (strong, nonatomic) IBOutlet UILabel *label_user_name;


@property (strong, nonatomic) IBOutlet UIImageView *image_star1;
@property (strong, nonatomic) IBOutlet UIImageView *image_star2;
@property (strong, nonatomic) IBOutlet UIImageView *image_star3;
@property (strong, nonatomic) IBOutlet UIImageView *image_star4;
@property (strong, nonatomic) IBOutlet UIImageView *image_star5;
@property (strong, nonatomic) IBOutlet UILabel *label_datetime;
@property (strong, nonatomic) IBOutlet UILabel *label_comments;

@property (nonatomic,strong) NSMutableArray *imagesStars;


@end
