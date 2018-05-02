//
//  ChatRoomVC.h
//  SocialCar
//
//  Created by Vittorio Tauro on 10/04/18.
//  Copyright © 2018 Ab.Acus. All rights reserved.
//

@import QMChatViewController;
#import "SharedRoutesAsPassenger.h"
#import "SharedRoutesAsDriver.h"
#import "SharedProfileData.h"
#import "SharedDriverProfileData.h"
#import "CommonData.h"
#import "ChatListItem.h"
#import "ChatListCell.h"

@interface ChatRoomVC : QMChatViewController{
	SharedRoutesAsPassenger *sharedRoutesAsPassenger;
	SharedRoutesAsDriver *sharedRoutesAsDriver;
	SharedProfileData *sharedProfile;
	SharedDriverProfileData *sharedDriverProfile;
	CommonData *commonData;
}

@property ChatListItem *passedCLI;

@end
