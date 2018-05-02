//
//  ViewController.m
//  TableViewSocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 20/02/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import "RouteViewController.h"
#import "RouteTableViewCell.h"
#import <MapKit/MapKit.h>
#import "HomePassengerViewController.h"

@interface RouteViewController ()


@end

@implementation RouteViewController

UIDatePicker *datepicker;
//NSArray *tableData1;
//NSArray *thumbnails1;
//
//NSArray *tableData2;
//NSArray *thumbnails2;
NSArray *thumbnails_transport;


NSTimeInterval start_timeTimeInterval;
//2hours = 120 min = 7200secs
//4hours = 240 min = 14400secs
//10hours = 600 min = 36000secs
long period = (long)36000; //Add to start time


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    commonData = [[CommonData alloc]init];
    [commonData initWithValues];
    
    parseObjects = [[ParseObjects alloc]init];
    [parseObjects initWithValues];
    
    self.parametersForRequest = @"&use_bus=true&use_metro=true&use_train=true&transfer_mode=CHEAPEST_ROUTE=true&transfer_mode=FASTEST_ROUTE=true";
    
    
    myTools = [[MyTools alloc]init];

    sharedProfile = [SharedProfileData sharedObject];
    
    thumbnails_transport = [NSArray arrayWithObjects:@"ic_directions_car", @"ic_directions_bus",@"ic_train",@"ic_tram",@"ic_directions_walk",nil];
    
    
#pragma left line for addresses
    self.label_line_left = [self.label_line_left initWithFrame:CGRectMake(0,0, self.label_line_left.bounds.size.width, 2)];
    self.label_line_left.backgroundColor = [UIColor greenColor];
    
    [self.stackView_invert_addresses addArrangedSubview:self.label_line_left];
  
#pragma button 
    [self.stackView_invert_addresses addArrangedSubview:self.btn_invert_addresses];
    
  
#pragma line right for address
    self.label_line_right = [self.label_line_right initWithFrame:CGRectMake(0,0, self.label_line_right.bounds.size.width, 2)];
    self.label_line_right.backgroundColor = [UIColor greenColor];
    
    [self.stackView_invert_addresses addArrangedSubview:self.label_line_right];
    
    self.getRoutes = [[NSArray alloc]init];
    
    sharedRoutes = [ShareRoutes sharedObject];
    
    sharedRoutes.tripSteps = [[NSMutableArray alloc] init];
    sharedRoutes.tripsAfter = [[NSMutableArray alloc] init];
    
//*****************************************
    if ( sharedRoutes.tripsBE.count == 0) //&& (sharedRoutes.tripsBE.count != 0) )
    {
       //dispatch_async(dispatch_get_main_queue(), ^{
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
           
      // });
    }
    
    

    
//********************************************
    self.label_origin.text = sharedRoutes.origin_address;
    self.label_destination.text = sharedRoutes.destination_address;
    
    self.txtfield_departure.delegate = self;
    self.txtfield_preferences.delegate = self;
    
    self.txtfield_departure.text = NSLocalizedString(@"Departure:", @"Departure:");
   
    if (sharedRoutes.starTimeStampTrip != nil)
    {
         NSString *getDateTime = [myTools convertTimeStampToStringWithDateAndTime:sharedRoutes.starTimeStampTrip ];
        
        self.txtfield_departure.text = [self.txtfield_departure.text stringByAppendingString:getDateTime];
    }
    
    
}


#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    BOOL startEditing = YES;
    
    if (textField == self.txtfield_departure)
    {
        
        datepicker =[[UIDatePicker alloc] init];
        datepicker.datePickerMode = UIDatePickerModeDateAndTime;
       // setDatePickerMode:UIDatePickerModeDateAndTime
        datepicker.backgroundColor = [UIColor whiteColor];
        
        //Format date form datepciker and display it to the textfield
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
     //?   [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        [formatter setDateFormat:@"dd/MM/YYYY HH:mm"];

        [textField  setInputView:datepicker];
        
        //Create toolbar with "Done"button
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        [toolbar setTintColor:[UIColor grayColor]];
        
        //Custom Done BarButtonItem
        //UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(datePickerChanged)];
        
        //System BarButtonItme;better for localization
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(datePickerChanged)];
        
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        
        [toolbar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
        [textField setInputAccessoryView:toolbar];
        
       
    }
    else if (textField == self.txtfield_preferences)
    {
        txtfield_current_str = FILTERS;//TRAVEL_MODES;
        
        [self performSegueWithIdentifier:@"showTravelModesSegue" sender:self];
        
        //Do not edit
        startEditing = NO;
        
        
    }
    
    
    return startEditing;
}
/*
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
 */

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    //Add code
    //To not be edited by the user after selection from Alert Dialog
