//
//  RouteDetailsStatusViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 21/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "RouteDetailsStatusViewController.h"
#import "FCAlertView.h"

@interface RouteDetailsStatusViewController ()
@property (nonatomic) NSTimer* locationUpdateTimer;

@end

@implementation RouteDetailsStatusViewController


- (void)comingFrom:(NSString *)viewControllerStr
{
    comingFromViewController = viewControllerStr;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//- (void)viewDidLoad {
//    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
/*?
   tableData = [NSArray arrayWithObjects:@"Proceed to Steliou Kazantzidi", @"Turn right",@"Make a U-turn",@"Turn left onto Steliou Kazantzidi",@"The destination is on your left",@"Dummy tram route", nil];
    
    thumbnails = [NSArray arrayWithObjects:@"ic_directions_car", @"ic_directions_car",@"ic_directions_car",@"ic_directions_car",@"ic_directions_car",@"ic_tram", nil];
?*/
    
    //UITableView goes below over 50 from navigation bar. I remove the "margin" area between them
    //self.tableViewRouteDetails.contentInset = UIEdgeInsetsMake(-50,0,0,0);
    
    sharedProfile = [SharedProfileData sharedObject];
    sharedRoutes = [ShareRoutes sharedObject];
    sharedRoutesAsPassenger = [SharedRoutesAsPassenger sharedRoutesAsPassengerObject];
    sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];
    
    myTools = [[MyTools alloc]init];
    commonData = [[CommonData alloc]init];
    [commonData initWithValues];
   // passenger = [[Passenger alloc]init];

    
//    feedbackArray = [[NSMutableArray alloc]init];
//
    
//    
//    sharedRoutes.feedbackArray = [[NSMutableArray alloc]init];
//    sharedRoutesAsPassenger.feedbackArray =[[NSMutableArray alloc]init];
    
    stepsMArray = [[NSMutableArray alloc]init];
    
    
//    if ([sharedRoutesAsPassenger.comingFromViewController isEqualToString:@"MyTrips"]) //coming after passenger requested RetrieveLifts
//    {
        NSMutableArray *lifts =[[NSMutableArray alloc]init];
    
    if ([comingFromViewController isEqualToString:@"Passenger"])
    {
        lifts = sharedRoutesAsPassenger.lifts;
        lift = [lifts objectAtIndex:sharedRoutesAsPassenger.lift_selected];
		self.btnSendPosition.alpha = 0.2f;
		self.btnSendPosition.userInteractionEnabled = NO;
    }
    else if ([comingFromViewController isEqualToString:@"Driver"])
    {
        lifts = sharedRoutesAsDriver.lifts;
        
        lift = [lifts objectAtIndex:sharedRoutesAsDriver.lift_selected];
		if (![lift.status isEqualToString:ACTIVE]) {
			self.btnSendPosition.alpha = 0.2f;
			self.btnSendPosition.userInteractionEnabled = NO;
		}else{
			[self startUpdatingLocationCustom];
		}
        //REQUEST WHEN COME
      //?  [self retrieveUser:lift.passenger_id];
       
    }
    else //comes from findTrips
    {
        ///!!!!!!!!! EDW TEST !!!!!!!!!!!!
        //ShareRoutes.h
        lifts = sharedRoutes.steps;
        
        lift = [lifts objectAtIndex:sharedRoutes.step_selected];
    }
        
        stepsMArray = lift.steps;
        
        
        self.label_duration.text = lift.lift_total_duration;
        self.label_duration.text = [self.label_duration.text  stringByAppendingString:NSLocalizedString(@"min.", @"min")];
        
        self.label_price.text = lift.lift_total_price;
        self.label_price.text = [self.label_price.text stringByAppendingString:lift.lift_currency];
   
        
       
        NSString *statusStr = NSLocalizedString(@"STATUS: ", @"STATUS: ");
        self.label_status.text = [statusStr stringByAppendingString:lift.status];
        
