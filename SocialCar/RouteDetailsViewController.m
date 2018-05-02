//
//  ViewControllerRouteDetails.m
//  TableViewSocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 22/02/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import "RouteDetailsViewController.h"


@interface RouteDetailsViewController ()

@end

@implementation RouteDetailsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    commonData = [[CommonData alloc]init];
    [commonData initWithValues];
    
    myTools = [[MyTools alloc]init];
    
    parseObjects = [[ParseObjects alloc]init];
    [parseObjects initWithValues];
    
    sharedProfile = [SharedProfileData sharedObject];
    
    sharedRoutes = [ShareRoutes sharedObject];
    sharedRoutes.feedbackArray = [[NSMutableArray alloc]init];
    
    sharedRoutesAsPassenger = [SharedRoutesAsPassenger sharedRoutesAsPassengerObject];

    lift = [[Lift alloc]init];
    
    stepsMArray = [[NSMutableArray alloc]init];
    
    stepsMArray = [sharedRoutes.tripSteps objectAtIndex:(int)sharedRoutes.trip_selected];
    
    //UITableView goes below over 50 from navigation bar. I remove the "margin" area between them
    
    self.label_origin.text = sharedRoutes.origin_address; //?
    self.label_destination.text = sharedRoutes.destination_address; //?
    
    NSMutableArray *tripsAfter = [[NSMutableArray alloc]init];
    tripsAfter = sharedRoutes.tripsAfter;
    
    TripRetrieved *tripRetrieved = [[TripRetrieved alloc]init];
    tripRetrieved = [tripsAfter objectAtIndex:sharedRoutes.trip_selected];
    
    self.label_duration.text = tripRetrieved.total_duration;
    self.label_duration.text = [self.label_duration.text  stringByAppendingString:NSLocalizedString(@"min.", @"min")];
    
    self.label_price.text = tripRetrieved.total_price;
    
    
    
    if (![tripRetrieved.total_price isEqualToString:commonData.notAvailable])
    {
        self.label_price.text = [self.label_price.text stringByAppendingString:tripRetrieved.currency];
    }
   
    self.tableViewRouteDetails.contentInset = UIEdgeInsetsMake(-50,0,0,0);
    
    
    //Check whether CAR POOLING EXISTS
    parametersRequest = [self createParametersForRequest];
    //If not hide button
    if (parametersRequest == nil)
    {
        self.btn_sendRequest.hidden = YES;
    }
    else
    {
        self.btn_sendRequest.hidden = NO;
    }
    //If CAR_POOLING_EXTERNAL exists
    if ([parametersRequest containsString:@"public_uri"])
    {
        self.btn_sendRequest.hidden = YES;
    }
 
    //Use the Auto Layout constraints and the contents of its cells to determine each cell’s height.
    //self.tableViewRouteDetails.rowHeight = UITableViewAutomaticDimension;
    //self.tableViewRouteDetails.estimatedRowHeight = 207.0f;
    
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
    
    Steps *step= [stepsMArray objectAtIndex:(int)indexPath.row];
   
    cell.image_transport_type.image = step.transport_image;
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
            cell.label_route_instruction.text = sharedRoutes.origin_address;
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
    
    //Do not show the start addres