//    if ( (textField == self.txtfield_gender) || (textField == self.txtfield_carpooler_gender) )
//    {
//        return NO;
//    }
    //End of add code
    return NO;
}


#pragma mark - UITAbleViewDataSource
//Asks the data source for a cell to insert in a particular location of the table view.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   /* static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
      if (cell == nil)
     {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
     }
     
     cell.textLabel.text = @"Hello!";//[tableData objectAtIndex:indexPath.row];
    */
    
    static NSString *CellIdentifier = @"CellRoutes";
    RouteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RouteTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    int current_row = (int)indexPath.row;
    
    [self displayDataDynamicGUIInRow:cell atRow:current_row];// from:sharedRoutes.tripsBE[indexPath.row]];//withImages:thumbnails1];
    
    return cell;
}



/*- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSInteger rowCount = [self tableView:[tableData] numberOfRowsInSection:0];
    NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    
    if (rowIndex == 0) {
        background = [UIImage imageNamed:@"cell_top.png"];
    } else if (rowIndex == tableData.count -1) {
        background = [UIImage imageNamed:@"cell_bottom.png"];
    } else {
        background = [UIImage imageNamed:@"cell_middle.png"];
    }
    
    return background;
}*/

//return the number of rows in a given section of a table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 1;//[tableData count];
   // return sharedRoutes.routes.count;
   return sharedRoutes.tripsBE.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;//default value
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Row selected = %lu",(unsigned long)indexPath.row);
    //show ViewContollerRouteDetails
    //[self performSegueWithIdentifier:@"segueRouteDetails" sender:self];
    sharedRoutes.trip_selected = indexPath.row;
    
    //show ViewContollerRouteDetails from navigation
    [self.navigationController performSegueWithIdentifier:@"showSegueRouteDetails" sender:self];
    
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
*/

#pragma mark - displayDataDynamicGUIInRow CONNECTION TO SERVER
/*
 Create GUI dynamically and display data in the row of the table
 */
