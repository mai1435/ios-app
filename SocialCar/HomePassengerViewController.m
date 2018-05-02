//
//  HomePassengerViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 23/01/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "HomePassengerViewController.h"
#import "MyCustomAnnotation.h"
#import "RouteViewController.h"
#import "HomeSegmentsViewController.h"
#import "FCAlertView.h"

@interface HomePassengerViewController ()

@end

@implementation HomePassengerViewController
{
    CLGeocoder *geocoder;
    CLPlacemark *placemark;

    //BOOL btn_current_location_clicked; //test var for checking whethet button clicked
}

@synthesize mapView;
@synthesize locationManager;


NSArray *arrRoutes;
NSInteger* totalWaypoints = 0;


- (void)comingFrom:(NSString *)viewControllerStr
{
    self.previousViewController = viewControllerStr;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    myTools = [[MyTools alloc]init];
    //Initialise singleton
    sharedProfile = [SharedProfileData sharedObject];
    sharedRoutes = [ShareRoutes sharedObject];
    sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];
	sharedRoutesAsPassenger = [SharedRoutesAsPassenger sharedRoutesAsPassengerObject];

    commonData = [[CommonData alloc]init];
    [commonData initWithValues];
    
    ride = [[Ride alloc]init];
	
	self.txtfield_waypoints_array = [[NSMutableArray alloc] init];
	
    self.special_case = NO;
    self.annotationViews = [[NSMutableArray<MKAnnotationView *> alloc] init];
	self.annotationViewsWaypoints = [[NSMutableArray<MKAnnotationView *> alloc] init];

#pragma txtfield_startAddress
    myTools = [[MyTools alloc]init];
    
    [myTools textfieldWithIcon:@"ic_point_a.png" withTextField:self.txtfield_startAddress];

#pragma txtfield_setDestinationAddress
    //Initialise tetxfield setDestiantionAddress
    self.txtfield_setDestinationAddress = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.txtfield_startAddress.bounds.size.width,self.txtfield_startAddress.bounds.size.height)];
    self.txtfield_setDestinationAddress.borderStyle = UITextBorderStyleRoundedRect;//UITextBorderStyleLine;
    
    self.txtfield_setDestinationAddress.clearButtonMode = UITextFieldViewModeUnlessEditing;
    
    NSString *txtfield_setDestinationAddress_placeHolder  =txtfield_setDestinationAddress_placeHolder = NSLocalizedString(@"Insert destination address", @"Insert destination address");
    
    self.txtfield_setDestinationAddress.placeholder = txtfield_setDestinationAddress_placeHolder;
	self.txtfield_setDestinationAddress.translatesAutoresizingMaskIntoConstraints = NO;
	
    [myTools textfieldWithIcon:@"ic_point_b.png" withTextField:self.txtfield_setDestinationAddress];
 
/*
    // To be removed!!!!
    self.txtfield_startAddress.text=@"Lugano";
    self.txtfield_setDestinationAddress.text =@"Lugano District";
    
   //Brussels
    
    //self.txtfield_startAddress.text=@"Brussels";
    //self.txtfield_setDestinationAddress.text =@"Brussels Station";
    
    
    [self.stackView_setAddresses addArrangedSubview:self.txtfield_startAddress];
    
    [self.stackView_setAddresses addArrangedSubview:self.txtfield_setDestinationAddress];
    
    [self.btn_address setTitle:@"SEARCH SOLUTIONS" forState:UIControlStateNormal];
    //End of "To be rmeoved"!
*/
    
    //Set delegate to textfields
    self.txtfield_startAddress.delegate = self;
    self.txtfield_setDestinationAddress.delegate = self;
    
    
    self.mapView.delegate = self;
    //Map settings
    
 //?   [self.mapView setZoomEnabled:YES];
 //?   [self.mapView setUserTrackingMode:MKUserTrackingModeFollow];
    
    //hide next button
    self.navigationItem.rightBarButtonItem = nil;
   
    //Disable button
	UIColor *color_title = [UIColor whiteColor];
	[self.btn_address setTitleColor:color_title forState:UIControlStateNormal];
	
	if ([self.previousViewController isEqualToString:@"Segment_OfferedTrip"] ){
//		self.title = NSLocalizedString(@"Create Trip", @"Create Trip");
		UIBarButtonItem* ways = [[UIBarButtonItem alloc] initWithTitle:@"Add Waypoints" style:UIBarButtonItemStylePlain target:self
																	  action:@selector(addNewWaypointToList)];
		self.navigationItem.rightBarButtonItem = ways;
	}
	
   // geocoder = [[CLGeocoder alloc] init];
	int i = 0;
	for (Lift* lp in sharedRoutesAsPassenger.lifts) {
		sharedRoutesAsPassenger.lift_selected = i;
		[self retrieveUser:lp.driver_id comingFrom:@"passenger" withLift:lp];
		i++;
	}
	
	int k = 0;
	for (Lift* ld in sharedRoutesAsDriver.lifts) {
		sharedRoutesAsDriver.lift_selected = k;
		[self retrieveUser:ld.passenger_id comingFrom:@"driver" withLift:ld];
		k++;
	}

}

