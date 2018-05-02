//
//  ChatListCell.m
//  SocialCar
//
//  Created by Vittorio Tauro on 10/04/18.
//  Copyright © 2018 Ab.Acus. All rights reserved.
//

#import "ChatListCell.h"
#import "Lift.h"
#import "NSDate+Additions.h"

@implementation ChatListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
	imgAvatar.layer.cornerRadius = imgAvatar.frame.size.height / 2;
	imgAvatar.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)cellHeight
{
	return 90.0f;
}

- (void)setCellWithChatListItem:(ChatListItem *)chatItem index:(NSInteger)index
{
	[lblName setText:chatItem.receiverNameSurname];
	
	[lblInfo setText:[NSString stringWithFormat:@"Lift date: %@", [[NSDate dateWithTimeIntervalSince1970:[chatItem.refLift.start_address_date doubleValue]] shortLocalizedDateAndTimeAlaWhatsApp]]];
	
	[lblType setText:chatItem.receiverType == DRIVER ? @"DRIVER" : @"PASSENGER"];
	
	[imgAvatar setImage:chatItem.receiverAvatar];

}

@end
