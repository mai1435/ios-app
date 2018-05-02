//
//  ChatListCell.h
//  SocialCar
//
//  Created by Vittorio Tauro on 10/04/18.
//  Copyright © 2018 Ab.Acus. All rights reserved.
//

#import "BaseCell.h"
#import "ChatListItem.h"

@interface ChatListCell : BaseCell {
	
	IBOutlet UILabel *lblName;
	IBOutlet UILabel *lblInfo;
	IBOutlet UILabel *lblType;
	IBOutlet UIImageView *imgAvatar;
}


- (void)setCellWithChatListItem:(ChatListItem *)chatItem index:(NSInteger)index;

@end
