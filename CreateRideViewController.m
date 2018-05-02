//
//  CreateRideViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH)on 26/07/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import "CreateRideViewController.h"

@interface CreateRideViewController ()

@end

@implementation CreateRideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Initialise singleton
    sharedProfile = [SharedProfileData sharedObject];
    
    sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];
    
    sharedDriverPofile = [SharedDriverProfileData sharedObject];
    
    commonData = [[CommonData alloc]init];
    [commonData initWithValues];
    
    myTools = [[MyTools alloc]init];
    
    
    ride = [[Ride alloc]init];
    NSMutableArray *rides = sharedRoutesAsDriver.rides;
    //Get the last object which currently under construction
    ride = [rides objectAtIndex:rides.count-1];
    
    //Delete the temporare ride and add it later in case it will be created
    [sharedRoutesAsDriver.rides removeObjectAtIndex:sharedRoutesAsDriver.rides.count-1];
    coordinates = ride.coordinates;
    
    //Display Line
    self.label_line = [self.label_line initWithFrame:CGRectMake(0,0, self.label_line.bounds.size.width, 1)];
    self.label_line.backgroundColor = [UIColor grayColor];
    
    [self.stackview_line addArrangedSubview:self.label_line];
    
    self.txtfield_trip_name.delegate = self;
    self.txtfield_date_time.delegate = self;
    
    self.label_origin.text = ride.origin_address;
    self.label_destination.text = ride.destination_address;
    
    //Show driver name and car model
    self.label_driver_name.text = sharedProfile.user_name;
    self.label_car_model.text = sharedDriverPofile.model;
    
    
    //Init dateTimeForPicker to current datE time
   // NSTimeInterval timeInSeconds = [[NSDate date] timeIntervalSince1970];
    
    //long start_timeInseconds = (long) (timeInSeconds);
    start_timeTimeInterval = [[NSDate date] timeIntervalSince1970];
    //Init with current date time
   // dateTimeForPicker = [NSString stringWithFormat:@"%ld",start_timeInseconds];
    
}


#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //BOOL startEditing = YES;
    
    if (textField == self.txtfield_date_time)
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
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{

    return YES;
}
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
    if (textField == self.txtfield_date_time)
    {
        return NO;
    }
    /*else if (textField == self.txtfield_trip_name)
    {
        return YES;
    }*/
    return YES;
    
}


//hide the keyboard when you press the return or done button of the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    /// [textField resignFirstResponder];
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    
    return NO;
}

