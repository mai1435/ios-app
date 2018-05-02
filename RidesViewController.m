//
//  RidesViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou on 27/07/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import "RidesViewController.h"

//#define BUTTON_ADD_TRIP ((int) 1001)


@interface RidesViewController ()

@end

@implementation RidesViewController

- (void)viewDidLoad
{
[super viewDidLoad];
	UINib *cellNib = [UINib nibWithNibName:@"RideCell" bundle:nil];
	[self.tabelView registerNib:cellNib forCellReuseIdentifier:@"rideCellIdentifier"];
}
    // Do any additional setup after loading the view.
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[super viewDidLoad];
   
    sharedProfile = [SharedProfileData sharedObject];
    sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];
    sharedRoutesAsPassenger = [SharedRoutesAsPassenger sharedRoutesAsPassengerObject];
    
    myTools = [[MyTools alloc]init];
    commonData = [[CommonData alloc]init];
    [commonData initWithValues];
    
    //Get Rides
    rides = [[NSMutableArray alloc]init];
    rides = [sharedRoutesAsDriver rides];
	
	
   // cell_mapViews = [[NSMutableArray alloc]init];
   //? NSUInteger cnt = rides.count;
    //?cell_mapViews = [NSMutableArray arrayWithCapacity:cnt];
    
    //NSUInteger cnt = rides.count;
    //cell_mapViews = [[NSMutableArray alloc]init];
    

    //Make button circle
 //   self.btn_add_new_trip.layer.masksToBounds = true;
 //   self.btn_add_new_trip.layer.cornerRadius = self.btn_add_new_trip.frame.size.width/2;
    
    
 //   [self.tabelView setRowHeight:375.0f];//195.0f];
    [self.tabelView reloadData];
    
    self.title = NSLocalizedString(@"Rides", @"Rides");
    
    getStatus_btn_more_detailsClicked = [[NSMutableArray alloc]init];
	//[[MyTools new] hideNavigationControllerRelativeBar:self.navigationController];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"rideCellIdentifier";