//        [self.image_pending setHidden:YES];
//        [self.btn_cancel setHidden:YES];
        
        self.label_driver_status.text = @"";
        
        self.label_origin.text = lift.start_address;
        self.label_destination.text = lift.end_address;
        
        //Hide stack view with status using his height constraint
       // self.view_status_height.constant = 0.0f;
     /*  if (![lift.status isEqualToString:COMPLETED])
       {
           self.view_ratingBanner_height.constant = 0.0f;
       }
    
       if ([lift.status isEqualToString:CANCELLED])
       {
           self.view_ratingBanner_height.constant = 0.0f;
           //self.view_status_height.constant = 0.0f;
           self.view_status_height.constant = 130.0f;//0.0f;
           [self.btn_cancel setHidden:YES];
           [self.image_pending setHidden:YES];
       }
*/
    
    
    if ([lift.status isEqualToString:COMPLETED])
    {
        self.view_ratingBanner_height.constant = 90.0f;//0.0f;
        self.view_status_height.constant = 0.0f;
        [self.btn_cancel setHidden:NO];
        [self.image_pending setHidden:NO];
        
    }//Show Status for "cancel"
    else if ([lift.status isEqualToString:REVIEWED])
    {
        self.view_ratingBanner_height.constant = 0.0f;
        self.view_status_height.constant = 130.0f;
        [self.btn_cancel setHidden:YES];
        [self.image_pending setHidden:YES];
    }//Show Status for "cancel"
    else if ( ([lift.status isEqualToString:PENDING]) || ([lift.status isEqualToString:ACTIVE]))
    {
        self.view_ratingBanner_height.constant = 0.0f;
        self.view_status_height.constant = 130.0f;//0.0f;
        [self.btn_cancel setHidden:NO];
        [self.image_pending setHidden:NO];
        
    }//Do not show netheri Banner not Status
    else if ([lift.status isEqualToString:CANCELLED])
    {
        self.view_ratingBanner_height.constant = 0.0f;
        //self.view_status_height.constant = 0.0f;
        self.view_status_height.constant = 130.0f;//0.0f;
        [self.btn_cancel setHidden:YES];
        [self.image_pending setHidden:YES];
    }
    else if ([lift.status isEqualToString:REFUSED])
    {
        self.view_ratingBanner_height.constant = 0.0f;
        self.view_status_height.constant = 0.0f;
        [self.btn_cancel setHidden:NO];
        [self.image_pending setHidden:NO];
    }
    
    [self.tableViewRouteDetails reloadData];

    //Clear it
    sharedRoutesAsPassenger.comingFromViewController = @"";

}