//-(void) displayDataDynamicGUIInRow : (RouteTableViewCell *)cell from:(NSArray *)tableData atRow:(NSIndexPath *)indexPath
-(void) displayDataDynamicGUIInRow : (RouteTableViewCell *)cell atRow:(int)current_row
{
   
    double total_distance = (double) 0.0;
    double total_price_amount = (double) 0.0;
    double total_time = (double) 0.0;
    double total_time_step_start = (double) 0.0;
    double total_time_step_end = (double) 0.0;
    NSDate *start_date;
    NSDate *end_date;
    
    TripRetrieved *tripRetrieved = [[TripRetrieved alloc]init];
    
    NSArray *steps = [sharedRoutes.tripsBE[current_row] valueForKey:@"steps"];
    
    sharedRoutes.steps = [[NSMutableArray alloc] initWithCapacity:steps.count];
    
    for (int j=0;j<steps.count;j++)
    {
        Steps *setStep= [[Steps alloc]init];
        
        NSDictionary *route = [ steps[j] valueForKey:@"route"];
        
        
        //intermediat points
        //setStep.intermediate_points = [[NSMutableArray alloc]init];
        
        NSArray *intermediate_points = [route valueForKey:@"intermediate_points"];
        
        for (int k=0;k<intermediate_points.count;k++)
        {
            IntermediatePoint *interPoint = [[IntermediatePoint alloc] init];
            
            NSString *address = [intermediate_points[k] valueForKey:@"address"];
            
            interPoint.address = address;
            
            NSDictionary *point = [intermediate_points[k] valueForKey:@"point"];
            
            NSString *x = [point valueForKey:@"lon"];
            NSString *y = [point valueForKey:@"lat"];
            
            interPoint.coordinate_x = x;
            interPoint.coordinate_y = y;
            
            NSString *departDate = [intermediate_points[k] valueForKey:@"date"];
            
            interPoint.starDateTimeTrip = departDate;
            
            [setStep.intermediate_points addObject:interPoint];
        }

        
        //route start_point
        NSDictionary *start_point = [route valueForKey:@"start_point"];
        NSString *date1 = [start_point valueForKey:@"date"];
        setStep.start_address_date = date1;
        
        if (j==0)
        {
            double time_start = [date1 doubleValue];
            total_time_step_start = time_start;
            
            start_date = [NSDate dateWithTimeIntervalSince1970:time_start];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd/mm/yyyy"];
            // NSDate *date = [dateFormatter dateFromString:string1];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:start_date];
            NSInteger hour = [components hour];
            setStep.start_hour = (int)hour;
            NSInteger minute = [components minute];
            setStep.start_min = (int)minute;
            
            //Now show it GUI
            //cell.label_time.text = @"11:00-11:30";
            cell.label_time.text = [NSString stringWithFormat:@"%i", setStep.start_hour];
            cell.label_time.text = [cell.label_time.text stringByAppendingString:@":"];
            
            if (setStep.start_min <10)
            {
                cell.label_time.text = [cell.label_time.text stringByAppendingString:@"0"];
            }
            
            cell.label_time.text = [cell.label_time.text stringByAppendingString:([NSString stringWithFormat:@"%i", setStep.start_min])];
            
            cell.label_time.text = [cell.label_time.text stringByAppendingString:@"-"];
            
        }
        
        NSDictionary *point1 = [start_point valueForKey:@"point"];
        
        //Get float value with 7 digits
        NSString *point1_lat = [NSString stringWithFormat:@"%.7f",[[point1 valueForKey:@"lat"] floatValue]];
        setStep.start_address_lat = point1_lat;
        
        NSString *point1_lon = [NSString stringWithFormat:@"%.7f",[[point1 valueForKey:@"lon"] floatValue]];
        setStep.start_address_lon = point1_lon;
        
        //?    NSDictionary *start_point_address = [start_point valueForKey:@"address"];
        NSString *start_point_address = [start_point valueForKey:@"address"];
        setStep.start_address = start_point_address;
        
        //route end_point
        NSDictionary *end_point = [route valueForKey:@"end_point"];
        NSString *date2 = [end_point valueForKey:@"date"];
        setStep.end_address_date = date2;
        
        double step_duration = (double) ([setStep.end_address_date intValue] - [setStep.start_address_date intValue]);
        step_duration = (double) ( (double)(step_duration) /(double) 60);
        step_duration = ceil(step_duration);
        
        NSString* formattedDuration = [NSString stringWithFormat:@"%.0f", step_duration];
        setStep.duration_step = formattedDuration;
        
        if (j==(steps.count-1))
        {
            double time_end = [date2 doubleValue];
            total_time_step_end = time_end;
            
            total_time  = total_time_step_end - total_time_step_start;
            total_time = (double) ( (double)(total_time) /(double) 60); //from secs to minutes
            
            //Convert to string
            //              NSNumber *myDoubleNumber = [NSNumber numberWithDouble:total_time];
            //              NSString *total_time_step = [myDoubleNumber stringValue];
            
            //             [duration_step addObject:total_time_step];
            //              [total_time_steps addObject:duration_step];
            
            
            
            NSString* formattedDuration = [NSString stringWithFormat:@"%.0f", total_time];
            tripRetrieved.total_duration = formattedDuration;
            
            end_date = [NSDate dateWithTimeIntervalSince1970:time_end];
            
            //Append cell with end time
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd/mm/yyyy"];
            // NSDate *date = [dateFormatter dateFromString:string1];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:end_date];
            NSInteger hour = [components hour];
            setStep.end_hour = (int)hour;
            NSInteger minute = [components minute];
            setStep.end_min = (int)minute;
            
            cell.label_time.text = [cell.label_time.text stringByAppendingString:([NSString stringWithFormat:@"%i", setStep.end_hour])];
            cell.label_time.text = [cell.label_time.text stringByAppendingString:@":"];
            
            if (setStep.end_min <10)
            {
                cell.label_time.text = [cell.label_time.text stringByAppendingString:@"0"];
            }
            cell.label_time.text = [cell.label_time.text stringByAppendingString:([NSString stringWithFormat:@"%i", setStep.end_min])];
        }
        
        NSDictionary *point2 = [end_point valueForKey:@"point"];
        NSString *point2_lat = [NSString stringWithFormat:@"%.7f",[[point2 valueForKey:@"lat"] floatValue]];
        setStep.end_address_lat = point2_lat;
        
        NSString *point2_lon = [NSString stringWithFormat:@"%.7f",[[point2 valueForKey:@"lon"] floatValue]];
        setStep.end_address_lon = point2_lon;
        
        //?   NSDictionary *end_point_address = [end_point valueForKey:@"address"];
        
        NSString *end_point_address = [end_point valueForKey:@"address"];
        setStep.end_address = end_point_address;
        
        //transport
        NSDictionary *transport = [steps[j] valueForKey:@"transport"];
        
        NSString *travel_mode = [transport valueForKey:@"travel_mode"];
        setStep.travel_mode = travel_mode;
        
        if ([setStep.travel_mode isEqualToString:TRANSPORT_CAR_POOLING])
        {
//            setStep = [self assignCarValuesForStep:setStep withDictionary:transport];
//            setStep = [self assignDriverValuesForStep:setStep withDictionary:transport];

            setStep = [parseObjects assignCarValuesForStep:setStep withDictionary:transport];
            setStep = [parseObjects assignDriverValuesForStep:setStep withDictionary:transport];
            
            Driver *driver = [setStep.driver objectAtIndex:0];
            setStep.transport_long_name = driver.user_name;
           
            NSString *rating = driver.rating;
            
            //Add asterisks next to driver's name
            if ([rating intValue] >0)
            {
                NSString *ratingAsterisks=@"";
                
                for (int i=0;i<([rating intValue]);i++)
                {
                    ratingAsterisks = [ratingAsterisks stringByAppendingString:@"*"];
                }
                
                setStep.transport_long_name = [ setStep.transport_long_name  stringByAppendingString:ratingAsterisks];
            }
            
            //Get the external provider URL if exists
            setStep.ride_id = [transport valueForKey:RIDE_ID];
            setStep.public_uri = [transport valueForKey:PUBLIC_URI];
            
            if (setStep.public_uri!=nil)
            {
             //   NSLog(@"setStep.public_uri=%@",setStep.public_uri);
                setStep.has_CAR_POOLING_EXTERNAL = YES;
            }
            
            setStep.transport_short_name =@"";
            setStep.transport_short_name = setStep.transport_long_name;
        }
        else //NOT CAR_POOLING
        {
            NSString *long_name = [transport valueForKey:@"long_name"];
            setStep.transport_long_name = long_name;
            
            NSString *short_name = [transport valueForKey:@"short_name"];
            setStep.transport_short_name = short_name;
        }
       
        //distance
        NSString *distance = [steps[j] valueForKey:@"distance"];
        total_distance = total_distance + [distance doubleValue];
        
        setStep.distance_step = [distance doubleValue];//total_distance;
        
        
        //price
        NSDictionary *price = [steps[j] valueForKey:@"price"];
        NSString *currency = [price valueForKey:@"currency"];
        setStep.currency = currency;
        
        NSString *amount = [price valueForKey:@"amount"];
        total_price_amount = total_price_amount + [amount doubleValue];
        
        NSString* formattedAmount = [NSString stringWithFormat:@"%.02f", [amount doubleValue]];
        setStep.amount = [formattedAmount doubleValue];
        
        [sharedRoutes.steps addObject:setStep];
        
    }
    
    //Noaw add the setps to the my NSMutuableArray tripsAfter
    [sharedRoutes.tripSteps addObject:sharedRoutes.steps];
    
    //Calculate total duration and display it
    double total_duration = (double) 0.0;
    
    //Calculate total duration and display it
    double total_cost = (double) 0.0;
    
    int x_position = 114;
    int distance_image_label = 34;//24x24 + 10
    int seperator_width = 20;
    //For the first element
    UIImage *image_tranport = [[UIImage alloc]init];
    
    Steps *getStepFirst = [sharedRoutes.steps objectAtIndex:0];
    
   // image_tranport = [self get_transport_image:getStepFirst.travel_mode];
    image_tranport = [parseObjects get_transport_image:getStepFirst.travel_mode withCarPoolingProvider:getStepFirst.has_CAR_POOLING_EXTERNAL];
    
    getStepFirst.transport_image = image_tranport;
    
    cell.image_transport.image = image_tranport;
    cell.label_tranport_details.text = getStepFirst.transport_short_name;
    
    for (int j=0;j<sharedRoutes.steps.count;j++)
    {
        Steps *getStep = [sharedRoutes.steps objectAtIndex:j];
        
        //Total duration??
  //?      total_duration = total_duration + getStep.duration_step;
        
        if ( getStep.amount >= 0 )
        {
            total_cost = total_cost + getStep.amount;
        }
        
        //            NSString* formattedDuration = [NSString stringWithFormat:@"%.0f", total_duration];
        //           tripRetrieved.total_duration = formattedDuration;
        
        cell.label_duration.text = tripRetrieved.total_duration;
        cell.label_duration.text = [cell.label_duration.text  stringByAppendingString:NSLocalizedString(@"min.", @"min")];
        
        //Retrieve currency
        if ([getStep.currency containsString:@"EUR"])
        {
            tripRetrieved.currency = @"€";
        }
        else if ([getStep.currency containsString:@"CHF"])
        {
            tripRetrieved.currency = @"CHF";
        }
        else if ([getStep.currency containsString:@"GBP"])
        {
            tripRetrieved.currency = @"GBP";
        }
        else
        {
            tripRetrieved.currency = @"";//Just empy
        }
        
        NSString* formattedPrice;
        
        if (total_cost > 0)
        {
            formattedPrice = [NSString stringWithFormat:@"%.02f", total_cost];
            tripRetrieved.total_price = formattedPrice;
            
            cell.label_price.text = formattedPrice;
            //cell.label_price.text = [cell.label_price.text  stringByAppendingString:NSLocalizedString(@"€", @"€")];
            cell.label_price.text = [cell.label_price.text  stringByAppendingString:tripRetrieved.currency];
        }
        else
        {
            formattedPrice = commonData.notAvailable;
            cell.label_price.text = formattedPrice;
            tripRetrieved.total_price = formattedPrice;
            //cell.label_price.text = [cell.label_price.text  stringByAppendingString:NSLocalizedString(@"€", @"€")];
            //cell.label_price.text = [cell.label_price.text  stringByAppendingString:tripRetrieved.currency];
        }
        
        
        
        
        //Get transport image
        image_tranport = [parseObjects get_transport_image:getStep.travel_mode withCarPoolingProvider:getStep.has_CAR_POOLING_EXTERNAL];
        
        if (j!=0)
        {
            UIImageView *imageViewTransport = [[UIImageView alloc]initWithFrame:CGRectMake(j*x_position, 0, 24,24)];
            
            imageViewTransport.image = image_tranport;
            
            getStep.transport_image = image_tranport;
            
            [cell.stackview_second_row addArrangedSubview:imageViewTransport];
            
            UILabel *label_transport_details = [[UILabel alloc]initWithFrame:CGRectMake(j*x_position+distance_image_label ,0, 80, 24)];
            
            //  label_transport_details.text = [tableData objectAtIndex:i]; //?
            label_transport_details.text = getStep.transport_short_name;
            
            [cell.stackview_second_row addArrangedSubview:label_transport_details];
            
            UILabel *label_seperator = [[UILabel alloc]initWithFrame:CGRectMake(j*x_position+distance_image_label + seperator_width ,0, seperator_width, 24)];
            
            label_seperator.text = @">";
            label_seperator.textColor = [UIColor lightGrayColor];
            label_seperator.font = [UIFont boldSystemFontOfSize:23];
            
            //if (i!= tableData.count-1)
            
            if (j != sharedRoutes.steps.count-1)
            {
                [cell.stackview_second_row addArrangedSubview:label_seperator];
            }
        }
        
    }
    
    [sharedRoutes.tripsAfter addObject:tripRetrieved];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark On Touch Events
- (void) datePickerChanged //:(UIDatePicker *)datepicker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
   // [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];//dd/MM/YYYY hh:min"];//"YYYY-MM-dd hh:min"];//dd-MM-YYYY"];
    
    [formatter setDateFormat:@"dd/MM/YYYY HH:mm"];
 
    self.txtfield_departure.text = NSLocalizedString(@"Departure:", @"Departure:");
                                    
    NSString *getDatTime = [NSString stringWithFormat:@"%@", [formatter stringFromDate:datepicker.date]];
    sharedRoutes.starDateTimeTrip = getDatTime; //Keep it in dd/MM/YY HH:mm
    
    //Keep in timestamp also
    start_timeTimeInterval = [datepicker.date timeIntervalSince1970];
    long start_timeInseconds = (long) (start_timeTimeInterval);
   
    sharedRoutes.starTimeStampTrip =  [NSString stringWithFormat:@"%ld",start_timeInseconds];
    
    self.txtfield_departure.text = [self.txtfield_departure.text stringByAppendingString:getDatTime];
    
    [self.txtfield_departure resignFirstResponder];
    
    
    //****************** Added
    NSArray *coords;
    if (sharedRoutes.invertAddresses_clicked == 0)
    {
        coords = [[NSArray alloc] initWithObjects:
                  sharedRoutes.origin_address_lon,
                  sharedRoutes.origin_address_lat,
                  sharedRoutes.destination_address_lon,
                  sharedRoutes.destination_address_lat,
              nil];
        
        NSLog(@"Origin address=%@",sharedRoutes.origin_address);
        NSLog(@"Destiantion address=%@",sharedRoutes.destination_address);
    }
    else if (sharedRoutes.invertAddresses_clicked == 1)
    {
        coords = [[NSArray alloc] initWithObjects:
                  sharedRoutes.destination_address_lon,
                  sharedRoutes.destination_address_lat,
                  sharedRoutes.origin_address_lon,
                  sharedRoutes.origin_address_lat,
                nil];
        
        NSLog(@"Origin address=%@",sharedRoutes.origin_address);
        NSLog(@"Destiantion address=%@",sharedRoutes.destination_address);

    }
    
    indicatorView = [myTools setActivityIndicator:self];
    [indicatorView startAnimating];

    [self findTrips:coords];
    
    //End of adding new code
}