#pragma mark - Retrieve user - for passenger
- (void)retrieveUser:(NSString *)passenger_id comingFrom:(NSString*)comingFromViewController withLift:(Lift*)lift
{
	//1. Create URL
	NSString *ulrStr = commonData.BASEURL;
	
	ulrStr = [ulrStr stringByAppendingString:commonData.URL_users];
	ulrStr = [ulrStr stringByAppendingString:passenger_id];
	
	
	NSURL *urlWithString = [NSURL URLWithString:ulrStr];
	NSLog(@"urlWithString=%@",urlWithString);
	
	//2. Get credentials from GUI
	NSURLCredential *newCredential = [NSURLCredential credentialWithUser:sharedProfile.email password: sharedProfile.password persistence:NSURLCredentialPersistenceNone];
	
	NSString *authStr = [newCredential user];
	authStr = [authStr stringByAppendingString:@":"];
	authStr  = [authStr stringByAppendingString:[newCredential password] ];
	
	//2.1 Create string authValue for sessionConfiguration (3) => "Basic xxxxxxxxx"
	NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
	NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
	
	NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
	
	//3. Set HTTP Headers and HTTP Method
	[urlRequest setValue:authValue forHTTPHeaderField:@"Authorization"];
	[urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
	[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	//4. Set HTTP Method
	[urlRequest setHTTPMethod:HTTP_METHOD_GET];//@"GET"];
	
	//5. Send Request to Server
	NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
								  {
									  
									  NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
									  
									  NSLog(@"ParseJson =%@", parseJSON);
									  
									  [self fill_passenger:parseJSON compingFrom:comingFromViewController withLift:lift];
									  
									  //? [self retrieveFeedbackForDriver];
									  
									  /*   dispatch_async(dispatch_get_main_queue(), ^{
									   
									   //showFeedbackPassenger
									   [self.navigationController performSegueWithIdentifier:@"showFeedbackPassenger" sender:self];
									   
									   [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
									   [indicatorView stopAnimating];
									   
									   });
									   */
									  
								  }];
	
	
	
	[task resume];
}

-(void)fill_passenger:(NSDictionary *)parseJSON compingFrom:(NSString*)comingFromViewController withLift:(Lift*)lift
{
	//passenger.userID = [parseJSON valueForKey:@"_id"];
	
	//passenger.user_name =
	lift.passenger_name = [parseJSON valueForKey:@"name"];
	
	//long rate = [parseJSON valueForKey:@"rating"];
	//NSDictionary *rating = [parseJSON valueForKey:@"rating"];
	//lift.passenger_rating = [rating valueForKey:@"rating"];
	
	//  lift.passenger_rating = [parseJSON valueForKey:@"rating"];
	lift.passenger_rating  = [ [parseJSON valueForKey:@"rating"] stringValue];
	// lift.passenger_phone = [ parseJSON valueForKey:@"phone"];
	
	NSArray *pictures = [parseJSON valueForKey:@"pictures"];
	
	if (pictures.count !=0 )
	{
		NSString *picture_id = [pictures[0] valueForKey:PICTURE_ID];//]@"_id"];
		
		NSLog(@"pictures_id=%@",[pictures[0] valueForKey:@"_id"]);
		
		NSString *picture_file = [pictures [0]valueForKey:PICTURE_FILE];//]@"file"];
		NSLog(@"pictures_file=%@", [pictures[0] valueForKey:@"file"]);
		
		///---------------///
		//Now create URL to download image
		NSString *ulrStr = commonData.BASEURL_FOR_PICTURES;
		ulrStr = [ulrStr stringByAppendingString:picture_file];
		
		NSLog(@"url of image=%@",ulrStr);
		
		NSURL *imageURLString = [NSURL URLWithString:ulrStr];
		
		NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageWithData:
																		   [NSData dataWithContentsOfURL:imageURLString]])];
		//Display it in the UIImage
		UIImage *image = [UIImage imageWithData:imageData];
		
		lift.passenger_picture = image;
		
	}
	else
	{
		lift.passenger_picture = [UIImage imageNamed:@"account-circle-grey"];
	}
	//sharedRoutesAsDriver.lift_selected
	//Update current (selected lift with passenger values
	if ([comingFromViewController isEqualToString:@"Passenger"])
	{
		[sharedRoutesAsPassenger.lifts replaceObjectAtIndex:sharedRoutesAsPassenger.lift_selected withObject:lift];
	}
	else if ([comingFromViewController isEqualToString:@"Driver"])
	{
		[sharedRoutesAsDriver.lifts replaceObjectAtIndex:sharedRoutesAsDriver.lift_selected withObject:lift];
	}
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addNewWaypointToList {
	
	UITextField *newTxtField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.txtfield_startAddress.bounds.size.width,self.txtfield_startAddress.bounds.size.height)];
	newTxtField.borderStyle = UITextBorderStyleRoundedRect;//UITextBorderStyleLine;
	
	newTxtField.clearButtonMode = UITextFieldViewModeUnlessEditing;
	
	NSString *newTxtFieldWaypointPlaceHolder = NSLocalizedString(@"Insert waypoint address", @"Insert waypoint address");
	
	newTxtField.placeholder = newTxtFieldWaypointPlaceHolder;
	newTxtField.translatesAutoresizingMaskIntoConstraints = NO;
	newTxtField.delegate = self;
	newTxtField.clearButtonMode = UITextFieldViewModeNever;
	
	[myTools textfieldWithIcon:@"ic_waypoint.png" withTextField:newTxtField];
	
	if (self.txtfield_waypoints_array.count>3) {
		FCAlertView* alert = [[FCAlertView alloc] init];
		[alert showAlertWithTitle:@"OPS" withSubtitle:@"Max 4 Waypoints" withCustomImage:nil withDoneButtonTitle:@"OK" andButtons:nil];
		[alert makeAlertTypeCaution];
		return;
	}
	[self.txtfield_waypoints_array addObject:newTxtField];
	
	[self.stackView_setAddresses addArrangedSubview:self.txtfield_startAddress];
	
	int i = 100;
	for (UITextField* tf in self.txtfield_waypoints_array) {
		tf.tag = i;
		i++;
		[self.stackView_setAddresses addArrangedSubview:tf];
	}
	
	[self.stackView_setAddresses addArrangedSubview:self.txtfield_setDestinationAddress];
	
	[self.stackView_setAddresses addArrangedSubview:self.btn_address];
	
	[self.stackView_setAddresses setDistribution:UIStackViewDistributionFillEqually];
}
	
//#pragma mark - init UIActivityIndicatorView
//-(void) init_ActivityIndicator
//{
//    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    
//    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
//    indicator.center = self.view.center;
//    
//    [self.view addSubview:indicator];
//    
//    [indicator bringSubviewToFront:self.view];
//    
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
//}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	[textField setBackgroundColor:[UIColor whiteColor]];
    [textField resignFirstResponder];
	
	if ([self.txtfield_waypoints_array containsObject:textField]) {
		self.addressStatus=(int)textField.tag;
	}else if (textField == self.txtfield_startAddress){
        self.addressStatus = 0;
        //Enable button
        [self.btn_address setEnabled:YES];
        UIColor *color_title = [UIColor whiteColor];
        
        [self.btn_address setTitleColor:color_title forState:UIControlStateNormal];
    }
    else
    {
        self.addressStatus = 1;
    }
    
    if ([self.previousViewController isEqualToString:@"Segment_OfferedTrip"] )
    {
        [self.navigationController performSegueWithIdentifier:@"segueSelectAddress" sender:self];

    }
    else
    {
        [self.navigationController performSegueWithIdentifier:@"showSegue" sender:self];
    }


    return NO; //YES;
}


//Method from UITextFieldDelegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    textField.backgroundColor = SocialCarPrimaryColor01;
 
    
    return YES;//editing should stop
}
/*
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.backgroundColor = [UIColor clearColor];
}
*/

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    //To not be edited by the user after selection from Alert Dialog
    /*if ( (textField == self.txtfield_startAddress)
        || (textField == txtfield_setDestinationAddress) )
    {
        return NO;
    }*/
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
	[self.mapView removeOverlays:self.mapView.overlays];
	dispatch_async(dispatch_get_main_queue(), ^{
		
		[self.mapView removeOverlays:self.mapView.overlays];
		[self.mapView reloadInputViews];
		[self.mapView setNeedsDisplay];
	});
	
    if (textField == self.txtfield_startAddress)
    {
        self.txtfield_startAddress.text = @"";
		for (int i=0;i<self.mapView.annotations.count;i++)
		{
			if ([self.mapView.annotations[i] isKindOfClass:[MKUserLocation class]])
			{
				[self.mapView removeAnnotation:self.mapView.annotations[i]];
				self.mapView.showsUserLocation = NO;
				[self.locationManager stopUpdatingLocation];
				break;
			}
		}
		[self.mapView removeAnnotation:_annotationViewStart];
		self.annotationViewStart = nil;

    }
    else if (textField == self.txtfield_setDestinationAddress)
    {
       
        self.txtfield_setDestinationAddress.text = @"";
        
		[self.mapView removeAnnotation:_annotationViewStop];
		self.annotationViewStop = nil;
	}else
	{
		
		textField.text = @"";
		self.annotationViewStop = nil;
	}
    return YES;
    
}