#pragma mark - UITAbleViewDataSource
//Asks the data source for a cell to insert in a particular location of the table view.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellRouteDetails";
    RouteDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RouteDetails" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if (lift.lift_total_duration == nil)
    {
        //Coming from "Find Trips" call, thus assign values from trips
        NSMutableArray *tripsAfter = [[NSMutableArray alloc]init];
        tripsAfter = sharedRoutes.tripsAfter;
        
        TripRetrieved *tripRetrieved = [[TripRetrieved alloc]init];
        tripRetrieved = [tripsAfter objectAtIndex:sharedRoutes.trip_selected];
        
        lift.lift_total_duration = tripRetrieved.total_duration;
        lift.lift_total_price = tripRetrieved.total_price;
        lift.lift_currency = tripRetrieved.currency;
        
    }
    self.label_duration.text = lift.lift_total_duration;
    
    self.label_duration.text = [self.label_duration.text  stringByAppendingString:NSLocalizedString(@"min.", @"min")];
    
    self.label_price.text = lift.lift_total_price;
    self.label_price.text = [self.label_price.text stringByAppendingString:lift.lift_currency ];
  
    //Show Banner for rating
    if ([lift.status isEqualToString:COMPLETED])
    {
        self.view_ratingBanner_height.constant = 90.0f;//0.0f;
        self.view_status_height.constant = 0.0f;
    }
    else if ([lift.status isEqualToString:REVIEWED])
    {
        self.view_ratingBanner_height.constant = 0.0f;
        self.view_status_height.constant = 130.0f;
        [self.btn_cancel setHidden:YES];
        [self.image_pending setHidden:YES];
    }
    else if ( ([lift.status isEqualToString:PENDING]) || ([lift.status isEqualToString:ACTIVE]) )
    {
        self.view_ratingBanner_height.constant = 0.0f;
        self.view_status_height.constant = 130.0f;//0.0f;
        [self.btn_cancel setHidden:NO];
        [self.image_pending setHidden:NO];
        
    }//Do not show netheri Banner not Status
    else if ([lift.status isEqualToString:CANCELLED])
    {
        self.view_ratingBanner_height.constant = 0.0f;
        //self.view_status_height.constant = 0.0f;
        self.view_status_height.constant = 130.0f;//0.0f;
        [self.btn_cancel setHidden:YES];
        [self.image_pending setHidden:YES];
    }
    else if ([lift.status isEqualToString:REFUSED])
    {
        self.view_ratingBanner_height.constant = 0.0f;
        self.view_status_height.constant = 0.0f;
        [self.btn_cancel setHidden:NO];
        [self.image_pending setHidden:NO];
    }
   
    step= [stepsMArray objectAtIndex:(int)indexPath.row];
    
    cell.image_transport_type.image = step.transport_image;
    
    //?cell.label_route_instruction.text = step.transport_long_name;
    ///Added
    if ( indexPath.row == (int) 0)
    {
        
        cell.image_stop_name.image = [UIImage imageNamed:@"img_polyline_start_point"];
        
        if (![step.start_address isEqualToString:@"Unknown address"])
        {
            cell.label_route_instruction.text = step.start_address; //?
        }
        else
        {
            cell.label_route_instruction.text = lift.start_address;//sharedRoutes.origin_address;
        }
        
        [cell.label_route_instruction setHidden:NO];
        [cell.image_stop_name setHidden:NO];
        
        [cell.image_circles_divider_up setHidden:YES];
    }
    else
    {
        
        //      cell.label_route_instruction.text = @"";
        [cell.label_route_instruction setHidden:YES];
        
        [cell.image_stop_name setHidden:YES];
        
        [cell.image_circles_divider_up setHidden:NO];
        
    }
    /// End Added
    //Default values
    [cell.label_departs_at setHidden:YES];
    [cell.image_driver setHidden:YES];
    [cell.image_next_route_details setHidden:YES];

    
    if ([step.travel_mode isEqualToString:TRANSPORT_CAR_POOLING])
    {
        [cell.label_departs_at setHidden:NO];
        [cell.label_arrives_to setHidden:NO];
        [cell.label_stops_names setHidden:YES]; //?
        [cell.label_transport_number setHidden:NO];
        
        if ([comingFromViewController isEqualToString:@"Passenger"])
        {
            driver = [step.driver objectAtIndex:0];
            lift.driver_id = driver.userID;
            lift.driver_name = driver.user_name;
            lift.driver_picture = driver.user_image;
            cell.label_transport_number.text = driver.user_name;
            
            if (lift.driver_picture == nil)
            {
                lift.driver_picture = [UIImage imageNamed:@"account-circle-grey"];
            }
            
            cell.image_driver.image = lift.driver_picture;
        }
        else if ([comingFromViewController isEqualToString:@"Driver"])
        {
            cell.label_transport_number.text = lift.passenger_name;
            
            if (lift.passenger_picture == nil)
            {
                lift.passenger_picture = [UIImage imageNamed:@"account-circle-grey"];
            }
            
            cell.image_driver.image = lift.passenger_picture;
            
        }
        getRowContainsCAR_POOLING = (int)indexPath.row;
        
        [cell.image_driver setHidden:NO];
        [cell.image_next_route_details setHidden:NO];
        
        //Departure date time
        NSString *departDateTime = [myTools convertTimeStampToStringWithDateAndTime:step.start_address_date];
        
        cell.label_departs_at.text = NSLocalizedString(@"Departs ", @"Departs ");
        cell.label_departs_at.text = [cell.label_departs_at.text stringByAppendingString:departDateTime];
        
        //Arrival date time
        NSString *arrivalDateTime = [myTools convertTimeStampToStringWithDateAndTime:step.end_address_date];
        
        cell.label_arrives_to.text = NSLocalizedString(@"Arrives ", @"Arrives ");
        
        cell.label_arrives_to.text = [cell.label_arrives_to.text stringByAppendingString:arrivalDateTime];
        
        // Check to see wheteh it is GB
        NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
        NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
//        
        if ( [countryCode isEqualToString:@"GB"] )
        {
            float milesNumberFloat = step.distance_step* (float)3.280839895;//0.000621371;
//            //Round to closest
            if (milesNumberFloat > 10000)
            {
                //Convert them to miles
                float miles = (float)milesNumberFloat * (float)0.000189394;//0.000189394 miles =  1ft
                int milesInt  = round(miles);
                
                cell.label_stops.text = [NSString stringWithFormat:@"%i",milesInt];
                
                cell.label_stops.text = [cell.label_stops.text stringByAppendingString:NSLocalizedString(@"miles", @"miles")];
            }
            else
            {
                int milesInt = round(milesNumberFloat);
            
                cell.label_stops.text=@"";
                cell.label_stops.text = [NSString stringWithFormat:@"%i",milesInt];
                
                cell.label_stops.text = [cell.label_stops.text stringByAppendingString:NSLocalizedString(@"ft", @"ft")];
            }
        }
        else
        {
            if (step.distance_step > 1000)
            {
                float kmsNumberFloat = step.distance_step /(float)1000;
               
                cell.label_stops.text = [NSString stringWithFormat:@"%.1f",kmsNumberFloat];
                cell.label_stops.text = [cell.label_stops.text stringByAppendingString:NSLocalizedString(@"km", @"km")];
            }
            else
            {
                cell.label_stops.text = [NSString stringWithFormat:@"%i",step.distance_step];
            
                cell.label_stops.text = [cell.label_stops.text stringByAppendingString:NSLocalizedString(@"m", @"m")];
            }
        }

    }
    else if ([step.travel_mode isEqualToString:TRANSPORT_BUS]
             || ([step.travel_mode isEqualToString:TRANSPORT_RAIL])
             || ([step.travel_mode isEqualToString:TRANSPORT_TRAM])
             || ([step.travel_mode isEqualToString:TRANSPORT_METRO]) )
    {
        //?  cell.height_stackview_first_row.constant = 24.0f;
        
        [cell.label_departs_at setHidden:NO];
        [cell.label_arrives_to setHidden:NO];
        [cell.label_transport_number setHidden:NO];
        [cell.label_stops_names setHidden:NO];
        
        cell.label_transport_number.text = step.transport_long_name;
        
        IntermediatePoint *interPoint = [[IntermediatePoint alloc] init];
        NSMutableArray *interPointsArray = [[NSMutableArray alloc]init];
        interPointsArray = step.intermediate_points;
        
        NSString *stopsNames=@"";
        
        if (interPointsArray.count !=0)
        {
            interPointsArray = step.intermediate_points;
            
            for (int i=0;i<step.intermediate_points.count;i++)
            {
                interPoint = interPointsArray[i];
                stopsNames = [stopsNames stringByAppendingString:interPoint.address];
                
                if (i!=(interPointsArray.count-1))
                {
                    stopsNames = [stopsNames stringByAppendingString:@"-"];
                }
            }
            
            interPoint = interPointsArray[0];
            
            
            NSString *departDateTime = [myTools convertTimeStampToStringWithDateAndTime: step.start_address_date];//interPoint.starDateTimeTrip];
            
            cell.label_departs_at.text = NSLocalizedString(@"Departs ", @"Departs ");
            cell.label_departs_at.text = [cell.label_departs_at.text stringByAppendingString:departDateTime];
            
            
            //Arrival date time
            interPoint = interPointsArray[interPointsArray.count-1];
            
           //? NSString *arrivalDateTime = [myTools convertTimeStampToStringWithDateAndTime:interPoint.starDateTimeTrip];
            NSString *arrivalDateTime = [myTools convertTimeStampToStringWithDateAndTime:step.end_address_date];
            
            cell.label_arrives_to.text = NSLocalizedString(@"Arrives ", @"Arrives ");
            
            cell.label_arrives_to.text = [cell.label_arrives_to.text stringByAppendingString:arrivalDateTime];
            
            //NSString *addressArrival = interPoint.address;
            
            //? cell.label_arrives_to.text = [cell.label_arrives_to.text stringByAppendingString:@" to "];
            
            //? cell.label_arrives_to.text = [cell.label_arrives_to.text stringByAppendingString:addressArrival];
            
            NSString *numberOfStops = [NSString stringWithFormat:@"%lu",(unsigned long)interPointsArray.count];
            
            cell.label_stops.text = numberOfStops;
            
            cell.label_stops.text = [cell.label_stops.text stringByAppendingString:@" stops"];
        }
        
        cell.label_stops_names.text = stopsNames;
        
        //        cell.label_stops_names.lineBreakMode = NSLineBreakByWordWrapping;
        //        cell.label_stops_names.numberOfLines = 0;
        
        
    }
    else if ([step.travel_mode isEqualToString:TRANSPORT_FEET])
    {
        /*        if (indexPath.row == 0)
         {
         cell.height_stackview_first_row.constant = 0.0f;
         }
         else
         {
         cell.height_stackview_first_row.constant = 24.0f;
         }
         */
        
        [cell.label_departs_at setHidden:NO];
        [cell.label_arrives_to setHidden:YES];
        [cell.label_stops_names setHidden:YES]; //?
        [cell.label_transport_number setHidden:YES];
        
        if (![step.end_address isEqualToString:@"Unknown address"])
        {
            cell.label_departs_at.text  = NSLocalizedString(@"Walk towards ", @"Walk towards ");
            
            cell.label_departs_at.text  = [cell.label_departs_at.text  stringByAppendingString:step.end_address];//step.transport_short_name];
        }
        else
        {
            cell.label_departs_at.text  = NSLocalizedString(@"Walk from ", @"Walk from ");
            
            cell.label_departs_at.text  = [cell.label_departs_at.text  stringByAppendingString:step.start_address];//step.transport_short_name];
        }
        
        if ( ([step.end_address isEqualToString:@"Unknown address"]) && ([step.start_address isEqualToString:@"Unknown address"]) )
        {
            cell.label_departs_at.text  = NSLocalizedString(@"Walk towards ", @"Walk towards ");
        }
        
        [cell.image_next_route_details setHidden:YES];
        
        // Check to see whether it is GB
        NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
        NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
        
        if ( [countryCode isEqualToString:@"GB"] )
        {
            float milesNumberFloat = step.distance_step* (float)3.280839895;//0.000621371;
            //Round to closest
            if (milesNumberFloat > 10000)
            {
                //Convert them to miles
                float miles = (float)milesNumberFloat * (float)0.000189394;//0.000189394 miles =  1ft
              
                int milesInt = round(miles);
                cell.label_stops.text=@"";
                cell.label_stops.text = [NSString stringWithFormat:@"%i",milesInt];
                
                cell.label_stops.text = [cell.label_stops.text stringByAppendingString:NSLocalizedString(@"miles", @"miles")];
            }
            else
            {
                //step.distance_step = round(milesNumberFloat);
                int milesInt = round(milesNumberFloat);
                cell.label_stops.text=@"";
                
                cell.label_stops.text = [NSString stringWithFormat:@"%i",milesInt];
                
                cell.label_stops.text = [cell.label_stops.text stringByAppendingString:NSLocalizedString(@"ft", @"ft")];
            }
            
        }
        else
        {
            if (step.distance_step > 1000)
            {
                float kmsNumberFloat = step.distance_step /(float)1000;
                
                cell.label_stops.text = [NSString stringWithFormat:@"%.1f",kmsNumberFloat];
                cell.label_stops.text = [cell.label_stops.text stringByAppendingString:NSLocalizedString(@"km", @"km")];
            }
            else
            {
                cell.label_stops.text = [NSString stringWithFormat:@"%i",step.distance_step];
                
                cell.label_stops.text = [cell.label_stops.text stringByAppendingString:NSLocalizedString(@"m", @"m")];
            }
        }
        
    }