- (IBAction)btn_invert_addresses_pressed:(id)sender {
    NSLog(@"Invert addresses pressed! invertAddresse_clicked = %ld",(long)sharedRoutes.invertAddresses_clicked );
    
    NSString *tempStr;
    NSArray *coords;
    
    if (sharedRoutes.invertAddresses_clicked == 0)
    {
        
        tempStr = self.label_destination.text;
        
        self.label_destination.text = self.label_origin.text;
        self.label_origin.text = tempStr;
        
        sharedRoutes.invertAddresses_clicked = 1;
        
        //Change origin and destination
        sharedRoutes.destination_address = self.label_destination.text;
        sharedRoutes.origin_address =self.label_origin.text;
        
        coords = [[NSArray alloc] initWithObjects:
                  sharedRoutes.destination_address_lon,
                  sharedRoutes.destination_address_lat,
                  sharedRoutes.origin_address_lon,
                  sharedRoutes.origin_address_lat,
                  nil];
        
    }
    else if (sharedRoutes.invertAddresses_clicked == 1)
    {
        tempStr = self.label_origin.text;
        
        self.label_origin.text = self.label_destination.text;
        self.label_destination.text = tempStr;
        
        sharedRoutes.invertAddresses_clicked = 0;
       
        //Change origin and destination
        sharedRoutes.origin_address =self.label_origin.text;
        sharedRoutes.destination_address = self.label_destination.text;
        
        coords = [[NSArray alloc] initWithObjects:
                  sharedRoutes.origin_address_lon,
                  sharedRoutes.origin_address_lat,
                  sharedRoutes.destination_address_lon,
                  sharedRoutes.destination_address_lat,
                  nil];

    }
    
    indicatorView = [myTools setActivityIndicator:self];
    [indicatorView startAnimating];
   
    [self findTrips:coords];
}

