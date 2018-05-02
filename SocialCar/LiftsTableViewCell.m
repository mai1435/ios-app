//
//  LiftsTableViewCell.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 22/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "LiftsTableViewCell.h"

@implementation LiftsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.view_line setHidden:YES];
    [self.imageView_feedback setHidden:YES];
    [self.label_feedback setHidden:YES];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