//    NSString *yes = NSLocalizedString(@"Yes", @"Yes");
//    NSString *no = NSLocalizedString(@"No", @"No");
    
    
	RideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	
    Ride *ride = [[Ride alloc]init];
    ride = [rides objectAtIndex:indexPath.row];
    
    
    
    cell.label_ride_title.text = ride.name;
    cell.label_date_time.text = [myTools convertTimeStampToStringWithFormatDetailed:ride.ride_date];
    
    ///By default
    cell.constraint_stackView_avatar_height.constant = 0.0f;
    [cell.image_avatar_passenger setHidden:YES];
    
    //Get passenger image from Lift exists in Ride
    NSMutableArray *lifts = [[NSMutableArray alloc]init];
    lifts = ride.lifts;
	
    if (lifts.count != 0)
    {
		bool check = false;
		for (Lift* l  in lifts) {
			if (l.passenger_image!=NULL&&![l.passenger_image isEqualToString:@""]) {
				check = true;
			}
		}
		if (check) {
			[self displayPassengerPictures:cell withLifts:lifts];
		}
    }
   
    //Assign selector for each switch
    cell.switch_status.tag = indexPath.row;
    
    [cell.switch_status addTarget:self action:@selector(switch_statusClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([ride.activated isEqualToString:@"1"])
    {
        [cell.switch_status setOn:YES];
    }
    else if ([ride.activated isEqualToString:@"0"])
    {
        [cell.switch_status setOn:NO];
    }
    
    //Assign selector for each delete button
    cell.btn_delete_trip.tag = indexPath.row;
    
    [cell.btn_delete_trip addTarget:self action:@selector(btn_delete_tripClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //Assign selector for each mode_details button
    cell.btn_more_details.tag = indexPath.row;
    
    [cell.btn_more_details addTarget:self action:@selector(btn_more_detailsClicked:) forControlEvents:UIControlEventTouchUpInside];
	
	cell.showMapView.tag = indexPath.row;
	[cell.showMapView addTarget:self action:@selector(btn_show_mapClicked:) forControlEvents:UIControlEventTouchUpInside];

    // cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
    //mapView
//    if (cell.mapView.overlays != nil)
//    {
//        [cell.mapView removeOverlays:cell.mapView.overlays];
//    }
    
 /*   MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.01);
    
    double start_x = [ride.start_point_lon doubleValue];
    
    double start_y = [ride.start_point_lat doubleValue];
    
    CLLocationCoordinate2D logCord = CLLocationCoordinate2DMake(start_x, start_y);
    MKCoordinateRegion region = MKCoordinateRegionMake(logCord, span);
   
    [cell.mapView setRegion:region animated:YES];
    */
   // cell.mapView.delegate = self;
   // current_cell_index = (int)indexPath.row;
	
	
	/*MKPolyline *polyline = [self polylineWithEncodedString:ride.polyline];
	cell.mapView.delegate = self;
	cell.mapView.userInteractionEnabled = NO;
   // dispatch_async(dispatch_get_main_queue(), ^{
	[cell.mapView removeOverlays:cell.mapView.overlays];

	[cell.mapView addOverlay:polyline];*/
	
      //  indicatorView = [myTools setActivityIndicator:self];
       // [indicatorView startAnimating];
   // });
   
    ///////////////////
   // MKMapView *map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 220, 70)];
    
    
    
   
   //? [cell.contentView addSubview:map];
    
    /////////////////
    
    
    
   //cell.constraint_stackView_mapView_height.constant = 0.0f;
    
    NSString *status_init=@"0";
    
    [getStatus_btn_more_detailsClicked addObject:status_init];
    
	
    return cell;
}
/*
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float heightForCell = 195.0f;//default value
    
    if (indexPath.row ==2)
    {
        heightForCell = 375.0f;
        
    }
    
    return  heightForCell;
    
}
*/
//- (NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView
//{
//    return tableView.indexPathForSelectedRow;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //getStatus_btn_more_detailsClicked
    
    return 1;//rides.count;//1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return rides.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    sharedRoutesAsDriver.ride_selected = (unsigned long)indexPath.row;
    
    NSLog(@"Row selected = %lu",(unsigned long)indexPath.row);
}



-(void)switch_statusClicked:(UISwitch*)sender
{
    NSLog(@"switch status %ld pressed",(long)sender.tag);
    
    UISwitch *switcher = (UISwitch *)sender;
    
    indicatorView = [myTools setActivityIndicator:self];
    [indicatorView startAnimating];
    
    
    if ([switcher isOn])
    {
//        which_btn_pressed = 2;
        
        [self alertCustom:NSLocalizedString(@"Trip activated", @"Trip activated") withMessage:@""andCancel:NO ];
        
        [self activate_ride:[NSNumber numberWithBool:YES] ];
    }
    else
    {
        //which_btn_pressed = 3;
        
        [self alertCustom:NSLocalizedString(@"Trip disabled", @"Trip disabled") withMessage:@""andCancel:NO ];
        
        [self activate_ride:[NSNumber numberWithBool:NO ]];
    }
    
}

-(void)btn_delete_tripClicked:(UIButton *)sender
{
    NSLog(@"btn delete %ld pressed",(long)sender.tag);
    
    sharedRoutesAsDriver.ride_selected = (int) sender.tag;
    
    which_btn_pressed = 1;
    
    [self alertCustom:NSLocalizedString(@"Delete trip?", @"Delete trip?") withMessage:NSLocalizedString(@"If you have any passengers associated with this active trip, they will be notified.", "If you have any passengers associated with this active trip, they will be notified.") andCancel:YES ];
    
    //tag of button Add new trip
//    if (sender.tag == BUTTON_ADD_TRIP)
//    {
//        NSLog(@"btn_new_trip_pressed pressed!");
//    }
    
}

-(void) btn_show_mapClicked:(UIButton *)sender
{
	NSLog(@"btn more details %ld pressed",(long)sender.tag);
	Ride *ride = [[Ride alloc]init];
	ride = [rides objectAtIndex:(long)sender.tag];
	
	RidesMapDetailViewController *ridesMapDetail = [MainStoryboard instantiateViewControllerWithIdentifier:@"Map_Detail"];
	ridesMapDetail.passedRide = ride;
	
	[self.navigationController pushViewController:ridesMapDetail animated:YES];
}

-(void) btn_more_detailsClicked:(UIButton *)sender
{
    NSLog(@"btn more details %ld pressed",(long)sender.tag);
    
    
    //[cell.mapView setHidden:YES];
    
    //self.tabelView ce
    
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    //cell.constraint_mapView_height.constant = 0.0f;
    
 /*   NSArray *visibleCells = [self.tabelView visibleCells];
    RideTableViewCell *cell = [visibleCells objectAtIndex:sender.tag]; //Problem HERE!!
    
    NSString *valueStatus = [getStatus_btn_more_detailsClicked objectAtIndex:sender.tag];
    
    cell.constraint_stackView_avatar_height.constant = 0.0f;
    [cell.image_avatar_passenger setHidden:YES];
    
    if ([valueStatus isEqualToString:@"0"])
    {
        
        cell.constraint_stackView_mapView_height.constant = 180.0f;
        
        //self.tabelView.frame = CGRectMake(x,y,width,noOfCell*heightOfOneCell);
        
        [getStatus_btn_more_detailsClicked insertObject:@"1" atIndex:sender.tag];
    }
    else // ([valueStatus isEqualToString:@"1"])
    {
        cell.constraint_stackView_mapView_height.constant = 0.0f;
        [getStatus_btn_more_detailsClicked insertObject:@"0" atIndex:sender.tag];
        
        
    }
  */
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if(indexPath.section == yourSection && indexPath.row == yourRow) {
//        return 150.0;
//    }
//    // "Else"
//    return someDefaultHeight;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)btn_addTrip_pressed:(id)sender {
    
    NSLog(@"btn_new_trip_pressed pressed!");
    
    
    UINavigationController *nav = self.navigationController;
    [nav popToRootViewControllerAnimated:YES];
    
   // UIViewController *rootVC = [nav.viewControllers objectAtIndex:0];
   // [rootVC performSegueWithIdentifier:@"segueSetAddresses" sender:self];

	
	
	
	
	
    /** WAITING **/	
	[self.navigationController performSegueWithIdentifier:@"segueSelectNewTripMode" sender:self.navigationController];

	
	
    //NSArray *viewControllers = [self.navigationController viewControllers];
   // [self.navigationController popViewControllerAnimated:YES];
    
    //Go to segueSetAddresses
    
    //[self.navigationController pushViewController:[viewControllers objectAtIndex:1] animated:YES];
}



#pragma mark -display passenger pictures for ride's lifts
-(void) displayPassengerPictures:(RideTableViewCell *)cell withLifts:(NSMutableArray *)lifts
{
    [cell.image_avatar_passenger setHidden:NO];
    
    //For demo:
  	//?  for (int i=0;i<5;i++)
    for (int i=0;i<lifts.count;i++)
    {
        //UIImage *passenger_image = [UIImage imageNamed:@"face"];//]lift.passenger_image];
        //cell.image_avatar_passenger.image = passenger_image;
        
        
       // Lift *lift = [[Lift alloc] init];
        lift = [[Lift alloc] init];
        lift = lifts[i];
        
        
        //Next driver
        //x= 17+48, Y= 135
        //cell.image_avatar_passenger.frame.origin.y
        UIImageView *newImageView;
        newImageView =[[UIImageView alloc] initWithFrame:CGRectMake(cell.image_avatar_passenger.frame.origin.x + cell.image_avatar_passenger.frame.size.width + 10*(i+1) + (i-1)*cell.image_avatar_passenger.frame.size.width, 85,cell.image_avatar_passenger.frame.size.width,cell.image_avatar_passenger.frame.size.height)];
        
        if (lift.passenger_image != nil)
        {
            //newImageView.image = [UIImage ]
//            [self.image setImageWithURL:[NSURL URLWithString:url1] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//            
            NSString *ulrStr = commonData.BASEURL_FOR_PICTURES;
            ulrStr = [ulrStr stringByAppendingString:lift.passenger_image ];
            
            NSLog(@"url of image=%@",lift.passenger_image);
            
            NSURL *imageURLString = [NSURL URLWithString:ulrStr];
            
            NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageWithData: [NSData dataWithContentsOfURL:imageURLString]])];
            
            //Display it in the UIImage
            newImageView.image = [UIImage imageWithData:imageData];
        }
        else
        {
           // newImageView.image = [UIImage imageNamed:@"Makrygiannis"];//gender"]; //car_yellow
            newImageView.image = [UIImage imageNamed:@"account-circle-grey"];
        }
        
        CGSize size = CGSizeMake(48, 48);
        newImageView.image = [self imageWithImage:newImageView.image convertToSize:size];
        
        [self setStyleForImageCirle:newImageView];
        
        if (i==0)
        {
            cell.image_avatar_passenger.image = newImageView.image;
            [self setStyleForImageCirle:cell.image_avatar_passenger];
            
            cell.image_avatar_passenger.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
            cell.image_avatar_passenger.tag = 0;
            
            [cell.image_avatar_passenger addGestureRecognizer:tap];
        }
        else
        {
            [cell addSubview:newImageView];
            newImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
            
            newImageView.tag = i;
            
            [newImageView addGestureRecognizer:tap];
        }
        //[cell.stackView_images addArrangedSubview:newImageView];
        
    }
    
}

