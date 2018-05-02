//
//  HomeSegmentsViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 04/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedRoutesAsDriver.h"

@interface HomeSegmentsViewController : UIViewController
{
     SharedRoutesAsDriver *sharedRoutesAsDriver;
}

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) UIViewController *currentViewController;

@property (weak, nonatomic) UIViewController *passengerViewController;
@property (weak, nonatomic) UIViewController *driverViewController;


@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong, nonatomic) IBOutlet UILabel *label_passenger;

@property (strong, nonatomic) IBOutlet UILabel *label_driver;
- (IBAction)segmentChanged:(id)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *nextBarBtnItem;

- (IBAction)nextItem_pressed:(id)sender;

@end
