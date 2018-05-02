//
//  SolutionsTableViewCell.m
//  TableViewSocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 21/02/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import "RouteTableViewCell.h"

@implementation RouteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
 /*
    [self.stackview_first_row addArrangedSubview:self.label_duration];
    [self.stackview_first_row addArrangedSubview:self.label_time];
    
    
    //Line vertical
    self.label_vertical_line = [self.label_vertical_line initWithFrame:CGRectMake(0,0, 1, self.label_vertical_line.bounds.size.height )];
    self.label_vertical_line.backgroundColor = [UIColor grayColor];
    [self.stackview_first_row addArrangedSubview:self.label_vertical_line];
    
    [self.stackview_first_row addArrangedSubview:self.label_vertical_line];
    [self.stackview_first_row addArrangedSubview:self.label_price];
  */
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