#pragma mark - Find trips
- (void)findTrips: (NSArray *) coordinates
{
    case_call_API = 1;
    //1. Create URL
    NSString *ulrStr = commonData.BASEURL_FOR_TRIPS;
    
   
    NSString *orignX1_str = [coordinates objectAtIndex:0];
    NSString *orignY1_str = [coordinates objectAtIndex:1];
    
    NSString *orignX2_str = [coordinates objectAtIndex:2];
    NSString *orignY2_str = [coordinates objectAtIndex:3];
    
    NSString *route  = @"start_lat=";
   
    route = [route stringByAppendingString:orignY1_str];
    route = [route stringByAppendingString:@"&start_lon="];
    route = [route stringByAppendingString:orignX1_str];
    
    route = [route stringByAppendingString:@"&end_lat="];
    route = [route stringByAppendingString:orignY2_str];
    
    route = [route stringByAppendingString:@"&end_lon="];
    route = [route stringByAppendingString:orignX2_str];
   
    //Create timestamps
    if (start_timeTimeInterval == 0 )
    {
 //   NSTimeInterval start_timeTimeInterval = [[NSDate date] timeIntervalSince1970];
        //Get the current timestamp in seconds
        start_timeTimeInterval = [[NSDate date] timeIntervalSince1970];

    }
    long start_timeInseconds = (long) (start_timeTimeInterval);
    
    NSString *startTime = [NSString stringWithFormat:@"%ld",start_timeInseconds];
    
    //Add period to 10 hours from start time
    long end_timeInseconds = (long) start_timeInseconds + period;
    NSString *endTime = [NSString stringWithFormat:@"%ld",end_timeInseconds];
    
    //Create transports
//?    NSString *transports = @"&use_bus=false&use_metro=true&use_train=true";
    
    //Create transfer_mode
//?    NSString *transfer_mode = @"&transfer_mode=CHEAPEST_ROUTE";
    
    //Create string for request
    NSString *createParams = [@"&start_date=" stringByAppendingString:startTime];
    
    //?NSString *createParams = @"&start_date=1498383689";
   
    createParams = [createParams stringByAppendingString:@"&end_date="];
    createParams = [createParams stringByAppendingString:endTime];
 //?   createParams = [createParams stringByAppendingString:transports];
   //? createParams = [createParams stringByAppendingString:transfer_mode];
    createParams = [createParams stringByAppendingString:self.parametersForRequest];
    
    //route = [route stringByAppendingString:@"&start_date=1465480828&end_date=1465498800&use_bus=false&use_metro=true&use_train=true&transfer_mode=CHEAPEST_ROUTE"];
    
    route = [route stringByAppendingString:createParams];
    
    //  NSString *route2 = @"start_lat=41.89&start_lon=12.51&end_lat=41.69&end_lon=12.60&start_date=1465480828&end_date=1465498800&use_bus=false&use_metro=true&use_train=true&transfer_mode=CHEAPEST_ROUTE";
    
    
    ulrStr = [ulrStr stringByAppendingString:route];
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    NSLog(@"urlWitString=%@",urlWithString);

/*  //As delegate
    sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Cache-Control": @"no-cache", @"Accept" : @"application/json", @"Content-Type" : @"application/json", @"Authorization" : sharedProfile.authCredentials }];
    
    [sessionConfiguration setTimeoutIntervalForRequest: 75];//set to 75 secs
    //4. Create Session delegate
    sharedProfile.sessionGlobal = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate: self delegateQueue: [NSOperationQueue mainQueue]]; 
 */
    //2. Create and send Request
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //3. Set HTTP Headers and HTTP Method
    [urlRequest setValue:sharedProfile.authCredentials forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //4. Set HTTP Method
    [urlRequest setHTTPMethod:HTTP_METHOD_GET];//@"GET"];
    
    //5. Send Request to Server
   //? NSURLSessionDataTask *dataTask = [sharedProfile.sessionGlobal dataTaskWithRequest:urlRequest];
   //? [dataTask resume];
    
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
//                                      indicatorView = [myTools setActivityIndicator:self];
//                                      [indicatorView startAnimating];
                                      
                                      NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                      NSLog(@"ParseJson[findTrips] =%@", parseJSON);
                                      
                                      [self fill_Trips:parseJSON];
                                      
                                  }];
    [task resume];
    
    //8. Start UIActivityIndicatorView for GUI purposes
