//
//  ChatListViewController.h
//  SocialCar
//
//  Created by Vittorio Tauro on 05/04/18.
//  Copyright © 2018 Ab.Acus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedRoutesAsPassenger.h"
#import "SharedRoutesAsDriver.h"
#import "SharedProfileData.h"
#import "SharedDriverProfileData.h"
#import "CommonData.h"
#import "ChatListItem.h"
#import "ChatListCell.h"

@interface ChatListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {

	SharedRoutesAsPassenger *sharedRoutesAsPassenger;
	SharedRoutesAsDriver *sharedRoutesAsDriver;
	SharedProfileData *sharedProfile;
	SharedDriverProfileData *sharedDriverProfile;
	NSMutableArray *liftAsDriver;
	NSMutableArray *liftAsPassenger;
	CommonData *commonData;

}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