//    else
//    {
//        //Default values
//        [cell.image_driver setHidden:YES];
//        [cell.image_next_route_details setHidden:YES];
//    }
    
    [cell.label_stops setHidden:NO];
    
    [cell.label_circle_divider setHidden:NO];
    
    [cell.label_duration setHidden:NO];
    
//    cell.label_stops.text = [NSString stringWithFormat:@"%i",step.distance_step]; //@"2 stops";
    
    // Check to see wheteh it is GB
//    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
//    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
//    
//    if ( [countryCode isEqualToString:@"GB"] )
//    {
//        cell.label_stops.text = [cell.label_stops.text stringByAppendingString:NSLocalizedString(@"ft", @"ft")];
//    }
//    else
//    {
//        cell.label_stops.text = [cell.label_stops.text stringByAppendingString:NSLocalizedString(@"m", @"m")];
//    }
    
    
    cell.label_duration.text = step.duration_step;
    
    cell.label_duration.text = [cell.label_duration.text stringByAppendingString:NSLocalizedString(@"min.", @"min.")];
    
    //Show Est. time when the lift is not completed!
    if (![lift.status isEqualToString:COMPLETED])
    {
        [cell.label_estimation_time setHidden:NO];
    }
    else
    {
        [cell.label_estimation_time setHidden:YES];
    }
    
    ///Added
    if ( indexPath.row == (int) (stepsMArray.count-1) )
    {
        cell.image_end_point.image = [UIImage imageNamed:@"img_polyline_end_point"];
        
        if (![step.end_address isEqualToString:@"Unknown address"])
        {
            cell.label_end_point.text = step.end_address; //?
        }
        else
        {
            cell.label_end_point.text = sharedRoutes.destination_address;
        }
    }
    else
    {
        cell.image_end_point.image = [UIImage imageNamed:@"img_polyline_edge"];
        if (![step.end_address isEqualToString:@"Unknown address"])
        {
            cell.label_end_point.text = step.end_address; //?
        }
        else
        {
            NSLog(@"step.end_address is UNKNOWN ADDRESS!");
            Steps *nextStep = stepsMArray[indexPath.row + 1];
            cell.label_end_point.text = nextStep.start_address;
        }
    }
    /// End Added

    

    return cell;
}


