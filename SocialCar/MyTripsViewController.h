//
//  MyTripsViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 22/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareRoutes.h"
#import "SharedRoutesAsDriver.h"
#import "SharedLiftNotified.h"
#import "RequestedTripsViewController.h"


@interface MyTripsViewController : UIViewController
{
    ShareRoutes *sharedRoutes;
    SharedRoutesAsDriver *sharedRoutesAsDriver;
    SharedLiftNotified *sharedLiftNotified;
	
}

@property (weak, nonatomic) UIViewController *currentViewController;

@property (weak, nonatomic) UIViewController *requestedTripsViewController;
@property (weak, nonatomic) UIViewController *offeredTripsViewController;


@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (strong, nonatomic) IBOutlet UILabel *label_requested;
@property (strong, nonatomic) IBOutlet UILabel *label_offerred;
@property (strong, nonatomic) IBOutlet UIView *containerView;

- (void)segueToLiftNotifiedDetail;

- (IBAction)btn_notified_by_driver:(id)sender;

- (IBAction)btn_notified_passenger:(id)sender;


- (IBAction)segment_changed:(id)sender;

@end