//Genereat tap events for each of the passenger images
- (void)tapped:(UITapGestureRecognizer*)tap
{
    NSLog(@"ImagevView.tag = %ld", tap.view.tag);
    //1.Get passenger details from lift.passenger_id
    
    ride = rides[sharedRoutesAsDriver.ride_selected];
    NSMutableArray *lifts= ride.lifts;
    
    //Get the tapped one
    lift = lifts[tap.view.tag];
    
    ride.lift_selected =  (int) tap.view.tag;
    
    [self retrieveUser:lift.passenger_id];
    
    //2.Retrieve feedback for passenger on that ride!!!!
    
    //sharedRoutesAsDriver.ride_selected
    
 //?  [self.navigationController performSegueWithIdentifier:@"showPassengerFeedbackForRides" sender:self];
    
    
}


#pragma mark - Retrieve user - for passenger
- (void)retrieveUser:(NSString *)passenger_id
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
                                      
                                      [self fill_passenger:parseJSON];
                                    
                                  }];
    
    [task resume];
    
    //8. Start UIActivityIndicatorView for GUI purposes
    indicatorView = [myTools setActivityIndicator:self];
    [indicatorView startAnimating];
    
}


-(void)fill_passenger:(NSDictionary *)parseJSON
{
    //passenger.user_name =
    lift.passenger_name = [parseJSON valueForKey:@"name"];
    lift.passenger_rating  = [ [parseJSON valueForKey:@"rating"] stringValue];
    
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
    
    //Update4 currect (selected lift with passenger values
//?    [sharedRoutesAsDriver.lifts replaceObjectAtIndex:sharedRoutesAsDriver.lift_selected withObject:lift];
    
    //Noew retrive feedback for the passenger
    [self retrieveFeedbackForPassenger];
    
}