/*    if (indexPath.row != 0)
    {
        [cell.label_route_instruction setHidden:NO];
        //cell.height_stackview_first_row.constant = 0.0f;
    }
    else
    {
        [cell.label_route_instruction setHidden:YES];
        //cell.height_stackview_first_row.constant = 24.0f;
    }
*/
    //Display the appropraite section for the CellRouteDetails table cell according to transport type
    if ([step.travel_mode isEqualToString:TRANSPORT_CAR_POOLING])
    {
      //?  cell.height_stackview_first_row.constant = 24.0f;
        
        [cell.label_departs_at setHidden:NO];
        [cell.label_arrives_to setHidden:NO];
        [cell.label_stops_names setHidden:YES]; //?
        [cell.label_transport_number setHidden:NO];
        
        cell.label_transport_number.text = driver.user_name;
        
        [cell.image_driver setHidden:NO];
        driver = [step.driver objectAtIndex:0];
        
        cell.image_driver.image = driver.user_image;
        
        [cell.image_next_route_details setHidden:NO];
        
        //Departure date time
        NSString *departDateTime = [myTools convertTimeStampToStringWithDateAndTime:step.start_address_date];
       
        cell.label_departs_at.text = NSLocalizedString(@"Departs ", @"Departs ");
        cell.label_departs_at.text = [cell.label_departs_at.text stringByAppendingString:departDateTime];
        
        //Arrival date time
        NSString *arrivalDateTime = [myTools convertTimeStampToStringWithDateAndTime:step.end_address_date];
        
        cell.label_arrives_to.text = NSLocalizedString(@"Arrives ", @"Arrives ");
        
        cell.label_arrives_to.text = [cell.label_arrives_to.text stringByAppendingString:arrivalDateTime];

        
        // Check to see whether it is GB
        NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
        NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
        
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
            
            //?NSString *departDateTime = [myTools convertTimeStampToStringWithDateAndTime:interPoint.starDateTimeTrip];
            NSString *departDateTime = [myTools convertTimeStampToStringWithDateAndTime:step.start_address_date];
            
            
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
        
        // Check to see wheteh it is GB
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

    [cell.label_stops setHidden:NO];

    [cell.label_circle_divider setHidden:NO];
    
    [cell.label_duration setHidden:NO];
    
   // cell.label_duration.text = [NSString stringWithFormat:@"%.0f",step.duration_step]; //@"2 stops";
    cell.label_duration.text = step.duration_step;
    
    cell.label_duration.text = [cell.label_duration.text stringByAppendingString:NSLocalizedString(@"min.", @"min.")];
    
    [cell.label_estimation_time setHidden:NO];
    
    
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
    NSLog(@"Row selected = %lu",(unsigned long)indexPath.row);
    Steps *step= [stepsMArray objectAtIndex:(int)indexPath.row];
    sharedRoutes.step_selected = (int) indexPath.row;
    
    if (step.has_CAR_POOLING)
    {
       // [self.navigationController performSegueWithIdentifier:@"showSegueRouteDetailsStatus" sender:self];
        
        /* IF step.external_carpooler */
        if (step.has_CAR_POOLING_EXTERNAL)
        {
            //Check whether CAR EXTERNAL is carpool.be and localised it
            NSString *carPooler = [self is_carpool_be:step.public_uri];
            
            ExternalCarpoolerViewController *newVC = [MainStoryboard instantiateViewControllerWithIdentifier:@"ExternalCarpoolerViewController"];
            
            newVC.extCarpoolerURL = carPooler;//step.public_uri;//@"*"; //here step.public_uri if present
            
            newVC.hidesBottomBarWhenPushed = YES;
        
            [self.navigationController pushViewController:newVC animated:YES];
            
            //Now disable button
            /*UIColor *color_title =[UIColor lightGrayColor];
            [self.btn_offerTrip setTitleColor:color_title forState:UIControlStateNormal];
            
            [self.btn_offerTrip setEnabled:NO];*/
            self.btn_sendRequest.hidden = YES;
        }
        else
        {
            indicatorView = [myTools setActivityIndicator:self];
            [indicatorView startAnimating];
        
            [self retrieveFeedback];
        }
    }
}

//107-34
/*- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if (indexPath.section == 1 && indexPath.row == 0)
    if (indexPath.row == 0)
    {
        return 90;
    }
    // "Else"
    return 107.0;
}
*/

#pragma mark - Retrieve Feedbacks for selected driver
-(void) retrieveFeedback
{
    
    //1. Create URL
    NSString *ulrStr = commonData.BASEURL_FOR_FEEDBACKS;
    
    ulrStr = [ulrStr stringByAppendingString:driver.userID];
    
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
    [urlRequest setHTTPMethod:HTTP_METHOD_GET];
    
    //5. Send Request to Server
    //?        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest];
    //?        [dataTask resume];
    //create the task
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                     
                                      NSLog(@"ParseJson !!!! =%@", json);
                                    
                                      
                                      [self fill_feedback:json];
                                      
                                      
                                  }];
    [task resume];
    
}

-(void) fill_feedback : (NSDictionary *) parseJSON
{
    if ( [parseJSON objectForKey:@"_error"])
    {
        NSString *str = [parseJSON objectForKey:@"_issues"];
        NSString *strFormatted = [NSString stringWithFormat: @"%@",str];
        
        NSLog(@"_issues(strFormatted)=%@",strFormatted);
        
//        sharedProfile.userID = @""; //set to none
        
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
        NSLog(@"Ok!");
        
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
//                if ([comingFromViewController isEqualToString:@"RetrieveLifts"])
//                {
//                    [sharedRoutesAsPassenger.feedbackArray addObject:feedbackData];
//                }
//                else
//                {
                    [sharedRoutes.feedbackArray addObject:feedbackData];
                //}
            }
        }
        
        //Now update GUI
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // code here
            [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
            [indicatorView stopAnimating];
            
            [self.navigationController performSegueWithIdentifier:@"showSegueDriverDetails" sender:self];
            
        });
        
       
    }

    
}


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

