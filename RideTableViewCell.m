//
//  RideTableViewCell.m
//  SocialCar
//
//  Created by Kostas Kalogirou on 27/07/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import "RideTableViewCell.h"


@implementation RideTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.label_details setText:NSLocalizedString(@"RIDE_CELL_DETAIL", @"When you will accept a lift request for this trip, the passenger avatar will be displayed in this area.")];
   // [self.label_details setText:NSLocalizedString(@"RIDE_CELL_DETAIL", @"RIDE_CELL_DETAIL")];


    //[self.btn_delete_trip setTitle:NSLocalizedString(@"DELETE TRIP", @"DELETE TRIP") forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
