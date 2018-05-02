//
//  TrafficConditionsTableViewCell.m
//  SocialCar
//
//  Created by Vittorio Tauro on 27/07/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import "TrafficConditionsTableViewCell.h"

@implementation TrafficConditionsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.clipsToBounds = NO;
    self.contentView.clipsToBounds = NO;
    
    _backgroundUIView.layer.cornerRadius = 3.0f;
    _backgroundUIView.layer.shadowColor = [UIColor blackColor].CGColor;
    _backgroundUIView.layer.shadowOpacity = 0.3f;
    _backgroundUIView.layer.shadowOffset = CGSizeMake(0.0f, 1.3f);
    _backgroundUIView.layer.shadowRadius = 1.8f;
    
    _backgroundUIView.backgroundColor = [UIColor whiteColor];
    _backgroundUIView.layer.cornerRadius = 3.0f;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