#pragma mark Button set address pressed
- (IBAction)btn_setAddress:(id)sender
{
	
	[self.mapView removeOverlays:self.mapView.overlays];
//    [self.stackView_setAddresses initWithFrame:CGRectMake(0,-35, self.stackView_setAddresses.bounds.size.width, self.stackView_setAddresses.bounds.size.height +35)];
	
    NSString *btn_startAddress_label = NSLocalizedString(@"SET STARTING POINT",@"SET STARTING POINT");
    NSString *btn_destinationAddress_label = NSLocalizedString(@"SET DESTINATION POINT",@"SET DESTINATION POINT");
    NSString *btn_searchSolutions_label = NSLocalizedString(@"SEARCH SOLUTIONS",@"SEARCH SOLUTIONS");
    NSString *btn_searchSolutions_continue = NSLocalizedString(@"CONTINUE",@"CONTINUE");
	
	if ([self.btn_address.currentTitle isEqualToString:btn_startAddress_label])
	{
		if (![self.txtfield_startAddress hasText]) {
			return;
		}
	}
	
	if ([self.btn_address.currentTitle isEqualToString: btn_destinationAddress_label])
	{
		if (![self.txtfield_setDestinationAddress hasText]) {
			return;
		}
	}
	
	if ([self.btn_address.currentTitle isEqualToString: btn_destinationAddress_label])
	{
		if (![self.txtfield_setDestinationAddress hasText]||![self.txtfield_startAddress hasText]) {
			return;
		}
	}
	
	[self.stackView_setAddresses addArrangedSubview:self.txtfield_startAddress];
	
	int i = 100;
	for (UITextField* tf in self.txtfield_waypoints_array) {
		tf.tag = i;
		i++;
		[self.stackView_setAddresses addArrangedSubview:tf];
	}
	
	[self.stackView_setAddresses addArrangedSubview:self.txtfield_setDestinationAddress];
	
	[self.stackView_setAddresses addArrangedSubview:self.btn_address];
	
	[self.stackView_setAddresses setDistribution:UIStackViewDistributionFillEqually];
    
    //NSLog(@"currentTitle=%@",self.btn_address.currentTitle);
    if ([self.btn_address.currentTitle isEqualToString:btn_startAddress_label])
    {
        //coords_origin = [self coordinatesFromAddress:self.txtfield_startAddress.text];
        
        [self.btn_address setTitle:btn_destinationAddress_label forState:UIControlStateNormal];
      //It shoud enter here
        [self.txtfield_startAddress resignFirstResponder];
		[self.txtfield_startAddress setBackgroundColor:SocialCarPrimaryColor01];

        //[self.txtfield_setDestinationAddress becomeFirstResponder];
        
    }
    else if ([self.btn_address.currentTitle isEqualToString: btn_destinationAddress_label])
    {
       
        if ([self.previousViewController isEqualToString:@"Segment_OfferedTrip"] )
        {
            [self.btn_address setTitle:btn_searchSolutions_continue forState:UIControlStateNormal];
        }
        else
        {
            [self.btn_address setTitle:btn_searchSolutions_label forState:UIControlStateNormal];
        }
        
        [self.txtfield_setDestinationAddress resignFirstResponder];
		[self.txtfield_setDestinationAddress setBackgroundColor:SocialCarPrimaryColor01];

        [self.btn_address becomeFirstResponder];
        
       
        
       
      //  [myTools textfieldWithIconRight:@"ic_close.png" withTextField:txtfield_setDestinationAddress];
        
        
    }
    else if ( ([self.btn_address.currentTitle isEqualToString: btn_searchSolutions_label]) || ([self.btn_address.currentTitle isEqualToString: btn_searchSolutions_continue]) )
    {
        sharedRoutes.invertAddresses_clicked = 0; //New ViewController, init variable
        
        sharedRoutes.origin_address = self.txtfield_startAddress.text;
        sharedRoutes.destination_address = self.txtfield_setDestinationAddress.text;
        
//        CLLocationCoordinate2D origin_coordinate = [self.mapView.annotations[0] coordinate];
//        CLLocationCoordinate2D destination_coordinate = [self.mapView.annotations[1] coordinate];
        CLLocationCoordinate2D origin_coordinate = [self.annotationViewStart coordinate];
        CLLocationCoordinate2D destination_coordinate = [self.annotationViewStop coordinate];

        
        CLLocationCoordinate2D coordinateArray[2];
        coordinateArray[0] = origin_coordinate;
        coordinateArray[1] = destination_coordinate;
        
        
//        NSLog(@"[mapView.annotations]origin_coordinate.longitude=%f",origin_coordinate.longitude);
//        NSLog(@"[mapView.annotations]origin_coordinate.latitude=%f",origin_coordinate.latitude);
//        
//        NSLog(@"[mapView.annotations]destination_coordinate.longitude=%f",destination_coordinate.longitude);
//        NSLog(@"[mapView.annotations]destination_coordinate.latitude=%f",destination_coordinate.latitude);

        NSLog(@"[self.annotationViews]origin_coordinate.longitude=%f",origin_coordinate.longitude);
        NSLog(@"[self.annotationViews]origin_coordinate.latitude=%f",origin_coordinate.latitude);
        
        NSLog(@"[self.annotationViews]destination_coordinate.longitude=%f",destination_coordinate.longitude);
        NSLog(@"[self.annotationViews]destination_coordinate.latitude=%f",destination_coordinate.latitude);
        
        NSArray *coords = [[NSArray alloc] initWithObjects:
                          [NSNumber numberWithFloat:origin_coordinate.longitude],
                          [NSNumber numberWithFloat:origin_coordinate.latitude],
                          [NSNumber numberWithFloat:destination_coordinate.longitude],
                          [NSNumber numberWithFloat:destination_coordinate.latitude],
                          nil];
    
        
        
    //    NSMutableArray *coordsMutuable = [NSMutableArray arrayWithObjects:coords_origin[0],coords_origin[1],coords_destination[0],coords_destination[1], nil];
        
      //  NSArray *coords2 = [NSArray arrayWithArray:coordsMutuable];
        
//        NSArray *coords_origin = [self coordinatesFromAddress:self.txtfield_startAddress.text];
//        NSArray *coords_destination = [self coordinatesFromAddress:self.txtfield_setDestinationAddress.text];
//        
//        NSMutableArray *coordsMutuable = [NSMutableArray arrayWithObjects:coords_origin[0],coords_origin[1],coords_destination[0],coords_destination[1], nil];
//        
//        NSArray *coords = [NSArray arrayWithArray:coordsMutuable];
        
        
        
        MKPlacemark *origin = [[MKPlacemark alloc]initWithCoordinate:origin_coordinate];//] addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];
        
        MKMapItem *originMapItem = [[MKMapItem alloc]initWithPlacemark:origin];
        //[originMapItem setName:@""];
        
        MKPlacemark *destination = [[MKPlacemark alloc]initWithCoordinate:destination_coordinate];// addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];
        
        MKMapItem *destinationMapItem = [[MKMapItem alloc]initWithPlacemark:destination];
        //[destinationMapItem setName:@""];
        
        //Coming As Passenger
        if (![self.previousViewController isEqualToString:@"Segment_OfferedTrip"] )
        {
            [self.btn_address setEnabled:NO];
            [self findTrips:coords];
        }
        else //coming as Driver
        {
            
            ride.coordinates = [NSArray arrayWithArray:coords];
                 
            ride.origin_address = self.txtfield_startAddress.text;
            ride.destination_address = self.txtfield_setDestinationAddress.text;
            
            [sharedRoutesAsDriver.rides addObject:ride];
            //?[self.navigationController performSegueWithIdentifier:@"segueCreateRide" sender:self];
        }
		
		NSMutableArray *mapItemArray = [[NSMutableArray alloc] init];
		for (MKPointAnnotation *point in self.annotationViewsWaypoints) {
			CLLocationCoordinate2D temp_coordinates = [point coordinate];
			MKPlacemark *temp_placemark = [[MKPlacemark alloc]initWithCoordinate:temp_coordinates];
			MKMapItem *temp_map_item = [[MKMapItem alloc]initWithPlacemark:temp_placemark];
			[mapItemArray addObject:temp_map_item];
		}
		
		sharedRoutesAsDriver.routeCoordinates_polyline = @"";
		
			if (self.annotationViewsWaypoints.count == 0){
				[self getDirections:originMapItem withDestination: destinationMapItem];
			}else{
				int k = 0;
				[self getDirections:originMapItem withDestination:[mapItemArray firstObject]];
				for (MKMapItem *mi in mapItemArray) {
					if (k==0){
						k++;
					}else{
						[self getDirections:[mapItemArray objectAtIndex:k-1] withDestination:[mapItemArray objectAtIndex:k]];
						k++;
					}
				}
				[self getDirections:[mapItemArray lastObject] withDestination:destinationMapItem];
				
			}
			dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
				if ([self.previousViewController isEqualToString:@"Segment_OfferedTrip"] )
					    {
					        [self.navigationController performSegueWithIdentifier:@"segueCreateRide" sender:self];
					        //Stop UIActivityIndicator
					        [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
					        [indicatorView stopAnimating];
					
					    }
				else
				{
					indicatorView = [myTools setActivityIndicator:self];
					[indicatorView startAnimating];
				}
			});
	
		
		

		
		
		
     /* //Display a straight forward line
        self.routeLineG = [MKPolyline polylineWithCoordinates:coordinateArray count:2];
        [self.mapView setVisibleMapRect:[self.routeLineG boundingMapRect]]; //If you want the route to be visible
        
        [self.mapView addOverlay:self.routeLineG];
     */
        
        
        
//        indicatorView = [myTools setActivityIndicator:self];
//        [indicatorView startAnimating];
    }
    
    
}