//return the number of rows in a given section of a table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return [tableData count];
    return stepsMArray.count; 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;//default value
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"Row selected = %lu",(unsigned long)indexPath.row);
    
    //If CAR POOLING EXTERNAL DOES NOT EXIST
    if (!step.has_CAR_POOLING_EXTERNAL)
    {
        if (indexPath.row == getRowContainsCAR_POOLING)
        {
           /* if ([comingFromViewController isEqualToString:@"RetrieveLifts"])
            {
                sharedRoutesAsPassenger.step_selected = (int)indexPath.row;
                
                [self.navigationController performSegueWithIdentifier:@"showSegueDriverDetailsFromLifts" sender:self];
            }
            else
            {
                sharedRoutes.step_selected = (int)indexPath.row;
                
                [self.navigationController performSegueWithIdentifier:@"showSegueDriverDetails" sender:self];
            }*/
            
            if ([comingFromViewController isEqualToString:@"Passenger"])
            {
				[self sendFakeMessage:@"Welcome" toReceiverID:lift.driver_id fromSenderID:sharedProfile.userID andLiftID:lift._id];
                sharedRoutesAsPassenger.step_selected = (int)indexPath.row;
                [self retrieveUser:lift.driver_id];
                //[self.navigationController performSegueWithIdentifier:@"showSegueDriverDetailsFromLifts" sender:self];
            }
            else if ([comingFromViewController isEqualToString:@"Driver"])
            {
				[self sendFakeMessage:@"Welcome" toReceiverID:lift.passenger_id fromSenderID:sharedProfile.userID andLiftID:lift._id];
                sharedRoutesAsDriver.step_selected = (int)indexPath.row;
                [self retrieveUser:lift.passenger_id];
                
               //? [self performSegueWithIdentifier:@"LeaveFeedbackFromRoutDetailsStatusVC" sender:self];
            }
            else
            {
                sharedRoutes.step_selected = (int)indexPath.row;
                
                [self.navigationController performSegueWithIdentifier:@"showSegueDriverDetails" sender:self];
            }
            

            
        }
    }
   //self.navigationController.navigationItem.backBarButtonItem.title = @"Back";
     
}

