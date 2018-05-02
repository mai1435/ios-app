//
//  RideTableViewCell.h
//  SocialCar
//
//  Created by Kostas Kalogirou on 27/07/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RideTableViewCell : UITableViewCell 

@property (strong, nonatomic) IBOutlet UILabel *label_ride_title;
@property (strong, nonatomic) IBOutlet UILabel *label_date_time;
@property (strong, nonatomic) IBOutlet UILabel *label_details;
@property (strong, nonatomic) IBOutlet UIImageView *image_avatar_passenger;
//Inorder to hide it
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_stackView_avatar_height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_details;

@property (strong, nonatomic) IBOutlet UISwitch *switch_status;
@property (strong, nonatomic) IBOutlet UIButton *btn_delete_trip;
@property (strong, nonatomic) IBOutlet UIButton *btn_more_details;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constraint_stackView_mapView_height;
@property (strong, nonatomic) IBOutlet UIButton *showMapView;


//@property (retain, nonatomic) IBOutlet MKMapView *mapView;



@end