//#pragma mark - Geolocalisation from textfields.txt to coordinates
//-(NSArray *)coordinatesFromAddress : (NSString *) addressText
//{
//    NSMutableArray *coordsMutuable = [[NSMutableArray alloc]init];
//    
//    if (geocoder == nil)
//    {
//        geocoder = [[CLGeocoder alloc] init];
//    }
//    
//    [geocoder geocodeAddressString:addressText completionHandler:^(NSArray *placemarks, NSError *error)
//    {
//        
//        if (error)
//        {
//            NSLog(@"%@", error);
//        }
//        else
//        {
//        
//            CLPlacemark *clplacemark = [placemarks lastObject];
////            float spanX = 0.00725;
////            float spanY = 0.00725;
//            MKCoordinateRegion region;
//            region.center.latitude = clplacemark.location.coordinate.latitude;
//            region.center.longitude = clplacemark.location.coordinate.longitude;
//            
//            NSString *latitudeStr = [NSString stringWithFormat:@"%.6f",region.center.latitude];
//            
//            NSString *longitudeStr = [NSString stringWithFormat:@"%.6f",region.center.longitude];
//            
//            //NSLog(@"Latitude=%@",latitudeStr);
////            NSString *values[2];
////            values[0]= latitudeStr;
////            values[1]=longitudeStr;
////            NSArray *array = [NSArray arrayWithObjects:values count:2];
//            [coordsMutuable addObject:longitudeStr];
//            [coordsMutuable addObject:latitudeStr];
//            
//            NSLog(@"Longitude=%@ and Latitude=%@",longitudeStr,latitudeStr);
//            
//            
////            region.span = MKCoordinateSpanMake(spanX, spanY);
////            [self.mapView setRegion:region animated:YES];
//        }
//    }];
//    
//    NSArray *coordsArray = [NSArray arrayWithArray:coordsMutuable];
//    
//    return coordsArray;
//   
//}


#pragma mark - Find trips
- (void)findTrips: (NSArray *) coordinates
{
    
    //  case_call_API = 1;
    //1. Create URL
    NSString *ulrStr = commonData.BASEURL_FOR_TRIPS;
    
    /*
    ulrStr = [ulrStr stringByAppendingString:sharedProfile.userID];
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    NSLog(@"urlWitString=%@",urlWithString);
    */
    
    //Origin coordinates
    NSNumber *floatNumberX1 = [coordinates objectAtIndex:0];
    NSString *orignX1_str = [myTools convertFloatToString:floatNumberX1];
    sharedRoutes.origin_address_lon = orignX1_str;
    
    NSNumber *floatNumberY1 = [coordinates objectAtIndex:1];
    NSString *orignY1_str = [myTools convertFloatToString:floatNumberY1];
    sharedRoutes.origin_address_lat = orignY1_str;
    
    //Destination coordinates
    NSNumber *floatNumberX2 = [coordinates objectAtIndex:2];
    NSString *orignX2_str  = [myTools convertFloatToString:floatNumberX2];
    sharedRoutes.destination_address_lon = orignX2_str;
    
    NSNumber *floatNumberY2 = [coordinates objectAtIndex:3];
    NSString *orignY2_str = [myTools convertFloatToString:floatNumberY2];
    sharedRoutes.destination_address_lat = orignY2_str;
    
//    float yourFloat = [yourFloatNumber floatValue];
//    NSString *originXstr = [NSString stringWithFormat:@"%f", [coordinates objectAtIndex:0]];
    
    NSString *route  = @"start_lat=";
    route = [route stringByAppendingString:orignY1_str];
    
    route = [route stringByAppendingString:@"&start_lon="];
    route = [route stringByAppendingString:orignX1_str];
    
    route = [route stringByAppendingString:@"&end_lat="];
    route = [route stringByAppendingString:orignY2_str];
    
    route = [route stringByAppendingString:@"&end_lon="];
    route = [route stringByAppendingString:orignX2_str];
    
    //Create timestamps
    NSTimeInterval start_timeTimeInterval = [[NSDate date] timeIntervalSince1970];
    long start_timeInseconds = (long) (start_timeTimeInterval);
    
    NSString *startTime = [NSString stringWithFormat:@"%ld",start_timeInseconds];
    sharedRoutes.starTimeStampTrip = startTime;
    
    //2hours = 120 min = 7200secs
    long end_timeInseconds = (long) start_timeInseconds + 7200;
    NSString *endTime = [NSString stringWithFormat:@"%ld",end_timeInseconds];
    
    //Create transports
    NSString *transports = @"&use_bus=false&use_metro=true&use_train=true";
    
    //Create transfer_mode
    NSString *transfer_mode = @"&transfer_mode=CHEAPEST_ROUTE";
    
    //Create string for request
    
    NSString *createParams = [@"&start_date=" stringByAppendingString:startTime];
   // NSString *createParams = @"&start_date=1498383689"; //Use 12:47 test value in order to get always CAR POOLING
    ////Demo below to get routes with Social Car drivers
  //?  NSString *createParams = @"&start_date=1500400479"; //Use 20:47
    
    createParams = [createParams stringByAppendingString:@"&end_date="];
    createParams = [createParams stringByAppendingString:endTime];
    createParams = [createParams stringByAppendingString:transports];
    createParams = [createParams stringByAppendingString:transfer_mode];
    
    //route = [route stringByAppendingString:@"&start_date=1465480828&end_date=1465498800&use_bus=false&use_metro=true&use_train=true&transfer_mode=CHEAPEST_ROUTE"];
    
    route = [route stringByAppendingString:createParams];
    
  
    
  //  NSString *route2 = @"start_lat=41.89&start_lon=12.51&end_lat=41.69&end_lon=12.60&start_date=1465480828&end_date=1465498800&use_bus=false&use_metro=true&use_train=true&transfer_mode=CHEAPEST_ROUTE";
    
    
    ulrStr = [ulrStr stringByAppendingString:route];
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    NSLog(@"urlWitString=%@",urlWithString);
    
/* //As delegate
    sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];

    [sessionConfiguration setHTTPAdditionalHeaders:@{  @"Accept" : @"application/json", @"Content-Type" : @"application/json", @"Authorization" : sharedProfile.authCredentials }];
    
    [sessionConfiguration setTimeoutIntervalForRequest:100];
    
    //4. Create Session delegate
    sharedProfile.sessionGlobal = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate: self delegateQueue: [NSOperationQueue mainQueue]];
*/
    /*An operation queue for scheduling the delegate calls and completion handlers. The queue should be a serial queue, in order to ensure the correct ordering of callbacks. If nil, the session creates a serial operation queue for performing all delegate method calls and completion handler calls.*/
    
    //2. Create and send Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //3. Set HTTP Headers and HTTP Method
    [urlRequest setValue:sharedProfile.authCredentials forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //4. Set HTTP Method
    [urlRequest setHTTPMethod:HTTP_METHOD_GET];//@"GET"];
    
    //7. Send Request to Server
 //?   NSURLSessionDataTask *dataTask = [sharedProfile.sessionGlobal dataTaskWithRequest:urlRequest];
 //?   [dataTask resume];
    
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      if (data != nil)
                                      {
                                          NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                      
                                      
                                          NSLog(@"ParseJson[findTrips] =%@", parseJSON);
                                      
                                          [self fill_Trips:parseJSON];
                                      }
                                      else
                                      {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              
                                              //Stop UIActivityIndicator
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
                                              [indicatorView stopAnimating];
                                              
                                              [self.btn_address setEnabled:YES];
                                              
                                              NSString *message_title = NSLocalizedString(@"Cannot connect to server!Please,try again later.", @"Cannot connect to server!Please,try again later.");
                                              NSString *ok = NSLocalizedString(@"OK", @"OK");
                                              
                                              UIAlertController *alertNoRoutes = [UIAlertController
                                                                                  alertControllerWithTitle:message_title
                                                                                  message:@""
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                                              
                                              UIAlertAction *okAction = [UIAlertAction
                                                                         actionWithTitle:ok
                                                                         style:UIAlertActionStyleDefault
                                                                         handler:^(UIAlertAction * action)
                                                                         {
                                                                             [alertNoRoutes dismissViewControllerAnimated:YES completion:nil];
                                                                         }];
                                              [alertNoRoutes addAction:okAction];
                                              [self presentViewController:alertNoRoutes animated:NO completion:nil];
                                          });
                                      }

                                  }];
    [task resume];
    //8. Start UIActivityIndicatorView for GUI purposes
