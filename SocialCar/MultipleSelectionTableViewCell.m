//
//  MultipleSelectionTableViewCell.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 28/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "MultipleSelectionTableViewCell.h"
#import "MultipleSelectionTableViewController.h"

@implementation MultipleSelectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.switch_setting setOn:NO];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