#pragma mark - Retrieve Chats
-(void) sendFakeMessage:(NSString *)body toReceiverID:(NSString*)receiver_id fromSenderID:(NSString*)sender_id andLiftID:(NSString*)lift_id
{
	NSDictionary *dataToSend = @{
								 @"sender_id":sender_id,
								 @"receiver_id":receiver_id,
								 @"lift_id":lift_id,
								 @"body":body
								 };
	//1. Create URL
	NSString *ulrStr = commonData.BASEURL_CHAT;
	
	NSURL *urlWithString = [NSURL URLWithString:ulrStr];
	NSLog(@"urlWitString=%@",urlWithString);
	
	//2. Create and send Request
	NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
	//3. Set HTTP Headers and HTTP Method
	[urlRequest setValue:sharedProfile.authCredentials forHTTPHeaderField:@"Authorization"];
	[urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
	[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	MyTools* myTools = [[MyTools alloc]init];
	NSString *strRes = [myTools dictionaryToJSONString:dataToSend];
	
	[urlRequest setHTTPBody:[strRes dataUsingEncoding:NSUTF8StringEncoding]];
	//4. Set HTTP Method
	[urlRequest setHTTPMethod:HTTP_METHOD_POST];
	
	//5. Send Request to Server
	//?        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest];
	//?        [dataTask resume];
	//create the task
	NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
								  {
									  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
									  
									  NSLog(@"ParseJson[retrieveFeedback] =%@", json);
								  }];
	[task resume];
}


#pragma mark - Retrieve feedbacks for a driver
- (void)retrieveFeedbackForDriverOrPassenger
{
   // case_call_API = 1;
    //1. Create URL
    NSString *ulrStr = commonData.BASEURL_FOR_FEEDBACKS;
    
    if ([comingFromViewController isEqualToString:@"Passenger"])
    {
        ulrStr = [ulrStr stringByAppendingString:driver.userID];
        ulrStr = [ulrStr stringByAppendingString:commonData.ROLE_DRIVER];
    }
    else if ([comingFromViewController isEqualToString:@"Driver"])
    {
        ulrStr = [ulrStr stringByAppendingString:lift.passenger_id];
        ulrStr = [ulrStr stringByAppendingString:commonData.ROLE_PASSENGER];
    }
    
    
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
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self fill_feedbackArray:parseJSON];
            
            if ([comingFromViewController isEqualToString:@"Driver"])
            {
                //showFeedbackPassenger
                //? OLD: ***************** ????????
                [self.navigationController performSegueWithIdentifier:@"showFeedbackPassenger" sender:self];
                
              //?Why  [self performSegueWithIdentifier:@"LeaveFeedbackFromRoutDetailsStatusVC" sender:self];
                
                  //showSegueDriverDetailsFromLifts
            }
            else if ([comingFromViewController isEqualToString:@"Passenger"])
            {
                [self.navigationController performSegueWithIdentifier:@"showSegueDriverDetailsFromLifts" sender:self];
            }
            
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
            [indicatorView stopAnimating];
            
        });

    }];
    

    [task resume];
    
    
    
}

-(void) fill_feedbackArray : (NSDictionary *) parseJSON
{
    sharedRoutes.feedbackArray = [[NSMutableArray alloc]init];
    
    if ([comingFromViewController isEqualToString:@"Passenger"])
    {
        sharedRoutesAsPassenger.feedbackArray =[[NSMutableArray alloc]init];
    }
    else if ([comingFromViewController isEqualToString:@"Driver"])
    {
        sharedRoutesAsDriver.feedbackArray =[[NSMutableArray alloc]init];
    }
    
    //if (case_call_API == 1)
    //{
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
        if ([feedbackData.role isEqualToString:@"driver"])
        {
            //if ([comingFromViewController isEqualToString:@"RetrieveLifts"])
            if ([comingFromViewController isEqualToString:@"Passenger"])
            {
                [sharedRoutesAsPassenger.feedbackArray addObject:feedbackData];
            }
            else if ([comingFromViewController isEqualToString:@"Driver"])
            {
                [sharedRoutesAsDriver.feedbackArray addObject:feedbackData];
            }
            else
            {
                [sharedRoutes.feedbackArray addObject:feedbackData];
            }
        }
        else if ([feedbackData.role isEqualToString:@"passenger"])
        {
            NSLog(@"*** Store data in sharedRoutesAsDriver.feedbackArray ****");
            [sharedRoutesAsDriver.feedbackArray addObject:feedbackData];
        }
        //}
    }
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
    
    //8. Start UIActivityIndicatorView for GUI purposes
    indicatorView = [myTools setActivityIndicator:self];
    [indicatorView startAnimating];
    
}