//    indicatorView = [myTools setActivityIndicator:self];
//    [indicatorView startAnimating];
    
}

                                  
#pragma mark - Fill Trips Object
-(void) fill_Trips: (NSDictionary *)parseJSON
{
    if ( [parseJSON objectForKey:@"_error"])
    {
        NSString *str = [parseJSON objectForKey:@"_issues"];
        NSString *strFormatted = [NSString stringWithFormat: @"%@",str];
        
        NSLog(@"_issues(strFormatted)=%@",strFormatted);
        
    //    sharedProfile.userID = @""; //set to none
        
        NSDictionary *errorDict = [parseJSON valueForKey:@"_error"];
        //NSArray *userIDArray = [ns valueForKey:@"message"];
        NSString *error_message = [errorDict valueForKey:@"message"];
        
        NSLog(@"error_message=%@",error_message);
        
        NSString *message_title = NSLocalizedString(@"Authentication error", @"Authentication error");
        NSString *ok = NSLocalizedString(@"OK", @"OK");
        
        UIAlertController *alertAuthenticationError = [UIAlertController
                                                       alertControllerWithTitle:message_title
                                                       message:error_message
                                                       preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:ok
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       [alertAuthenticationError dismissViewControllerAnimated:YES completion:nil];
                                   }];
        [alertAuthenticationError addAction:okAction];
        [self presentViewController:alertAuthenticationError animated:NO completion:nil];
    }
    else
    {
        
        NSArray *trips = [parseJSON valueForKey:@"trips"];
        //arrRoutesSocialCar = trips;
        
        //Assign trips reteived from Call to sharedObject
        sharedRoutes.tripsBE = trips;
        
        if ( (trips != nil) && (trips.count != 0) )
        {
         
            //Update GUI with safe-thread
            //Since UIKit is not thread safe, need to dispatch back to main thread to update UI
            //From : https://stackoverflow.com/questions/28302019/getting-a-this-application-is-modifying-the-autolayout-engine-from-a-background
           
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //Stop UIActivityIndicator
                [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
                [indicatorView stopAnimating];
                
                [self.btn_address setEnabled:YES];

                
                [self.navigationController
                 performSegueWithIdentifier:@"showSegueRoutes" sender:self];
                
                //The view controller associated with the currently visible view in the navigation interface
                RouteViewController *routeViewController = (RouteViewController *)self.navigationController.visibleViewController;
                
                //Pass array values
                routeViewController.getRoutes = [NSArray arrayWithArray:arrRoutes];
                
                //Apple 's routing
                //[routeViewController displayRoutes:arrRoutes];
                
                //show navigation Bar Button Item
                //self.navigationItem.rightBarButtonItem = self.nextBarBtnItem;
                
                HomeSegmentsViewController *homeSegments = (HomeSegmentsViewController *)self.parentViewController;
                
                homeSegments.navigationItem.rightBarButtonItem = homeSegments.nextBarBtnItem;
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //Stop UIActivityIndicator
                [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
                [indicatorView stopAnimating];
                
                [self.btn_address setEnabled:YES];
                
                //***************************
                
                [self.navigationController
                 performSegueWithIdentifier:@"showSegueRoutes" sender:self];
                
                //The view controller associated with the currently visible view in the navigation interface
                RouteViewController *routeViewController = (RouteViewController *)self.navigationController.visibleViewController;
                
              //?  routeViewController.getRoutes = [NSArray arrayWithArray:arrRoutes];
                
                //***************************
                
                
              /*  NSString *message_title = NSLocalizedString(@"No routes available.", @"No routes available.");
                NSString *ok = NSLocalizedString(@"OK", @"OK");
                
                UIAlertController *alertNoRoutes = [UIAlertController
                                                    alertControllerWithTitle:message_title
                                                    message:@""
                                                    preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction
                                           actionWithTitle:ok
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action)
                                           {
                                               [alertNoRoutes dismissViewControllerAnimated:YES completion:nil];
                                           }];
                [alertNoRoutes addAction:okAction];
                [self presentViewController:alertNoRoutes animated:NO completion:nil];
               */
            });
               
                
        }
        
    }

}



#pragma mark Routes from Apple
/*
 Get directions with two MKMapItems
 see:http://www.technetexperts.com/mobile/draw-route-between-2-points-on-map-with-ios7-mapkit-api/

 */