#pragma mark - Retrieve feedbacks for a driver
- (void)retrieveFeedbackForPassenger
{
    // case_call_API = 1;
    //1. Create URL
    NSString *ulrStr = commonData.BASEURL_FOR_FEEDBACKS;
    
    ulrStr = [ulrStr stringByAppendingString:lift.passenger_id];
    ulrStr = [ulrStr stringByAppendingString:commonData.ROLE_PASSENGER];
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    NSLog(@"urlWitString=%@",urlWithString);
    
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
                                      
                                      [self fill_feedbackArray:parseJSON];
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                          [self.navigationController performSegueWithIdentifier:@"showPassengerFeedbackForRides" sender:self];
                                          
                                          [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
                                          [indicatorView stopAnimating];
                                          
                                      });
                                      
                                  }];
    
    
    [task resume];
    
}

-(void) fill_feedbackArray : (NSDictionary *) parseJSON
{
    
    sharedRoutesAsPassenger.feedbackArray = [[NSMutableArray alloc]init];
   
    NSArray *getfeedbackData = [parseJSON objectForKey:@"feedbacks"];
    
    for (int i=0;i< getfeedbackData.count;i++)
    {
        Feedback *feedbackData = [[Feedback alloc]init];
        
        feedbackData.id = [getfeedbackData[i] objectForKey:@"id"];
        feedbackData.reviewed_id = [getfeedbackData[i] objectForKey:@"reviewer_id"];
        
        feedbackData.ratings = [getfeedbackData[i] objectForKey:@"ratings"];
        
        feedbackData.punctuation = [feedbackData.ratings objectForKey:@"punctuation"];
        feedbackData.satisfaction_level = [feedbackData.ratings objectForKey:@"satisfaction_level"];
        feedbackData.carpooler_behaviour = [feedbackData.ratings objectForKey:@"carpooler_behaviour"];
        
        feedbackData.role = [getfeedbackData[i] objectForKey:@"role"];
        feedbackData.reviewed_id = [getfeedbackData[i] objectForKey:@"reviewed_id"];
        feedbackData.lift_id = [getfeedbackData[i] objectForKey:@"lift_id"];
        feedbackData.date = [getfeedbackData[i] objectForKey:@"date"];
        feedbackData.reviewed_name = [getfeedbackData[i] objectForKey:@"reviewed_name"];
        feedbackData.review = [getfeedbackData[i] objectForKey:@"review"];
        feedbackData.reviewer = [getfeedbackData[i] objectForKey:@"reviewer"];
        feedbackData.rating = [getfeedbackData[i] objectForKey:@"rating"];
        
        //Store only reviews as driver
        [sharedRoutesAsPassenger.feedbackArray addObject:feedbackData];
        
    }
}