#pragma mark - createRide
- (void)createRide
{
    //  case_call_API = 1;
    //1. Create URL
    NSString *ulrStr = commonData.BASEURL_CREATE_RIDES;
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    NSLog(@"urlWitString=%@",urlWithString);
    
    //Origin coordinates
    NSNumber *floatNumberX1 = [coordinates objectAtIndex:0];
    NSString *orignX_str = [myTools convertFloatToString:floatNumberX1];
    ride.start_point_lon = orignX_str;
    
    NSNumber *floatNumberY1 = [coordinates objectAtIndex:1];
    NSString *orignY_str = [myTools convertFloatToString:floatNumberY1];
    ride.start_point_lat = orignY_str;
    
    //Destination coordinates
    NSNumber *floatNumberX2 = [coordinates objectAtIndex:2];
    NSString *destinationX_str  = [myTools convertFloatToString:floatNumberX2];
    ride.end_point_lon = orignX_str;
    
    NSNumber *floatNumberY2 = [coordinates objectAtIndex:3];
    NSString *destinationY_str = [myTools convertFloatToString:floatNumberY2];
    ride.end_point_lat = orignY_str;
    
    //Create timestamps
    //NSTimeInterval start_timeTimeInterval = [[NSDate date] timeIntervalSince1970];
    //Get it from datepicker
    long start_timeInseconds = (long) (start_timeTimeInterval);
    
    NSString *startTime = [NSString stringWithFormat:@"%ld",start_timeInseconds];
    ride.ride_date = startTime;
    
    //Prepare parameters for body
    //Create "end_point" from dictionaries
    NSDictionary *start_point =@{
                                 LAT : orignY_str,
                                 LON : orignX_str
                                 };
    
    NSDictionary *end_point =@{
                               LAT : destinationY_str,
                               LON : destinationX_str
                               };
    
    
    
    //BOOL valueBoolean = true;
    
    ///Create polyline after decision made
    ///polyline": "'coordinates=50.82732,3.26627;50.82721,3.26578;50.82746, 3.26545;50.82795, 3.26493;50.8276,..."
   /* NSString *polylineStr = @"coordinates=";
    polylineStr = [polylineStr stringByAppendingString:orignY_str];
    polylineStr = [polylineStr stringByAppendingString:@","];
    polylineStr = [polylineStr stringByAppendingString:orignX_str];
    polylineStr = [polylineStr stringByAppendingString:@";"];
    
    polylineStr = [polylineStr stringByAppendingString:destinationY_str];
    polylineStr = [polylineStr stringByAppendingString:@","];
    polylineStr = [polylineStr stringByAppendingString:destinationX_str];
    polylineStr = [polylineStr stringByAppendingString:@";"];
    */
    
    
    ///
	if ([sharedRoutesAsDriver.routeCoordinates_polyline hasSuffix:@","]) {
		sharedRoutesAsDriver.routeCoordinates_polyline = [sharedRoutesAsDriver.routeCoordinates_polyline substringToIndex:[sharedRoutesAsDriver.routeCoordinates_polyline length] - 1];
	}
    NSDictionary *dictionaryParamaters = @{
                                           
                                           START_POINT : start_point,
                                           
                                           END_POINT : end_point,
                                           
                                           DRIVER_ID : sharedProfile.userID,
                                           CAR_ID_ : sharedDriverPofile.car_id,
                                           
                                           //??? get it from text field
                                           @"name" : self.txtfield_trip_name.text,
                                          
                                           @"date" : startTime,
                                           
                                           //??? Convert it to boolean
                                           //@"activated" : @"true",
                                           @"activated" : [NSNumber numberWithBool:YES],
                                           
                                           //Get it from Apple's service
                                          // @"polyline": @"qyb_Gu`lkAdB`@tAJ"
                                           @"polyline":sharedRoutesAsDriver.routeCoordinates_polyline
                                           };
    //"name": "Home - Work Kostas",
    //"date": 1472832281,
    //"activated": true,
    //"polyline": "qyb_Gu`lkAdB`@tAJ"
    
    //Convert NSDictionary to (JSON)String
    NSString *strParametersForRequest = [myTools dictionaryToJSONString:dictionaryParamaters];
    
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
    [urlRequest setHTTPBody:[strParametersForRequest dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                      
                                      NSLog(@"ParseJson[createRides] =%@", parseJSON);
                                      
                                       [self fill_Rides:parseJSON];
                                      
                                  }];
    [task resume];
}