-(void)fill_passenger:(NSDictionary *)parseJSON
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

    
    
    
    //Now retrieve feedback for the passenger
    [self retrieveFeedbackForDriverOrPassenger];

    
}

#pragma mark updateLift REST call
#pragma mark - Update Lift
- (void)updateLift
{
    //case_call_API = 2;
    //1. Create URL
    NSString *ulrStr = commonData.BASEURL_UDATE_LIFTS;
    ulrStr = [ulrStr stringByAppendingString:lift._id];
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    NSLog(@"urlWitString=%@",urlWithString);
    
    NSURLCredential *credentials = [NSURLCredential credentialWithUser:sharedProfile.email password:sharedProfile.password persistence:NSURLCredentialPersistenceNone];
    
    NSString *authStr = [credentials user];
    authStr = [authStr stringByAppendingString:@":"];
    authStr  = [authStr stringByAppendingString:[credentials password] ];
    
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
    [urlRequest setHTTPMethod:HTTP_METHOD_PATCH];//@"PATCH"];
    
    //7.Send parameters as JSON
    NSDictionary *statusDictionary = @{
                                       STATUS : CANCELLED
                                       };
    
    NSString *strRes = [myTools dictionaryToJSONString:statusDictionary];
    [urlRequest setHTTPBody:[strRes dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                      
                                      NSLog(@"ParseJson =%@", parseJSON);
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          NSLog(@"Trip cancelled");
                                          //Update it
                                          lift.status = CANCELLED;
                                          
                                          /////
                                          if ([comingFromViewController isEqualToString:@"Passenger"])
                                          {
                                              Lift *liftTobeStored = sharedRoutesAsPassenger.lifts[sharedRoutesAsPassenger.lift_selected];
                                        
                                              liftTobeStored.status = lift.status;
                                          
                                              //Replace it with the new value
                                              [sharedRoutesAsPassenger.lifts replaceObjectAtIndex:sharedRoutesAsPassenger.lift_selected withObject:liftTobeStored];
                                          }
                                          else if ([comingFromViewController isEqualToString:@"Driver"])
                                          {
                                              Lift *liftTobeStored = sharedRoutesAsDriver.lifts[sharedRoutesAsDriver.lift_selected];
                                              
                                              liftTobeStored.status = lift.status;
                                              
                                              //Replace it with the new value
                                              [sharedRoutesAsDriver.lifts replaceObjectAtIndex:sharedRoutesAsDriver.lift_selected withObject:liftTobeStored];
                                          }
                                          
                                          ///???
                                          
                                          [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
                                          [indicatorView stopAnimating];
                                          
                                        
                                          
                                      });

                                      
                                      
                                  }];

    [task resume];
    
    //9. Start UIActivityIndicatorView for GUI purposes
    indicatorView = [myTools setActivityIndicator:self];
    [indicatorView startAnimating];
    
}



#pragma mark Touch events
- (IBAction)btn_cancel_pending:(id)sender
{
    NSString *message_title = NSLocalizedString(@"Cancel request", @"Cancel request");
    NSString *message_description = NSLocalizedString(@"Do you want to cancel the lift?", @"Do you want to cancel the lift?");
    NSString *yes= NSLocalizedString(@"Yes", @"Yes");
    NSString *no= NSLocalizedString(@"No", @"No");
    
    UIAlertController *alertCancelRequest = [UIAlertController
                                      alertControllerWithTitle:message_title
                                      message:message_description
                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *noAction = [UIAlertAction
                               actionWithTitle:no
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [alertCancelRequest dismissViewControllerAnimated:YES completion:nil];
                               }];
    
    UIAlertAction *yesAction = [UIAlertAction
                                actionWithTitle:yes
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //Hide status banner
                                    //self.view_status_height.constant = 0.0f;
                                    
                                    NSString *statusStr = NSLocalizedString(@"STATUS: ", @"STATUS: ");
                                    self.label_status.text = [statusStr stringByAppendingString:CANCELLED];
                                    
                                    [self.btn_cancel setHidden:YES];
                                    [self.image_pending setHidden:YES];
                                    
                                    self.label_driver_status.text =@"";
                                    
                                    //Cancel trip
                                    [self updateLift];
                                    
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                    
                                }];
    
    [alertCancelRequest addAction:noAction];
    [alertCancelRequest addAction:yesAction];
    [self presentViewController:alertCancelRequest animated:NO completion:nil];
}