#pragma mark - mehod for make picture rounded(cirle)
//Convert image to scale it into imageView
//http://stackoverflow.com/questions/4712329/how-to-resize-the-image-programatically-in-objective-c-in-iphone
- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return destImage;
}

//Styling picture as as circle
-(void) setStyleForImageCirle: (UIImageView *) imageView
{
    imageView.backgroundColor = [UIColor clearColor];
    
    imageView.layer.cornerRadius = imageView.frame.size.width /2;
    
    //Core Animation creates an implicit clipping mask that matches the bounds of the layer and includes any corner radius effects
    imageView.layer.masksToBounds =  YES;
}


#pragma mark - alertCustom
-(void) alertCustom: (NSString *)titleString withMessage:(NSString *)messageString andCancel:(BOOL)cancelExists
{
    NSString *ok = NSLocalizedString(@"OK", @"OK");
    NSString *cancel = NSLocalizedString(@"Cancel", @"Cancel");
    
    //  NSString *message_title = NSLocalizedString(@"Credentials", @"Credentials");
    //NSString *error_message = NSLocalizedString(@"Credentials required!", @"Credentials required!");
    
    UIAlertController *alertAuthenticationError = [UIAlertController
                                                   alertControllerWithTitle:titleString
                                                   message:messageString
                                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:ok
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   
                                   if (which_btn_pressed == 1)//Delete button pressed
                                   {
                                       indicatorView = [myTools setActivityIndicator:self];
                                       [indicatorView startAnimating];
                                    
                                       which_btn_pressed =0;
                                       
                                       [self delete_ride];
                                       
                                   }
                                 /*  else if (which_btn_pressed == 2)
                                   {
                                       indicatorView = [myTools setActivityIndicator:self];
                                       [indicatorView startAnimating];

                                       [self activate_ride:[NSNumber numberWithBool:YES] ];
                                   }
                                   else if (which_btn_pressed == 3)
                                   {
                                       indicatorView = [myTools setActivityIndicator:self];
                                       [indicatorView startAnimating];
                                       
                                       [self activate_ride:[NSNumber numberWithBool:NO] ];
                                   }
*/
                                   
                                   [self.tabelView reloadData];
                                   
                                   [alertAuthenticationError dismissViewControllerAnimated:YES completion:nil];
                               }];
    [alertAuthenticationError addAction:okAction];
    
    if (cancelExists)
    {
        
        UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:cancel
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       [alertAuthenticationError dismissViewControllerAnimated:YES completion:nil];
                                   }];
        [alertAuthenticationError addAction:cancelAction];
    }
    
    [self presentViewController:alertAuthenticationError animated:NO completion:nil];
    
}


#pragma mark - Delete ride HTTP call
-(void) delete_ride
{
    //1. Create URL
    NSString *ulrStr = commonData.BASEURL_CREATE_RIDES;
    ulrStr = [ulrStr stringByAppendingString:@"/"];
    ulrStr = [ulrStr stringByAppendingString:((Ride*)[rides objectAtIndex:sharedRoutesAsDriver.ride_selected])._id];
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    NSLog(@"urlWitString=%@",urlWithString);
    
    
    //2. Create and send Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //3. Set HTTP Headers and HTTP Method
    [urlRequest setValue:sharedProfile.authCredentials forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //4. Set HTTP Method
    [urlRequest setHTTPMethod:HTTP_METHOD_DELETE];
    
    
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
//                                      NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                                      
//                                      NSLog(@"ParseJson[deleteRides] =%@", parseJSON);
                                      
                                      //HTTP status 204 succcess no content
                                      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                      NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          
                                          //ride = rides[sharedRoutesAsDriver.ride_selected];
                                          //delete the selected reide
                                          [sharedRoutesAsDriver.rides removeObjectAtIndex:sharedRoutesAsDriver.ride_selected];
                                          
                                          [self.tabelView reloadData];
                                          
                                          [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
                                         
                                          [indicatorView stopAnimating];
                                         
                                      });
                                      
                                     // [self fill_Rides:parseJSON];
                                      
                                  }];
    [task resume];

    
}