- (void)getDirections: (MKMapItem *)originMapItem withDestination:(MKMapItem *)destinationMapItem
{
    MKDirectionsRequest *request =  [[MKDirectionsRequest alloc] init];
    
    [request setSource:originMapItem];

    [request setDestination:destinationMapItem];
    //[request setTransportType:MKDirectionsTransportTypeWalking];
    
    MKDirections *direction = [[MKDirections alloc]initWithRequest:request];
    
   
 
    [direction calculateDirectionsWithCompletionHandler:
        ^(MKDirectionsResponse *response, NSError *error)
    {
         if (error) {
             // Handle error
         } else {
            [self showRoute:response];
         }
     }];
  
}


-(void)showRoute:(MKDirectionsResponse *)response
{
    /*for (MKRoute *route in response.routes)
    {
        [self.mapView addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"%@", step.instructions);
        }
    }*/
    
  //  NSLog(@"response = %@",response);
    
    arrRoutes = [response routes];
    
    [arrRoutes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    {
        //Remove previous overlays if exist
//        if (self.mapView.overlays !=nil)
//        {
//            [self.mapView removeOverlays:self.mapView.overlays];
//        }

        MKRoute *route = obj;
        MKPolyline *line = [route polyline];
        
        //route is the MKRoute in this example
        //but the polyline can be any MKPolyline
        if ([self.previousViewController isEqualToString:@"Segment_OfferedTrip"] )
        {
            NSUInteger pointCount = route.polyline.pointCount;
        
            //allocate a C array to hold this many points/coordinates...
            CLLocationCoordinate2D *routeCoordinates
                = malloc(pointCount * sizeof(CLLocationCoordinate2D));
      
            //get the coordinates (all of them)...
            [route.polyline getCoordinates:routeCoordinates
                                 range:NSMakeRange(0, pointCount)];
        
            //this part just shows how to use the results...
            NSLog(@"route pointCount = %lu", pointCount);
			
			NSString *coordinatesPolylineStr = @"";
			if ([sharedRoutesAsDriver.routeCoordinates_polyline isEqualToString:@""]) {
				coordinatesPolylineStr = @"coordinates=";
				for (int c=0; c < pointCount; c++)
				{
					/*NSLog(@"routeCoordinates[%d] = %f, %f",
					 c, routeCoordinates[c].latitude, routeCoordinates[c].longitude);*/
					
					coordinatesPolylineStr = [coordinatesPolylineStr stringByAppendingString:[NSString stringWithFormat:@"%.6f", routeCoordinates[c].longitude]];
					
					coordinatesPolylineStr = [coordinatesPolylineStr stringByAppendingString:@";"];
					
					coordinatesPolylineStr = [coordinatesPolylineStr stringByAppendingString:[NSString stringWithFormat:@"%.6f", routeCoordinates[c].latitude]];
					
					if (c != (pointCount -1) )
					{
						coordinatesPolylineStr = [coordinatesPolylineStr stringByAppendingString:@","];
					}
					
				}
			}else{
				coordinatesPolylineStr = [NSString stringWithFormat:@"%@,", sharedRoutesAsDriver.routeCoordinates_polyline];
				for (int c=3; c < pointCount-2; c++)
				{
					/*NSLog(@"routeCoordinates[%d] = %f, %f",
					 c, routeCoordinates[c].latitude, routeCoordinates[c].longitude);*/
					
					coordinatesPolylineStr = [coordinatesPolylineStr stringByAppendingString:[NSString stringWithFormat:@"%.6f", routeCoordinates[c].longitude]];
					
					coordinatesPolylineStr = [coordinatesPolylineStr stringByAppendingString:@";"];
					
					coordinatesPolylineStr = [coordinatesPolylineStr stringByAppendingString:[NSString stringWithFormat:@"%.6f", routeCoordinates[c].latitude]];
					
					if (c != (pointCount -1) )
					{
						coordinatesPolylineStr = [coordinatesPolylineStr stringByAppendingString:@","];
					}
					
				}
			}
			
			
			
            sharedRoutesAsDriver.routeCoordinates_polyline = coordinatesPolylineStr;
            
            //free the memory used by the C array when done with it...
            free(routeCoordinates);
        }
        
      //  line getCoordinates:(nonnull CLLocationCoordinate2D *) range:<#(NSRange)#>

        //let coordinates = [CLLocationCoordinate2D(latitude: 40.2349727, longitude: -3.7707443),
//                           CLLocationCoordinate2D(latitude: 44.3377999, longitude: 1.2112933)]
//        
//        let polyline = Polyline(coordinates: coordinates)
//        let encodedPolyline: String = polyline.encodedPolyline

        
        // Or for a functional approach :
      //  let encodedPolyline: String = encodeCoordinates(coordinates)
        
       // NSLog(@"MKpolyine object=%@",line);
        [self.mapView addOverlay:line];
     
 //       NSDictionary *routeDictionary = [arrRoutes lastObject];
        
        //EDW TO WORK !!!!!!!!!!
      /*  if (routeDictionary)
        {
            NSString *overviewPolyline = [[routeDictionary objectForKey: @"overview_polyline"] objectForKey:@"points"];
         
            NSMutableArray *path = [self decodePolyLine:overviewPolyline];
            NSLog(@"polyline value =%@",path);
        }
        */
        /*
        NSLog(@"Route Name : %@",route.name);
        NSLog(@"Total Distance (in Meters) :%f",route.distance);
        
        NSArray *steps = [route steps];
        
        NSLog(@"Total Steps : %lu",(unsigned long)[steps count]);
        
        [steps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
        {
            NSLog(@"Route Instruction : %@",[obj instructions]);
            NSLog(@"Route Distance : %f",[obj distance]);
        }];*/
    }];
    

	
    
    
   
    
/* //You cna remove this comment; used to go to next screen after receiving routes from Apple
 
    [self.navigationController
     performSegueWithIdentifier:@"showSegueRoutes" sender:self];
    
    //The view controller associated with the currently visible view in the navigation interface
    RouteViewController *routeViewController = (RouteViewController *)self.navigationController.visibleViewController;
   // [routeViewController hello:@"Test"];
     //Pass array values
    routeViewController.getRoutes = [NSArray arrayWithArray:arrRoutes];
//?    [routeViewController displayRoutes:arrRoutes];
    
    //Stop UIActivityIndicator
    [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    [indicatorView stopAnimating];
    
    //show navigation Bar Button Item
    //self.navigationItem.rightBarButtonItem = self.nextBarBtnItem;
    HomeSegmentsViewController *homeSegments = (HomeSegmentsViewController *)self.parentViewController;
    
    homeSegments.navigationItem.rightBarButtonItem = homeSegments.nextBarBtnItem;
 */
}



#pragma mark - Encoded Polyline Algorithm Format used by Google provided by Ankit Srivastava
-(NSMutableArray *)decodePolyLine:(NSString *)encodedStr
{
    NSMutableString *encoded = [[NSMutableString alloc] initWithCapacity:[encodedStr length]];

    [encoded appendString:encodedStr];
    [encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
                                options:NSLiteralSearch
                                  range:NSMakeRange(0, [encoded length])];
    NSInteger len = [encoded length];
    NSInteger index = 0;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger lat=0;
    NSInteger lng=0;
    while (index < len) {
        NSInteger b;
        NSInteger shift = 0;
        NSInteger result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lat += dlat;
        shift = 0;
        result = 0;
        do {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lng += dlng;
        NSNumber *latitude = [[NSNumber alloc] initWithFloat:lat * 1e-5];
        NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-5];
        
        CLLocation *location = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
        [array addObject:location];
    }
    
    return array;
}


#pragma mark End of Routes from Apple