//    indicatorView = [myTools setActivityIndicator:self];
//    [indicatorView startAnimating];
    
}
#pragma mark - Fill Trips Object
-(void) fill_Trips:(NSDictionary *)parseJSON
{
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
        NSArray *trips = [parseJSON valueForKey:@"trips"];
        //arrRoutesSocialCar = trips;
        
        //Assign trips reteived from Call to sharedObject
        sharedRoutes.tripsBE = trips;
        
        // NSString *rertieveTripsInJSON = [parseJSON valueForKey:@"trips"];
        //   NSLog(@"rertieveTripsInJSON = %@", rertieveTripsInJSON);
        
        //Update GUI with safe-thread
        //Since UIKit is not thread safe, need to dispatch back to main thread to update UI
        //From : https://stackoverflow.com/questions/28302019/getting-a-this-application-is-modifying-the-autolayout-engine-from-a-background
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // code here
            [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
            [indicatorView stopAnimating];
            
            [self.navigationController
             performSegueWithIdentifier:@"showSegueRoutes" sender:self];
            
//            NSArray *viewControllers = [self.navigationController viewControllers];
//            
//            RouteViewController *routeViewController = viewControllers[2];
//            [self.navigationController  popToViewController:routeViewController animated:YES];
            
            
        });
    }

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
        if (case_call_API == 1)
        {
            // NSLog(@"Ok!");
            
            NSArray *trips = [parseJSON valueForKey:@"trips"];
            //arrRoutesSocialCar = trips;
            
            //Assign trips reteived from Call to sharedObject
            sharedRoutes.tripsBE = trips;
            NSString *rertieveTripsInJSON = [parseJSON valueForKey:@"trips"];
            NSLog(@"rertieveTripsInJSON = %@", rertieveTripsInJSON);
            
            //[self.navigationController performSegueWithIdentifier:@"showSegueRoutes" sender:self];
            
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
        
        //No go the next screen
        if (case_call_API == 1)
        {
            [self.navigationController
             performSegueWithIdentifier:@"showSegueRoutes" sender:self];
        }
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





/*
-(void) displayRoutes: (NSArray *)array
{
    NSLog(@"displayRoutes");
 
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         MKRoute *route = obj;
 
         NSLog(@"Route Name : %@",route.name);
         NSLog(@"Total Distance (in Meters) :%f",route.distance);
         
         NSArray *steps = [route steps];
         
         NSLog(@"Total Steps : %lu",(unsigned long)[steps count]);
         
         [steps enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
          {
              NSLog(@"Route Instruction : %@",[obj instructions]);
              NSLog(@"Route Distance : %f",[obj distance]);
          }];
     }];
}
 */

//if you need to pass data to the next controller do it here
//See http://stackoverflow.com/questions/22759167/how-to-make-a-push-segue-when-a-uitableviewcell-is-selected
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"showTravelModesSegue"])
    {
        //if you need to pass data to the next controller do it here
        MultipleSelectionTableViewController *multipleSelectionTableVC = (MultipleSelectionTableViewController *)segue.destinationViewController;
        
        multipleSelectionTableVC.txtfieldEnteredTitle = txtfield_current_str;
        multipleSelectionTableVC.comingFrom = @"FindTrips";
    }
}
  

    

@end