#pragma mark - Activate ride HTTP call
-(void) activate_ride : (NSNumber*) activated_status_number
{
    //1. Create URL
    NSString *ulrStr = commonData.BASEURL_CREATE_RIDES;
    ulrStr = [ulrStr stringByAppendingString:@"/"];
    ulrStr = [ulrStr stringByAppendingString:ride._id];
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    NSLog(@"urlWitString=%@",urlWithString);
    
    
    //2. Create and send Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //3. Set HTTP Headers and HTTP Method
    [urlRequest setValue:sharedProfile.authCredentials forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //4. Set HTTP Method
    [urlRequest setHTTPMethod:HTTP_METHOD_PATCH];
    
    //?NSNumber *true_false = activated_status_number;
    
    //5.Send parameter as JSON
    NSDictionary *sendActivatedStatus = @{
                                          @"activated": activated_status_number
                                         };
    
    NSString *strRes = [myTools dictionaryToJSONString:sendActivatedStatus];
    
    [urlRequest setHTTPBody:[strRes dataUsingEncoding:NSUTF8StringEncoding]];
   
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                    
                                      NSLog(@"ParseJson[deleteRides] =%@", parseJSON);
                                      
                                      
                                      //HTTP status 204 succcess no content
                                      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                      NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
                                      
                                      
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{

                                          
                                          //Change status
                                          ride.activated = [NSString stringWithFormat:@"%@", activated_status_number];
                                          
                                        //  [sharedRoutesAsDriver.rides replaceObjectAtIndex: sharedRoutesAsDriver.ride_selected withObject:ride];
                                          
                                          [self.tabelView reloadData];
                                          
                                          [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
                                          
                                          [indicatorView stopAnimating];
                                          
                                     });
                                      
                                  }];
    [task resume];
    
}


//- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
//- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated;
//{
//    NSLog(@"Region map will change");
//    
//    NSLog(@"mapViewDidFinishLoadingMap");
//    
//    double start_x = [ride.start_point_lon doubleValue];
//    
//    double start_y = [ride.start_point_lat doubleValue];
//    
//    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(start_x, start_y);
////    
////    
////     MKCoordinateRegion adjustedRegion = [mapView regionThatFits:MKCoordinateRegionForMapRect(<#MKMapRect rect#>)//MKCoordinateRegionMakeWithDistance(startCoord, 20, 20)];
////    
////    [mapView setRegion:adjustedRegion animated:YES];
//    
//    [mapView setCenterCoordinate:startCoord animated:FALSE];
//}

//- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
//{
//    NSLog(@"mapViewDidFinishLoadingMap");
//  
//    double start_x = [ride.start_point_lon doubleValue];
//    
//    double start_y = [ride.start_point_lat doubleValue];
//    
//    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(start_x, start_y);
////    
////    double end_x = [[NSDecimalNumber decimalNumberWithString:ride.end_point_lon] doubleValue];
////    
////    double end_y = [[NSDecimalNumber decimalNumberWithString:ride.end_point_lat] doubleValue];
// 
//    //CLLocationCoordinate2D endCoord = CLLocationCoordinate2DMake(end_x, end_y);
//    
//    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 200, 200)];
//   
//    
//  /*  CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(49, -123);
//    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 200, 200)];
//    [mapView setRegion:adjustedRegion animated:YES];
//    */
//    [mapView setRegion:adjustedRegion animated:YES];
//    
//    //mapView setRegion:(MKCoordinateRegion)
//    
//}
//- (void)mapView:(MKMapView *)mapView didAddOverlayRenderers:(NSArray<MKOverlayRenderer *> *)renderers
//{
//    [mapView setCenterCoordinate:mapView.centerCoordinate];
//}



 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     
     //if showPassengerFeedbackForRides
     if ([segue.identifier isEqualToString:@"showPassengerFeedbackForRides"])
     {
         PassengerDetailsViewController *passengerDetailsViewController = [segue destinationViewController];
     
         passengerDetailsViewController.comingFromViewController=@"RidesViewController";
         
     }
 }



@end