-(void)zoomToPolyLine: (MKMapView*)map polyline: (MKPolyline*)polyline animated: (BOOL)animated
{
    //top left bottom right
    [map setVisibleMapRect:[polyline boundingMapRect] edgePadding:UIEdgeInsetsMake(15.0, 20.0, 15.0, 20.0) animated:animated];
}

#pragma mark MKMapViewDelegate
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    
    //[self zoomToPolyLine:self.mapView polyline:renderer.polyline animated:YES];
    //renderer.polyline
    
    return renderer;
}



/*
 - (void)mapViewDidStopLocatingUser:(MKMapView *)mapView
 {
 MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
 point.coordinate = placemark.location.coordinate;
 [self.mapView addAnnotation:point];
 }*/

//Whenthe showsUserLocation property is set to YES :
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
     NSLog(@"\n\n[didUpdateUserLocation]...");
    //*********>>>>>CASE WHERE DESTINATION IS FILLED and MKUserLocation added to mapView.annotations
	
        for (int i=0;i<self.mapView.annotations.count;i++)
        {
            if ([self.mapView.annotations[i] isKindOfClass:[MKUserLocation class]])
            {
				[self.mapView removeAnnotation:self.mapView.annotations[i]];
                break;
            }
        }
        
        //Now replace annotationViews 0 item with MKUserLocation found in mapView.annotations
		self.annotationViewStart = [[MKPlacemark alloc]initWithCoordinate:userLocation.coordinate];
	
    
}


//-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MyCustomAnnotation class]]) //if it is my custom pin class
//    {
//        MyCustomAnnotation *myLocation = (MyCustomAnnotation *) annotation;
//        NSString *identifier = [annotation title];
//
//        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier] ;//]@"MyCustomAnnotation"];
//        
//        if (annotationView == nil)
//            annotationView = [myLocation annotationView:self.addressStatus];
//        else
//            annotationView.annotation = annotation;
//        
//        return annotationView;
//    }
//    else
//    {
//        return nil;
//    }
//    
//}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
{
   
    MKAnnotationView *pinView = nil;
   
    NSString *pinID;
    
    pinID = [self.mapItem.placemark title];
    
    NSLog(@"pinID=%@",pinID);

    if(annotation != mapView.userLocation)
    {
        pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinID];
        
        if ( pinView == nil )
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:pinID]; //nil];
            
            NSLog(@"************ CREATE PIN VIEW - not existing one ************");
            
            pinView.canShowCallout = YES;
			
            if (annotation == self.annotationViewStart)
            {
                    pinView.image = [UIImage imageNamed:@"ic_starting_point.png"];
			}
            else if (annotation == self.annotationViewStop)
            {
                pinView.image = [UIImage imageNamed:@"ic_destination_point.png"];
			}
			if ([self.annotationViewsWaypoints containsObject:annotation]) {
				pinView.image = [UIImage imageNamed:@"pin_waypoint.png"];
			}
        }
        else //Deque if it is already exist but change icon
        {
            pinView.annotation = annotation;
            
            NSLog(@"********** EXISTING PIN VIEW ************");
			
			pinView.canShowCallout = YES;
			
			if (annotation == self.annotationViewStart)
			{
				pinView.image = [UIImage imageNamed:@"ic_starting_point.png"];
			}
			else if (annotation == self.annotationViewStop)
			{
				pinView.image = [UIImage imageNamed:@"ic_destination_point.png"];
			}
			if ([self.annotationViewsWaypoints containsObject:annotation]) {
				pinView.image = [UIImage imageNamed:@"pin_waypoint.png"];
			}
        }
    }
    else if (annotation == mapView.userLocation)
    {
        pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinID];
        
        if ( pinView == nil )
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:pinID]; //nil];
            NSLog(@"************ CREATE NEW PIN VIEW FOR USER LOCATION  ************");
            pinView.canShowCallout = YES;
        }
        else
        {
            NSLog(@"************ CREATE EXISTING PIN VIEW FOR USER LOCATION ************");
            pinView.annotation = annotation;
        }
        
        pinView.image = [UIImage imageNamed:@"ic_starting_point.png"];
    }

    return pinView;
//}
  //  return nil;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views
{
    
    //? self.mapItems = [[NSArray alloc] initWithArray:self.mapView.annotations copyItems:YES];
    
    NSLog(@"[didAddAnnotationsViews].....");
    NSLog(@"self.addressStatus= %d",self.addressStatus);
    
}
	
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
	
	MKPolylineView *polyLineView = [[MKPolylineView alloc] initWithPolyline:self.mapView.overlays[0]];
	polyLineView.fillColor = [UIColor blueColor];
	polyLineView.strokeColor = [UIColor greenColor];
	polyLineView.lineWidth = 7;
	return polyLineView;
}


#pragma mark  Button current location pressed
- (IBAction)btn_current_location:(id)sender
{
    //Location settings
	self.mapView.showsUserLocation = YES;
    self.locationManager = [[CLLocationManager alloc] init];
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.locationManager requestWhenInUseAuthorization];
        
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        
        // Set a movement threshold for new events.
        self.locationManager.distanceFilter = 500; // meters //see that
        
        [self.locationManager startUpdatingLocation];
        
        self.mapView.showsUserLocation = YES;
        [self.mapView setZoomEnabled:YES];
        [self.mapView setUserTrackingMode:MKUserTrackingModeFollow];
        
        self.txtfield_startAddress_previous_text = self.txtfield_startAddress.text;
        self.txtfield_startAddress.text =@"Current location";
        //For viewForAnnotation method inorder to get A icon in the map
        //self.addressStatus = 0;
        
        [self.locationManager stopUpdatingLocation];  //see that!!
        
    }
}

#pragma mark - CLLocationManagerDelegate
//From CLLocationManagerDelegate
/*
 Tells the delegate that the location manager was unable to retrieve a location value.
 */
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSString *error_title = NSLocalizedString(@"Error", @"Error");
    NSString *ok= NSLocalizedString(@"OK", @"OK");
    
    UIAlertController *alertOK   =   [UIAlertController
                                      alertControllerWithTitle:error_title
                                      message:error.description
                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:ok
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [alertOK dismissViewControllerAnimated:YES completion:nil];
                                   
                               }];
    
    [alertOK addAction:okAction];
    [self presentViewController:alertOK animated:NO completion:nil];
    
}

//From CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{

//    CLLocation *crnLoc = [locations lastObject];
//    if (crnLoc !=nil)
//    {
//
//
//			if (self.annotationViewStart)
//			{
//				[self.mapView removeAnnotation:self.annotationViewStart];
//			}
//
//			//Now find whether MKUser Location is at position 0 or 1
//			int posUserLocationInAnnotationList = 0;
//
//			for (int i=0;i<self.mapView.annotations.count;i++)
//			{
//				if ([self.mapView.annotations[i] isKindOfClass:[MKUserLocation class]])
//				{
//					NSLog(@"Instace of MKUserLocation class found!!!!");
//
//					posUserLocationInAnnotationList = i;
//					NSLog(@"posUserLocationInAnnotationList=%d",posUserLocationInAnnotationList);
//
//					break;
//				}
//			}
//
//			//Now replace annotationViews 0 item with MKUserLocation found in mapView.annotations
//			self.annotationViewStart = [[MKPlacemark alloc]initWithCoordinate:crnLoc.coordinate];
//
//
//
//        NSString *longit_lat = [NSString stringWithFormat:@"%.8f - %.8f",crnLoc.coordinate.longitude,crnLoc.coordinate.latitude];
//
//        self.txtfield_startAddress.text = longit_lat;
        //self.txtfield_startAddress.backgroundColor = [UIColor clearColor];
        
        
          /*  MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            //point.coordinate = placemark.location.coordinate;
            point.coordinate = crnLoc.coordinate;
            [self.mapView addAnnotation:point];
            */
         //   [self.mapView selectAnnotation:point animated:YES];
            
            /*
            [self.mapView setCenterCoordinate:point.coordinate animated:YES];
            [self.mapView setUserTrackingMode:MKUserTrackingModeNone];
             */
            
	
        
        // Stop Location Manager
   //?     [locationManager stopUpdatingLocation];
    
}