- (IBAction)btn_sendRequest:(id)sender
{
    
    //Start UIActivityIndicatorView for GUI purposes
    indicatorView = [myTools setActivityIndicator:self];
    [indicatorView startAnimating];
    
    [self createLifts];
    
}


#pragma mark - Create Lifts
- (void)createLifts
{
   // case_call_API = 1;
    //1. Create URL
    NSString *ulrStr = commonData.BASEURL_CREATE_LIFTS;
    
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    NSLog(@"urlWitString=%@",urlWithString);

/*  //As delegate
    //3.1 Configure Session Configuration with HTTP Additional Headers
    sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Cache-Control": @"no-cache", @"Accept" : @"application/json", @"Content-Type" : @"application/json", @"Authorization" : sharedProfile.authCredentials }];
    
    [sessionConfiguration setTimeoutIntervalForRequest: 75];//set to 75 secs
    //4. Create Session delegate
    sharedProfile.sessionGlobal = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate: self delegateQueue: [NSOperationQueue mainQueue]]; 
 //An operation queue for scheduling the delegate calls and completion handlers. The queue should be a serial queue, in order to ensure the correct ordering of callbacks. If nil, the session creates a serial operation queue for performing all delegate method calls and completion handler calls.
*/
    //2. Create and send Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //3. Set HTTP Headers and HTTP Method
    [urlRequest setValue:sharedProfile.authCredentials forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //4. Set HTTP Method
    [urlRequest setHTTPMethod:HTTP_METHOD_POST];
    
    //5. Set parameters as JSON
    [urlRequest setHTTPBody:[parametersRequest dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                      
                                      NSLog(@"ParseJson[createLift] =%@", parseJSON);
                                      
                                      [self fill_objectForRequest:parseJSON];
        
                                  }];
    [task resume];

    //8. Send Request to Server
//?    NSURLSessionDataTask *dataTask = [sharedProfile.sessionGlobal dataTaskWithRequest:urlRequest];
//?    [dataTask resume];
        
//    //9. Start UIActivityIndicatorView for GUI purposes
//    indicatorView = [myTools setActivityIndicator:self];
//    [indicatorView startAnimating];
    
}

-(NSString *) createParametersForRequest
{
    NSString *strParametersForRequest;
    
   // Driver *driver;
    Car  *car;
    Steps *step;
    
    //Get step which has travel_mode == CAR_POOLING
    for (int i=0;i<stepsMArray.count;i++)
    {
        step = [stepsMArray objectAtIndex:i];
        
        if ([step.travel_mode isEqualToString:TRANSPORT_CAR_POOLING])
        {
            driver = (Driver *)[ step.driver objectAtIndex:0];
            
            car = (Car *) [step.cars objectAtIndex:0];
            
            break;
        }
    }

    if (driver != nil)
    {
        
        
        //Create "start_point" from dictionaries
        NSDictionary *start_point_point =@{
                                            LAT : step.start_address_lat,
                                            LON : step.start_address_lon
                                           };
      
        lift.start_address_lat = step.start_address_lat;
        lift.start_address_lon = step.start_address_lon;
        lift.start_address = step.start_address;
        lift.start_address_date = step.start_address_date;
        
        NSDictionary *start_point =@{
                                     DATE : step.start_address_date,
                                     POINT : start_point_point,//[start_point_point allValues],
                                     ADDRESS : step.start_address
                                     };
        
        NSMutableDictionary *start_point_ALL = [[NSMutableDictionary alloc]init];
        [start_point_ALL addEntriesFromDictionary:start_point];
        
        
        lift.end_address_lat = step.end_address_lat;
        lift.end_address_lon = step.end_address_lon;
        lift.end_address = step.end_address;
        lift.end_address_date = step.end_address_date;
        
        //Create "end_point" from dictionaries
        NSDictionary *end_point_point =@{
                                           LAT : step.end_address_lat,
                                           LON : step.end_address_lon
                                        };
        
        NSDictionary *end_point =@{
                                   DATE : step.end_address_date,
                                   POINT : end_point_point, //[end_point_point allValues],
                                   ADDRESS : step.end_address
                                   };
        
        NSMutableDictionary *end_point_ALL = [[NSMutableDictionary alloc]init];
        [end_point_ALL addEntriesFromDictionary:end_point];
        
        //Now from "FindTrips json String convertt the "driver and "car" JSON object with driver_id and car_id
        NSDictionary *selectedTrip = [sharedRoutes.tripsBE objectAtIndex:sharedRoutes.trip_selected];
        
        
        NSMutableDictionary *dictionaryTripMut = [[NSMutableDictionary alloc]init];
        dictionaryTripMut = [NSMutableDictionary dictionaryWithObject:selectedTrip forKey:TRIP];
       
        NSArray *stepsArray = [[dictionaryTripMut valueForKey:@"trip"] valueForKey:@"steps"];
    
        ///////???
//        NSDictionary *route = [stepsMArray[0] valueForKey:@"route"];
//        [route valueForKey:@"intermediate"];
        /*
        
        NSDictionary *intermediate_points = [[ [[dictionaryTripMut valueForKey:@"trip"] valueForKey:@"steps"] valueForKey:@"route"] valueForKey:@"intermediate_points"];
        
        NSMutableDictionary *route = [ [[dictionaryTripMut valueForKey:@"trip"] valueForKey:@"steps"] valueForKey:@"route"];
        
        */
        
        //NSMutableArray *mutableArr = [stepsArray mutableCopy];
        
        
        
        //????
    //****** CHECK IT **********
    //    lift.steps = [NSMutableArray arrayWithArray:sharedRoutes.steps];
        
        lift.steps = [NSMutableArray arrayWithArray:stepsMArray];
        
        [dictionaryTripMut removeObjectForKey:@"steps"];
        
        for (int i=0;i<stepsArray.count;i++)
        {
            NSMutableDictionary *transport = [[NSMutableDictionary alloc] init];
            
            transport = [stepsArray[i] valueForKey:@"transport"];
            
            
            NSDictionary *carDict = [transport valueForKey:@"car"];
            NSDictionary *driverDict = [transport valueForKey:@"driver"];
            
            if (carDict !=nil)
            {
                [transport removeObjectForKey:@"car"];
                
                NSDictionary *car_id_dict = [NSDictionary dictionaryWithObject:car.car_id forKey:CAR_ID_];
                
                [transport addEntriesFromDictionary:car_id_dict];
                
                lift.car_id = car.car_id;
              
            }
            
            if (driverDict !=nil)
            {
                [transport removeObjectForKey:@"driver"];
                
                NSDictionary *driver_id_dict = [NSDictionary dictionaryWithObject:driver.userID forKey:DRIVER_ID];
                
                [transport addEntriesFromDictionary:driver_id_dict];
                
                lift.driver_id = driver.userID;
           
            }
            
        }
        
        NSDictionary *newTrips = @{
                                   @"steps" : stepsArray
                                };
        
        NSDictionary *dictionaryParamaters = @{
                                 PASSENGER_ID : sharedProfile.userID,
                                 RIDE_ID : step.ride_id,
                                 DRIVER_ID : driver.userID,
                                 CAR_ID_ : car.car_id,
                                 STATUS   : PENDING,
                                 START_POINT : start_point_ALL,
                                 END_POINT : end_point_ALL,
                                 TRIP : newTrips
                                 };
        
        //Convert NSDictionary to (JSON)String
        strParametersForRequest = [myTools dictionaryToJSONString:dictionaryParamaters];
        
    }
    NSLog(@"strRes=%@",strParametersForRequest);
    
    return strParametersForRequest;

}

#pragma mark - Fill Object
-(void) fill_objectForRequest: (NSDictionary *)parseJSON
{
    
  //  NSLog(@"parseJSON = %@", parseJSON);
    
    if ( [parseJSON objectForKey:@"_error"])
    {
        NSString *str = [parseJSON objectForKey:@"_issues"];
        NSString *strFormatted = [NSString stringWithFormat: @"%@",str];
        
        NSLog(@"_issues(strFormatted)=%@",strFormatted);
        
 //?       sharedProfile.userID = @""; //set to none
        
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
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
            [indicatorView stopAnimating];
        });
    }
    else
    {
        NSLog(@"Ok!");
        
        //Fill the rest items from the parseJSON to lift object
        lift._id = [parseJSON valueForKey:@"_id"];
        lift.ride_id = [parseJSON valueForKey:@"ride_id"];
        lift.passenger_id = [parseJSON valueForKey:@"passenger_id"];
        lift.status = [parseJSON valueForKey:@"status"];
        
        
        if (sharedRoutesAsPassenger.lifts != nil)
        {
            //[sharedRoutesAsPassenger.lifts addObject:lift];
            //Put the new one first
            [sharedRoutesAsPassenger.lifts insertObject:lift atIndex:0];
        }
        else
        {
            sharedRoutesAsPassenger.lifts = [[NSMutableArray alloc]init];
            [sharedRoutesAsPassenger.lifts addObject:lift];
        }
        
        //Update GUI with safe-thread
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
            [indicatorView stopAnimating];
            
            //Go to next screen
            //YOU WANT TO SWITCH to a Tab Bar Item.
   /*         NSArray *viewControllers = [self.tabBarController viewControllers];
            MyTripsNavigationController *myTripsNavigationController = [viewControllers objectAtIndex:2];
            
            NSArray *viewControllersNavigation = [myTripsNavigationController viewControllers];
            MyTripsViewController *myTripsViewController = [viewControllersNavigation objectAtIndex:0];
            
            [myTripsViewController.segmentControl setSelectedSegmentIndex:0];
            
//            UIViewController *requestedTrips = [self.storyboard instantiateViewControllerWithIdentifier:@"Segment_Requested_Trips"];
//           
//            [myTripsViewController setCurrentViewController:requestedTrips];
            myTripsViewController.currentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Segment_Requested_Trips"];
            
            myTripsViewController.currentViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
            [myTripsViewController addChildViewController:myTripsViewController.currentViewController];
          //?  [myTripsViewController addSubview:myTripsViewController.currentViewController.view toView:myTripsViewController.containerView];
            */
            
 //?           sharedRoutes.comingFrom = @"AsPassenger";
            
            [self.tabBarController setSelectedIndex:2];
           //

        });
        
    }
}

