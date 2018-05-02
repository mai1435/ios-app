//
//  SolutionsTableViewCell.h
//  TableViewSocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 21/02/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RouteTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *label_duration;
@property (strong, nonatomic) IBOutlet UILabel *label_time;
@property (strong, nonatomic) IBOutlet UILabel *label_vertical_line;
@property (strong, nonatomic) IBOutlet UILabel *label_price;
@property (strong, nonatomic) IBOutlet UIStackView *stackview_first_row;



@property (strong, nonatomic) IBOutlet UIImageView *image_transport;
@property (strong, nonatomic) IBOutlet UILabel *label_tranport_details;

@property (strong, nonatomic) IBOutlet UILabel *label_seperator;
@property (strong, nonatomic) IBOutlet UIStackView *stackview_second_row;


@end
