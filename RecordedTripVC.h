//
//  RecordedTripVC.h
//  SocialCar
//
//  Created by Vittorio Tauro on 05/03/18.
//  Copyright © 2018 Ab.Acus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RealmHelper.h"
#import "LocationTracker.h"
#import "SharedRoutesAsDriver.h"
#import "Ride.h"

@interface RecordedTripVC : UIViewController{
	SharedRoutesAsDriver *sharedRoutesAsDriver;
	Ride *ride;
}

@property (weak, nonatomic) IBOutlet UIButton *btnRecord;
@property LocationTracker * locationTracker;

@end