#pragma mark - Fill Ride Object
-(void) fill_Rides: (NSDictionary *)parseJSON
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
        NSString *ride_id = [parseJSON valueForKey:@"_id"];
        ride._id = ride_id;
        ride.ride_date = [parseJSON valueForKey:@"date"];
        
        //Fill objects for rides
        ride.car_id = [parseJSON valueForKey:@"car_id"];
        ride.driver_id = [parseJSON valueForKey:@"driver_id"];
        ride.name = [parseJSON valueForKey:@"name"];
        
        ride.polyline = [parseJSON valueForKey:@"polyline"];
        
        //convert value from boolean to nsstring
        ride.activated = [NSString stringWithFormat:@"%@",[parseJSON valueForKey:@"activated"]];
        
        
        ride.polyline = [parseJSON valueForKey:@"polyline"];
        
        NSArray *getLifts = [parseJSON valueForKey:@"lifts"];
        ride.lifts = [[NSMutableArray alloc]init];
        
        for (int i=0;i<getLifts.count;i++)
        {
            Lift *lift = [[Lift alloc]init];
            lift._id = [getLifts[i] valueForKey:@"_id"];
            
            //Add a lift if exists
            [ride.lifts addObject:lift];
        }
        
        //Add the new created ride
        [sharedRoutesAsDriver.rides addObject:ride];
        
        //Update GUI with safe-thread
        //Since UIKit is not thread safe, need to dispatch back to main thread to update UI
        //From : https://stackoverflow.com/questions/28302019/getting-a-this-application-is-modifying-the-autolayout-engine-from-a-background
        
        
         
        /* [self.navigationController
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
         */
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //Stop UIActivityIndicator
        [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
        [indicatorView stopAnimating];
    
        //To be deleted!!
 /*?       [self.navigationController popViewControllerAnimated:YES];
        
        NSArray *viewControllers = [self.navigationController viewControllers];
   ? */
        
        //EDW : !!!!!
        // Go to root naviagation
        //and then perform segue to Rides (segueShowRides)
        //If there Rides it wokring ok.
        //If you first time enter at "Offer New Trip" the
        //popToRootViewController is not going to Offer Trip Navigation
        UINavigationController *nav = self.navigationController;
        [nav popToRootViewControllerAnimated:YES];
        
        [self.navigationController performSegueWithIdentifier:@"segueShowRides" sender:self.navigationController];
        
        //HomePassengerViewController *homePassengerViewController = [viewControllers objectAtIndex:1];
        
        //Add Next > to navigation
        //homePassengerViewController.navigationItem.rightBarButtonItem = homePassengerViewController.btnItem_right;
        
       // homeSegments.navigationItem.rightBarButtonItem = homeSegments.nextBarBtnItem;
    });
    
}



#pragma mark On Touch Events
- (void) datePickerChanged //:(UIDatePicker *)datepicker
{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    // [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];//dd/MM/YYYY hh:min"];//"YYYY-MM-dd hh:min"];//dd-MM-YYYY"];
//    
//    [formatter setDateFormat:@"dd/MM/YYYY HH:mm"];
//    
//    // converting into our required date format
//    //[formatter setDateFormat:@"EEEE, MMMM dd, yyyy  HH:mm"];
//    
//    [formatter setDateFormat:@"EEE dd MMM yyyy  HH:mm"];
//    NSString *reqDateString = [formatter stringFromDate:datepicker.date];
//    NSLog(@"date is %@", reqDateString);
//    
//    
//    
//    NSString *getDateTime = [NSString stringWithFormat:@"%@", [formatter stringFromDate:datepicker.date]];
    
    //NSString *getDateTime = [myTools convertTimeStampToStringWithFormat:datepicker.date];
    
    //NSTimeInterval *start_timeTimeInterval = [datepicker.date timeIntervalSince1970];
    
    start_timeTimeInterval = [datepicker.date timeIntervalSince1970];

    self.txtfield_date_time.text  = [myTools convertTimeStampToStringWithFormat:datepicker.date];
    
       //self.txtfield_date_time.text = getDateTime;
    
    [self.txtfield_date_time resignFirstResponder];
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

- (IBAction)btn_create_pressed:(id)sender
{

    if (![self.txtfield_trip_name.text isEqual:@""])
    {
        indicatorView = [myTools setActivityIndicator:self];
        [indicatorView startAnimating];
    
        [self createRide];
    }
    else
    {
        NSString *message_title = NSLocalizedString(@"You have to write ride name.", @"You have to write ride name.");
        NSString *ok = NSLocalizedString(@"OK", @"OK");
        
        UIAlertController *alertAuthenticationError = [UIAlertController
                                                       alertControllerWithTitle:message_title
                                                       message:@""
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
}

#pragma mark - Navigation back button pressed
-(void) viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound)
    {
        //Remove the parially filled ride item
      //?*  [sharedRoutesAsDriver.rides removeObjectAtIndex:sharedRoutesAsDriver.rides.count-1];
    }
    
    [super viewWillDisappear:animated];
}

@end
