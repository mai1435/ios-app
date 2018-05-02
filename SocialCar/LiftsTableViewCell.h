//
//  LiftsTableViewCell.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 22/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiftsTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *imageView_status;
@property (strong, nonatomic) IBOutlet UILabel *label_trip_status;

@property (strong, nonatomic) IBOutlet UILabel *label_route_instructions;

@property (strong, nonatomic) IBOutlet UIView *view_line;

@property (strong, nonatomic) IBOutlet UIImageView *imageView_feedback;
@property (strong, nonatomic) IBOutlet UILabel *label_feedback;

@end