#pragma mark - convert array to dictionary
- (NSMutableDictionary *) indexKeyedDictionaryFromArray:(NSArray *)array
{
    id objectInstance;
  //  NSUInteger indexKey = 0U;
    int indexKey = 0;
    
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    for (objectInstance in array)
    {
        [mutableDictionary setObject:objectInstance forKey:[NSNumber numberWithInt:indexKey++]];
    }
    return (NSMutableDictionary *)mutableDictionary;
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
        
 //       sharedProfile.userID = @""; //set to none
        
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
        NSLog(@"Ok!");
      
        //Fill the rest items from the parseJSON to lift object
        lift._id = [parseJSON valueForKey:@"_id"];
        lift.ride_id = [parseJSON valueForKey:@"ride_id"];
        lift.passenger_id = [parseJSON valueForKey:@"passenger_id"];
        lift.status = [parseJSON valueForKey:@"status"];
        
        if (sharedRoutesAsPassenger.lifts != nil)
        {
            [sharedRoutesAsPassenger.lifts addObject:lift];
        }
        else
        {
            sharedRoutesAsPassenger.lifts = [[NSMutableArray alloc]init];
            [sharedRoutesAsPassenger.lifts addObject:lift];
        }
        
            
        
        
    }
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    [indicatorView stopAnimating];
    
    if(error == nil)
    {
        NSLog(@"Task finished succesfully!");
        
        //Go to next screen
        //YOU WANT TO SWITCH to a Tab Bar Item.
        [self.tabBarController setSelectedIndex:2];
        
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


#pragma mark - show localised
-(NSString *) is_carpool_be : (NSString *)external_carpooler
{
    NSString *carpool_be = @"*";
   
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    
    if ([external_carpooler containsString:carpool_be])
    {
        if ([countryCode isEqualToString:@"NL"])
        {
            external_carpooler = [external_carpooler stringByReplacingOccurrencesOfString:@"en" withString:@"nl"];
        }
        else if ([countryCode isEqualToString:@"FR"])
        {
            external_carpooler = [external_carpooler stringByReplacingOccurrencesOfString:@"en" withString:@"fr"];
        }
        
    }
    NSLog(@"external_carpooler= %@",external_carpooler);
    
    return external_carpooler;
    
}

@end