- (IBAction)ratingBanner_touched:(id)sender
{
    
    NSLog(@"Rating banner touched!");
    
    
    if ([comingFromViewController isEqualToString:@"Passenger"])
    {
        
       // [self.navigationController performSegueWithIdentifier:@"showSegueDriverDetailsFromLifts" sender:self];
        
        [self performSegueWithIdentifier:@"LeaveFeedbackFromRoutDetailsStatusVC" sender:self];
        
        
    }
    else if ([comingFromViewController isEqualToString:@"Driver"])
    {
      
         [self performSegueWithIdentifier:@"LeaveFeedbackFromRoutDetailsStatusVC" sender:self];
        
        //?[self retrieveUser:lift.passenger_id];
        
       //? [self performSegueWithIdentifier:@"LeaveFeedbackFromRoutDetailsStatusVC" sender:self];
    }
}

- (IBAction)btnSendPressed:(id)sender {

	long long integer = round([[NSDate date] timeIntervalSince1970]);
	NSString * timestamp = [NSString stringWithFormat:@"%ld",(long)integer];
	
	//1. Create URL
	NSString *ulrStr = commonData.BASEURL_SEND_POSITION;
	
	ulrStr = [ulrStr stringByAppendingString:[NSString stringWithFormat:@"?lat=%@&lon=%@&lift_id=%@",@(self.locationTracker.myLocation.latitude),@(self.locationTracker.myLocation.longitude),[NSString stringWithFormat:@"%@", lift._id]]];
	
	NSURL *urlWithString = [NSURL URLWithString:ulrStr];
	
	NSLog(@"urlWithString=%@?lat=%@&lon=%@&lift_id=%@",urlWithString,@(self.locationTracker.myLocation.latitude),@(self.locationTracker.myLocation.longitude),[NSString stringWithFormat:@"%@", lift._id]);
	//2. Create and send Request
	NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
	//3. Set HTTP Headers and HTTP Method
	[urlRequest setValue:sharedProfile.authCredentials forHTTPHeaderField:@"Authorization"];
	[urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
	[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	
	MyTools* myTools = [[MyTools alloc]init];
	//NSString *strRes = [myTools dictionaryToJSONString:dataToSend];
	
	//[urlRequest setHTTPBody:[strRes dataUsingEncoding:NSUTF8StringEncoding]];
	//4. Set HTTP Method
	[urlRequest setHTTPMethod:HTTP_METHOD_GET];
	
	//5. Send Request to Server
	//?        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest];
	//?        [dataTask resume];
	//create the task
	NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
								  {
									  
									  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
									  NSLog(@"%@",json);
									  dispatch_async(dispatch_get_main_queue(), ^{
										  
										  if ([[json objectForKey:@"status"] isEqualToString:@"OK"]) {
											  FCAlertView* alert = [[FCAlertView alloc] init];
											  [alert showAlertWithTitle:@"SUCCESS" withSubtitle:@"Position shared with passenger" withCustomImage:nil withDoneButtonTitle:@"OK" andButtons:nil];
											  [alert makeAlertTypeSuccess];
										  }else{
											  FCAlertView* alert = [[FCAlertView alloc] init];
											  [alert showAlertWithTitle:@"Warning" withSubtitle:[json objectForKey:@"details"] withCustomImage:nil withDoneButtonTitle:@"OK" andButtons:nil];
											  [alert makeAlertTypeCaution];
										  }
									  });
									  
								  }];
	[task resume];
	
}


#pragma mark - End of UITAbleViewDataSource

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"LeaveFeedbackFromRoutDetailsStatusVC"])
    {
        LeaveFeedbackViewController *leaveFeedbackViewController = [segue destinationViewController];
        
        if ([comingFromViewController isEqualToString:@"Passenger"])
        {
        leaveFeedbackViewController.comingFromViewController=@"RouteDetailsStatus_leave_feedback_for_driver";
        }
        else if ([comingFromViewController isEqualToString:@"Driver"])
        {
            leaveFeedbackViewController.comingFromViewController=@"RouteDetailsStatus_leave_feedback_for_passenger";
        }
        
    }
    else
    {
        NSLog(@"");
    }
}

#pragma mark-detecting back button pressed
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([comingFromViewController isEqualToString:@"Passenger"])
    {
        sharedRoutesAsDriver.comingFromViewController=@"Passenger";
    }
    else if ([comingFromViewController isEqualToString:@"Driver"])
    {
        sharedRoutesAsDriver.comingFromViewController=@"Driver";
    }
	[self stopUpdatingLocationCustom];
   
}

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
	
	[self.locationTracker updateLocationToServerWithoutSave];
}

@end
