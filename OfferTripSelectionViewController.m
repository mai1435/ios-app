//
//  OfferTripSelectionViewController.m
//  SocialCar
//
//  Created by Vittorio Tauro on 14/02/18.
//  Copyright © 2018 Ab.Acus. All rights reserved.
//

#import "OfferTripSelectionViewController.h"
#import "UIUtils.h"
#import "MyTools.h"

@interface OfferTripSelectionViewController ()

@end

@implementation OfferTripSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	UITapGestureRecognizer *mapTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openMappedTrip)];
	mapTap.numberOfTapsRequired = 1;
	
	UITapGestureRecognizer *recTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openRecordedTrip)];
	recTap.numberOfTapsRequired = 1;
	
	self.recordedView.userInteractionEnabled = true;
	[self.recordedView addGestureRecognizer:recTap];
	
	self.mappedView.userInteractionEnabled = true;
	[self.mappedView addGestureRecognizer:mapTap];
	
	self.title = NSLocalizedString(@"Select an option", @"Select an option");
	// Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openMappedTrip
{
	[self.navigationController performSegueWithIdentifier:@"segueSetAddresses" sender:self.navigationController];
}

- (void)openRecordedTrip
{
	[self.navigationController performSegueWithIdentifier:@"segueRecordTrip" sender:self.navigationController];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
