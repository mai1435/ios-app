//
//  RouteDetailsTableViewCell.h
//  TableViewSocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 22/02/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RouteDetailsTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *image_transport_type;

@property (strong, nonatomic) IBOutlet UILabel *label_route_instruction;

@property (strong, nonatomic) IBOutlet UILabel *label_stops;
@property (strong, nonatomic) IBOutlet UIImageView *label_circle_divider;
@property (strong, nonatomic) IBOutlet UILabel *label_duration;
@property (strong, nonatomic) IBOutlet UILabel *label_estimation_time;

@property (strong, nonatomic) IBOutlet UIImageView *image_driver;
@property (strong, nonatomic) IBOutlet UIImageView *image_next_route_details;
@property (strong, nonatomic) IBOutlet UIImageView *image_stop_name;
@property (strong, nonatomic) IBOutlet UILabel *label_departs_at;
@property (strong, nonatomic) IBOutlet UILabel *label_arrives_to;

@property (strong, nonatomic) IBOutlet UILabel *label_stops_names;

@property (strong, nonatomic) IBOutlet UIImageView *image_end_point;

@property (strong, nonatomic) IBOutlet UILabel *label_end_point;


@property (strong, nonatomic) IBOutlet UILabel *label_transport_number;

@property (strong, nonatomic) IBOutlet UIImageView *image_circles_divider_up;


@end