#pragma mark Reverse Geocoding
-(void) reverseGeocoding:(CLLocation *)crnLoc
{
    //CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    if (geocoder == nil)
    {
        geocoder = [[CLGeocoder alloc] init];
    }
    
    [geocoder reverseGeocodeLocation:crnLoc completionHandler:^(NSArray *placemarks, NSError *error)
    {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        
        if (error == nil && [placemarks count] > 0)
        {
            placemark = [placemarks lastObject];
            /*self.addressLabel.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
             placemark.subThoroughfare, placemark.thoroughfare,
             placemark.postalCode, placemark.locality,
             placemark.administrativeArea,
             placemark.country]; */
            //placemark.subThoroughfare - Street Number
            NSString *address = [NSString stringWithFormat:@"%@,%@,%@",
                                 placemark.thoroughfare,
                                 placemark.postalCode, placemark.locality];
         
         
         
            if (self.addressStatus == 0)
            {
                self.txtfield_startAddress.text = address;
            }
            else if (self.addressStatus == 1)
            {
                self.txtfield_setDestinationAddress.text = address;
            }
            
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            point.coordinate = placemark.location.coordinate;
            [self.mapView addAnnotation:point];
            
            //Stick position on the map
            // Create an editable PointAnnotation, using placemark's coordinates, and set your own title/subtitle
            /* MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
             point.coordinate = placemark.location.coordinate;
             
             point.title = @"My Location";
             //point.subtitle = @"Sample Subtitle";
             
             
             // Set your region using placemark (not point)
             MKCoordinateRegion region = self.mapView.region;
             region.center = placemark.region.center;
             region.span.longitudeDelta /= 8.0;
             region.span.latitudeDelta /= 8.0;
             
             // Add point (not placemark) to the mapView
             [self.mapView setRegion:region animated:YES];
             [self.mapView addAnnotation:point];
             
             // Select the PointAnnotation programatically
             [self.mapView selectAnnotation:point animated:NO];
             */
        }
        else
        {
            NSLog(@"%@", error.debugDescription);
        }
    }];

}

- (IBAction)nextItem_pressed:(id)sender {
    
    NSLog(@"Next Bar Button Item pressed!");
   
    [self.navigationController performSegueWithIdentifier:@"showSegueRoutes" sender:self];
}

#pragma mark - NSURLSessionDataDelegate methods
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    NSLog(@"### handler ");
    
    completionHandler(NSURLSessionResponseAllow);
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    
    NSError *jsonError;
    
    NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:&jsonError];
    NSLog(@"parseJSON = %@", parseJSON);
    
   
    if ( [parseJSON objectForKey:@"_error"])
    {
        NSString *str = [parseJSON objectForKey:@"_issues"];
        NSString *strFormatted = [NSString stringWithFormat: @"%@",str];
        
        NSLog(@"_issues(strFormatted)=%@",strFormatted);
        
   //     sharedProfile.userID = @""; //set to none
        
        NSDictionary *errorDict = [parseJSON valueForKey:@"_error"];
        //NSArray *userIDArray = [ns valueForKey:@"message"];
        NSString *error_message = [errorDict valueForKey:@"message"];
        
        NSLog(@"error_message=%@",error_message);
        
        NSString *message_title = NSLocalizedString(@"Authentication error", @"Authentication error");
        NSString *ok = NSLocalizedString(@"OK", @"OK");
        
        UIAlertController *alertAuthenticationError = [UIAlertController
                                                       alertControllerWithTitle:message_title
                                                       message:error_message
                                                       preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:ok
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       [alertAuthenticationError dismissViewControllerAnimated:YES completion:nil];
                                   }];
        [alertAuthenticationError addAction:okAction];
        [self presentViewController:alertAuthenticationError animated:NO completion:nil];
    }
    else
    {
        if (case_call_API == 1)
        {
           // NSLog(@"Ok!");
            
            NSArray *trips = [parseJSON valueForKey:@"trips"];
            //arrRoutesSocialCar = trips;
           
            //Assign trips reteived from Call to sharedObject
            sharedRoutes.tripsBE = trips;
            
            
            if ( (trips != nil) && (trips.count != 0) )
            {
                [self.navigationController
             performSegueWithIdentifier:@"showSegueRoutes" sender:self];
            
                //The view controller associated with the currently visible view in the navigation interface
                RouteViewController *routeViewController = (RouteViewController *)self.navigationController.visibleViewController;
            
                //Pass array values
                routeViewController.getRoutes = [NSArray arrayWithArray:arrRoutes];
     
                //Apple 's routing
                //[routeViewController displayRoutes:arrRoutes];
                
            //show navigation Bar Button Item
            //self.navigationItem.rightBarButtonItem = self.nextBarBtnItem;
            
                HomeSegmentsViewController *homeSegments = (HomeSegmentsViewController *)self.parentViewController;
            
                homeSegments.navigationItem.rightBarButtonItem = homeSegments.nextBarBtnItem;
            }
            else
            {
                NSString *message_title = NSLocalizedString(@"No routes available.", @"No routes available.");
                NSString *ok = NSLocalizedString(@"OK", @"OK");
                
                UIAlertController *alertNoRoutes = [UIAlertController
                                                               alertControllerWithTitle:message_title
                                                 message:@""
                                                 preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction
                                           actionWithTitle:ok
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction * action)
                                           {
                                               [alertNoRoutes dismissViewControllerAnimated:YES completion:nil];
                                           }];
                [alertNoRoutes addAction:okAction];
                [self presentViewController:alertNoRoutes animated:NO completion:nil];

            }
            
        }
        
        
    }
  
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    [indicatorView stopAnimating];
    [self.btn_address setEnabled:YES];
    
    if(error == nil)
    {
        NSLog(@"Task finished succesfully!");
    }
    else
    {
        NSLog(@"Error %@",[error userInfo]);
        
        NSDictionary *errorDictionary =[error userInfo];
        NSString *errorMessage = [errorDictionary valueForKey:@"NSLocalizedDescription"];
        
        //? NSString *message_title = NSLocalizedString(@"No internet connection!", @"No internet connection!");
        NSString *ok = NSLocalizedString(@"OK", @"OK");
        
        UIAlertController *alertConnectionError = [UIAlertController
                                                   alertControllerWithTitle:errorMessage
                                                   message:@""
                                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:ok
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       [alertConnectionError dismissViewControllerAnimated:YES completion:nil];
                                   }];
        [alertConnectionError addAction:okAction];
        [self presentViewController:alertConnectionError animated:NO completion:nil];

        
        
    }
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)btnItem_right_pressed:(id)sender
{
    if ([self.previousViewController isEqualToString:@"Segment_OfferedTrip"] )
    {
        [self.navigationController performSegueWithIdentifier:@"segueCreateRide" sender:self];
    }
}
@end
