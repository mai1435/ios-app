//
//  RecordedTripVC.m
//  SocialCar
//
//  Created by Vittorio Tauro on 05/03/18.
//  Copyright © 2018 Ab.Acus. All rights reserved.
//

#import "RecordedTripVC.h"
#import "FCAlertView.h"

typedef enum
{
	RecordSTARTED,
	RecordSTOPPED,
	RecordPAUSED,
	RecordIDLE
} RecordingState;

@interface RecordedTripVC ()
@property(weak, nonatomic) IBOutlet UILabel *lblState;
@property (nonatomic) NSTimer* locationUpdateTimer;

@end

int recordingState;

@implementation RecordedTripVC

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Live Recording";
	recordingState = RecordIDLE;
	
	//init realm
	[RealmHelper setDefaultRealm];
	
	sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];
	ride = [[Ride alloc]init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnStopPressed:(id)sender{
	[_btnRecord setImage:[UIImage imageNamed:@"start_recording"] forState:UIControlStateNormal];
	recordingState = RecordSTOPPED;
	self.lblState.text = @"stopped";
	
	RLMResults *result = [RealmHelper retrieveAllPositions];
	NSArray *coords = [[NSArray alloc] initWithObjects:
					   [NSNumber numberWithFloat:((RPosition*)result.firstObject).lng],
					   [NSNumber numberWithFloat:((RPosition*)result.firstObject).lat],
					   [NSNumber numberWithFloat:((RPosition*)result.lastObject).lng],
					   [NSNumber numberWithFloat:((RPosition*)result.lastObject).lat],
					   nil];
	
	ride.coordinates = [NSArray arrayWithArray:coords];
	ride.origin_address = @"Starting recorded point";
	ride.destination_address = @"Ending recorded point";
	[sharedRoutesAsDriver.rides addObject:ride];
	
	NSString *coordinatesPolylineStr = @"";
	coordinatesPolylineStr = @"coordinates=";
	for (int c=0; c < result.count; c++)
	{
		/*NSLog(@"routeCoordinates[%d] = %f, %f",
		 c, routeCoordinates[c].latitude, routeCoordinates[c].longitude);*/
		
		coordinatesPolylineStr = [coordinatesPolylineStr stringByAppendingString:[NSString stringWithFormat:@"%.6f", ((RPosition*)result[c]).lng]];
		
		coordinatesPolylineStr = [coordinatesPolylineStr stringByAppendingString:@";"];
		
		coordinatesPolylineStr = [coordinatesPolylineStr stringByAppendingString:[NSString stringWithFormat:@"%.6f", ((RPosition*)result[c]).lat]];
		
		if (c != (result.count -1) )
		{
			coordinatesPolylineStr = [coordinatesPolylineStr stringByAppendingString:@","];
		}
		
	}
	sharedRoutesAsDriver.routeCoordinates_polyline = coordinatesPolylineStr;
	
	[self.navigationController performSegueWithIdentifier:@"segueCreateRide" sender:self];
	
}

- (IBAction)btnCancelPressed:(id)sender{
	
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Attention"
																   message:@"Closing you will lost all recorded data. Are you sure?"
															preferredStyle:UIAlertControllerStyleAlert];
	
	UIAlertAction* close = [UIAlertAction actionWithTitle:@"Yes, I'm sure" style:UIAlertActionStyleDefault
														  handler:^(UIAlertAction * action) {
															  [_btnRecord setImage:[UIImage imageNamed:@"start_recording"] forState:UIControlStateNormal];
															  recordingState = RecordSTOPPED;
															  self.lblState.text = @"canceled";
															  
															  //cancello tutti gli elementi dal db
															  RLMResults *result = [RealmHelper retrieveAllPositions];
															  for (RPosition *p in result)
															  {
																  [RealmHelper deleteItem:p];
															  }
															  
															  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
																  [self.navigationController popViewControllerAnimated:YES];
															  });
														  }];
	
	UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault
												  handler:^(UIAlertAction * action) {
												  }];
	[alert addAction:close];
	[alert addAction:cancel];
	[self presentViewController:alert animated:YES completion:nil];
	/*
	FCAlertView* alert = [[FCAlertView alloc] init];
	[alert showAlertWithTitle:@"ALT" withSubtitle:@"Are you sure to cancel the current recording trip?" withCustomImage:nil withDoneButtonTitle:@"OK" andButtons:nil];
	[alert makeAlertTypeCaution];
	 */
}

- (IBAction)btnRecordPressed:(id)sender{

	//registrazione in corso
	if (recordingState == RecordSTARTED){
		[_btnRecord setImage:[UIImage imageNamed:@"start_recording"] forState:UIControlStateNormal];
		recordingState = RecordPAUSED;
		self.lblState.text = @"paused";
		
		//stop fetching locations
		[self stopUpdatingLocationCustom];
	}
	//registrazione è in STOP
	else if (recordingState == RecordSTOPPED)
	{
		[_btnRecord setImage:[UIImage imageNamed:@"stop_recording"] forState:UIControlStateNormal];
		recordingState = RecordSTARTED;
		self.lblState.text = @"recording";
	}
	//la registrazione è PAUSATA
	else if (recordingState == RecordPAUSED)
	{
		[_btnRecord setImage:[UIImage imageNamed:@"stop_recording"] forState:UIControlStateNormal];
		recordingState = RecordSTARTED;
		self.lblState.text = @"recording";
		
		//init fetching locations
		[self startUpdatingLocationCustom];
	}
	//la registrazione è in attesa
	else if (recordingState == RecordIDLE)
	{
		[_btnRecord setImage:[UIImage imageNamed:@"stop_recording"] forState:UIControlStateNormal];
		recordingState = RecordSTARTED;
		self.lblState.text = @"recording";
		
		//cancello tutti gli elementi dal db
		RLMResults *result = [RealmHelper retrieveAllPositions];
		for (RPosition *p in result)
		{
			[RealmHelper deleteItem:p];
		}
		
		//init fetching locations
		[self startUpdatingLocationCustom];
	}
}

#pragma mark - Location Manager

- (void) startUpdatingLocationCustom
{
	
	UIAlertView * alert;

	if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied){
		
		alert = [[UIAlertView alloc]initWithTitle:@""
										  message:@"The app doesn't work without the Background App Refresh enabled. To turn it on, go to Settings > General > Background App Refresh"
										 delegate:nil
								cancelButtonTitle:@"Ok"
								otherButtonTitles:nil, nil];
		[alert show];
		
	}else if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted){
		
		alert = [[UIAlertView alloc]initWithTitle:@""
										  message:@"The functions of this app are limited because the Background App Refresh is disable."
										 delegate:nil
								cancelButtonTitle:@"Ok"
								otherButtonTitles:nil, nil];
		[alert show];
		
	} else{
		
		self.locationTracker = [[LocationTracker alloc]init];
		[self.locationTracker startLocationTracking];
		
		//Send the best location to server every 60 seconds
		//You may adjust the time interval depends on the need of your app.
		NSTimeInterval time = 10.0;
		self.locationUpdateTimer =
		[NSTimer scheduledTimerWithTimeInterval:time
										 target:self
									   selector:@selector(updateLocation)
									   userInfo:nil
										repeats:YES];
	}
}

- (void)stopUpdatingLocationCustom{
	[self.locationUpdateTimer invalidate];
	self.locationUpdateTimer = nil;
	[self.locationTracker stopLocationTracking];
}


-(void)updateLocation {
	NSLog(@"updateLocation");
	
	[self.locationTracker updateLocationToServer];
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
