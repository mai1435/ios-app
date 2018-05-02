
//
//  MenuTabBarController.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 28/02/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "MenuTabBarController.h"
#import "AppDelegate.h"

@interface MenuTabBarController ()

@end

@implementation MenuTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //In case you have the delegate declared in AppDelegate
    //AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //self.delegate = appDelegate;
    
   
    sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];
    
    sharedRoutesAsPassenger = [SharedRoutesAsPassenger sharedRoutesAsPassengerObject];
    
    myTools = [[MyTools alloc]init];
    commonData = [[CommonData alloc]init];
    [commonData initWithValues];
    
    parseObjects = [[ParseObjects alloc]init];
    [parseObjects initWithValues];

    
    
    
    self.delegate = self;//appDelegate;
    self.tabBarItemPrevious = 0; //set to "Home" by default
    
    sharedProfile = [SharedProfileData sharedObject];
    
    sharedDriverProfile = [SharedDriverProfileData sharedObject];
    
    sharedRoutes = [ShareRoutes sharedObject];
	
	UIApplication *app = [UIApplication sharedApplication];
	CGFloat statusBarHeight = app.statusBarFrame.size.height;
	
	UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -statusBarHeight, [UIScreen mainScreen].bounds.size.width, statusBarHeight)];
	statusBarView.backgroundColor = [UIColor colorWithHex:@"96145C"];
	[self.moreNavigationController.navigationBar addSubview:statusBarView];
	
	self.moreNavigationController.navigationBar.tintColor = [UIColor whiteColor];
	NSArray *keys = [NSArray arrayWithObjects: NSForegroundColorAttributeName, nil];
	NSArray *objs = [NSArray arrayWithObjects: [UIColor whiteColor], nil];
	self.moreNavigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjects:objs forKeys:keys];;

	self.moreNavigationController.navigationBar.backgroundColor = [UIColor colorWithHex:@"96145C"];
	self.moreNavigationController.navigationBar.translucent = YES;

   // NSLog(@"tabBar.selectedItem=%@",self.tabBar.selectedItem.title);
//    UITableView *moreTableView = (UITableView *)self.moreNavigationController.topViewController.view;
//    moreTableView.delegate = self;
//    moreTableView.dataSource = self.moreNavigationController.topViewController.view;
    
}

//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return indexPath;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////#pragma mark - UINavigationControllerDeleagte
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    
//    
//    NSLog(@"controller class: %@", NSStringFromClass([viewController class]));
//    NSLog(@"controller title: %@", viewController.title);
//    //Terms&Conditions
////    NSString *localisedTitle=NSLocalizedString(@"Contact us",@"Contact us");
//    NSLog(@"self.tabBarController.navigationController.title) = %@",self.tabBarController.navigationController.title);
//    NSLog(@"self.tabBarController.navigationController.tabBarItem.titl) = %@",self.tabBarController.navigationController.tabBarItem.title);
//    
//    NSLog(@"selectedIndex = %lu",self.tabBarController.navigationController.tabBarController.selectedIndex);
//     NSLog(@"selectedIndex(2) = %lu",self.tabBarController.selectedIndex);
//    
////   
////    if ([viewController.title isEqualToString:localisedTitle])
////    {
////        NSLog(@"OK");
////        NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
////        NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
////        
////
////        if ( [countryCode isEqualToString:@"NL"] )
////        {
////            //[self.navigationController performSegueWithIdentifier:@"segueTermsConditions_NL" sender:self];
////        }
////        else if ( [countryCode isEqualToString:@"IT"] )
////        {
////            
////        }
////        else if ( [countryCode isEqualToString:@"FR"] )
////        {
////            
////        }
////        else if ( [countryCode isEqualToString:@"SI"] )
////        {
////            
////        }
////
////    }
//}

#pragma mark - UITabBarControllerDelegate
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
//    if (viewController == tabBarController.moreNavigationController)
//    {
//        tabBarController.moreNavigationController.delegate = self;
//        
//    }
    
    NSLog(@"tab selected: %@", tabBarController.tabBarItem.title);
  
    if (tabBarController.selectedIndex == 2)
    {
        //Coming by touching tab item "MyTrips"
        sharedRoutesAsPassenger.comingFromViewController = @"MyTrips";
    }
    else if (tabBarController.selectedIndex == 3) //"Logout"
    {
        NSString *message_title = NSLocalizedString(@"Logout?", @"Logout?");
        NSString *message_description = NSLocalizedString(@"Do you want to logout?", @"Do you want to logout?");
        NSString *yes= NSLocalizedString(@"Yes", @"Yes");
        NSString *no= NSLocalizedString(@"No", @"No");
        
        //[tabBarController setSelectedIndex:0];
        [tabBarController setSelectedIndex:self.tabBarItemPrevious];
        
        UIAlertController *alertLogout = [UIAlertController
                                              alertControllerWithTitle:message_title
                                              message:message_description
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *noAction = [UIAlertAction
                                   actionWithTitle:no
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       
                                       [alertLogout dismissViewControllerAnimated:YES completion:nil];
                                      
                                     //? [tabBarController setSelectedIndex:0];
                                       
                                   }];
        
        UIAlertAction *yesAction = [UIAlertAction
                                    actionWithTitle:yes
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                       //? LoginViewController_FINAL *signInVC = (LoginViewController_FINAL *)[self.storyboard instantiateViewControllerWithIdentifier:@"mainPageStoryboard"];
                                       // [self.navigationController pushViewController:signUpVC animated:YES];
                                       // self.view.window.rootViewController = signInVC;
                                        
                                    //?    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:signInVC];
                                     
                                        //mainNavigationController is the main Navigation Controller
                                        UINavigationController *mainNavContoller = [self.storyboard instantiateViewControllerWithIdentifier:@"mainNavigationController"];
                                        //set our controller as the root controller(initial controller)
                                        self.view.window.rootViewController = mainNavContoller;
                                        [self.view.window makeKeyAndVisible];
                                        
                                        if (sharedProfile.useGoogle)
                                        {
                                            [[GIDSignIn sharedInstance] disconnect];
                                        }
                                        else if (sharedProfile.useFacebook)
                                        {
                                            sharedProfile.useFacebook = NO;
                                            if ([FBSDKAccessToken currentAccessToken])
                                            {
                                                FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
                                                
                                                [loginManager logOut];
                                            }
                                        }
                                        //sharedProfile.userID =@"";
                                      //?  sharedProfile = [[SharedProfileData alloc] init];
                                        
                                     ///   sharedProfile.clearSharedObject = YES;
                                        [self clearSharedObjectValues];
                                        [self clearSharedObjectDriverValues];
                                        [self clearSharedRoutes];
                                        
                                        [self clearSharedRoutesAsDriverAndPassenger];
                                        
                                        //Remove user logged in from NSUserDefaults
                                       /* [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
                                       
                                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
                                        */
                                        KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"RideMyRouteLoginData" accessGroup:nil];
                                        
                                        [keychain resetKeychainItem];
                                        
                                        
                                        sharedProfile.alreadyloggeIn = NO;
                                        
                                        [self dismissViewControllerAnimated:YES completion:nil];
                                        //See https://developer.apple.com/library/content/qa/qa1561/_index.html . Exit is not suggessted by Apple
                                        //exit(0);
                                    
                                    }];
        
        [alertLogout addAction:noAction];
        [alertLogout addAction:yesAction];
        [self presentViewController:alertLogout animated:YES completion:nil];
    }
//    else if (tabBarController.selectedIndex == 2)
//    {
//        
//    }
   
//   NSLog(@"tabBarController.selectedIndex=%d",(int)tabBarController.selectedIndex);
    
    self.tabBarItemPrevious = (int)tabBarController.selectedIndex;
}

-(void) clearSharedRoutes
{
    sharedRoutes.tripsBE = nil;
    
    //Step details
    sharedRoutes.steps = nil;
    sharedRoutes.tripsAfter = nil;
    
    
    sharedRoutes.origin_address = @"";
    
    sharedRoutes.origin_address_lat = @"";
    sharedRoutes.origin_address_lon = @"";
    
    sharedRoutes.destination_address = @"";
    sharedRoutes.destination_address_lat = @"";
    sharedRoutes.destination_address_lon = @"";
    
    sharedRoutes.tripSteps = nil;
    sharedRoutes.trip_selected = 0;
    sharedRoutes.step_selected = 0;
    
    sharedRoutes.invertAddresses_clicked = 0;
    sharedRoutes.starDateTimeTrip= @"";

}

-(void) clearSharedObjectValues
{
    [sharedProfile.sessionGlobal invalidateAndCancel];
    
    sharedProfile.sessionGlobal = nil;
    
    sharedProfile.userID=@"";
    sharedProfile.authCredentials = @"";
    sharedProfile.email=@"";
    sharedProfile.password=@"";
    sharedProfile.user_name=@"";
    sharedProfile.phone=@"";
    sharedProfile.dateofBirth=@"";
    sharedProfile.gender=@"";
    sharedProfile.user_image=nil; //?
    
    sharedProfile.picture_id=@"";
    sharedProfile.picture_file=@"";
    
    sharedProfile.rating=@"";
    
    sharedProfile.max_no_transfers=@"";
    sharedProfile.max_cost=@"";
    sharedProfile.max_distance=@"";
    
    sharedProfile.carpooler_age=@"";
    sharedProfile.carpooler_gender=@"";
    
    sharedProfile.gps_tracking=@"";
    sharedProfile.smoking=@"";
    sharedProfile.food=@"";
    sharedProfile.music=@"";
    sharedProfile.pets=@"";
    sharedProfile.luggage=@"";
  
    //Do not clear it; MOVENDA set to NOT_INITIALISED
   // sharedProfile.fcm_token= FCM_TOKEN_NOT_INITIALISED;//To be used later

    sharedProfile.tableTravelModesValues=nil; //?
    sharedProfile.tableOptimiseTravelSolutions=nil;
    sharedProfile.tableSpecialNeeds=nil;
    
    sharedProfile.hasCar=NO;
    sharedProfile.useFacebook = NO;
    
    sharedProfile.useGoogle = NO;
    sharedProfile.google_userID = @"";
    sharedProfile.google_idToken = @"";
    
}

-(void) clearSharedObjectDriverValues
{
    sharedDriverProfile.car_id=@"";
    sharedDriverProfile.model=@"";
    
    sharedDriverProfile.plate=@"";
    sharedDriverProfile.colour=@"";
    sharedDriverProfile.colour_text = nil;
    sharedDriverProfile.seats=@"";
    sharedDriverProfile.food=@"";
    sharedDriverProfile.smoking=@"";
    
    sharedDriverProfile.air_conditioning=@"";
    sharedDriverProfile.pets=@"";
    sharedDriverProfile.luggage=@"";
    sharedDriverProfile.child_seat=@"";
    sharedDriverProfile.music=@"";
    
    sharedDriverProfile.car_image=nil;
    sharedDriverProfile.car_picture_id=@"";
    sharedDriverProfile.car_picture_file=@"";
    
}


-(void) clearSharedRoutesAsDriverAndPassenger
{
    sharedRoutesAsDriver.lifts = nil;
    sharedRoutesAsDriver.lift_selected = 0;
    sharedRoutesAsDriver.rides = nil;
    sharedRoutesAsDriver.ride_selected = 0;
    sharedRoutesAsDriver.feedbackArray = nil;
    sharedRoutesAsDriver.step_selected = 0;
    
    sharedRoutesAsPassenger.lifts = nil;
    //Selected trip form TableView
    sharedRoutesAsPassenger.lift_selected = 0;
    //Selected step form TableView
    sharedRoutesAsPassenger.step_selected = 0;
    sharedRoutesAsPassenger.feedbackArray = nil;
}


//TO BE DELETED

//#pragma mark - Retrieve Lifts as passenger
//- (void)retrieveLiftsPassenger
//{
//   // case_call_API = 1;
//    //1. Create URL
//    NSString *ulrStr = commonData.BASEURL_LIFTS_PASSENGER;
//    
//    //route = [route stringByAppendingString:@"&start_date=1465480828&end_date=1465498800&use_bus=false&use_metro=true&use_train=true&transfer_mode=CHEAPEST_ROUTE"];
//    
//  //  ulrStr = [ulrStr stringByAppendingString:@"58d3ac61e04bd5249b4f6608"];//]sharedProfile.userID];
//    ulrStr = [ulrStr stringByAppendingString:sharedProfile.userID];
//    
//    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
//    NSLog(@"urlWitString=%@",urlWithString);
//    
//    //2. Get credentials from GUI
//    /*    NSURLCredential *newCredential = [NSURLCredential credentialWithUser:sharedProfile.email password: sharedProfile.password persistence:NSURLCredentialPersistenceNone];
//     
//     NSString *authStr = [newCredential user];
//     authStr = [authStr stringByAppendingString:@":"];
//     authStr  = [authStr stringByAppendingString:[newCredential password] ];
//     NSLog(@"authStr=%@",authStr);
//     
//     NSLog(@"username=%@",[newCredential user]);
//     NSLog(@"hasPassword=%i",[newCredential hasPassword]);
//     NSLog(@"password=%@",[newCredential password]);
//     
//     //2.1 Create string authValue for sessionConfiguration (3) => "Basic xxxxxxxxx"
//     NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
//     NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
//     
//     //3. Create Session Configuration
//     //       NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//     
//     */
//    //3.1 Configure Session Configuration with HTTP Additional Headers
//    //     [sessionConfiguration setAllowsCellularAccess:YES];
//    sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    
//  //?  [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Cache-Control": @"no-cache", @"Accept" : @"application/json", @"Content-Type" : @"application/json", @"Authorization" : sharedProfile.authCredentials }];
//    
//    [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Accept" : @"application/json", @"Content-Type" : @"application/json", @"Authorization" : sharedProfile.authCredentials }];
//    
//    [sessionConfiguration setTimeoutIntervalForRequest: 125];//set to 75 secs
//    [sessionConfiguration setTimeoutIntervalForResource: 125];//set to 75 secs
//    
//    //4. Create Session delegate
//    sharedProfile.sessionGlobal = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate: self delegateQueue: [NSOperationQueue mainQueue]]; /*An operation queue for scheduling the delegate calls and completion handlers. The queue should be a serial queue, in order to ensure the correct ordering of callbacks. If nil, the session creates a serial operation queue for performing all delegate method calls and completion handler calls.*/
//    
//    //5. Create and send Request
//    //NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://46.101.238.243:5000/rest/v2/users?email="]];
//    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
//    //6. Set HTTP Method
//    [urlRequest setHTTPMethod:HTTP_METHOD_GET];//@"GET"];
//    
//    //7. Send Request to Server
//    NSURLSessionDataTask *dataTask = [sharedProfile.sessionGlobal dataTaskWithRequest:urlRequest];
//    [dataTask resume];
//    
//    //8. Start UIActivityIndicatorView for GUI purposes
//    indicatorView = [myTools setActivityIndicator:self];
//    [indicatorView startAnimating];
//    
//}

/*
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
        //if (case_call_API == 1)
        //{
            NSLog(@"Ok!");
            
            NSArray *getLifts = [parseJSON objectForKey:@"lifts"];
            sharedRoutesAsPassenger.lifts = [[NSMutableArray alloc]init];
            
            lift.steps  = [[NSMutableArray alloc]init];
            
        
            for (int i=0;i< getLifts.count;i++)
            {
                //Calculate total duration and amount
                //for each lift
                int total_steps_duration=0;
                double total_amount_steps=(double)0.0;

                
                lift = [[Lift alloc]init];
                
                lift.passenger_id = [getLifts[i] objectForKey:@"passenger_id"];
                lift.car_id = [getLifts[i] objectForKey:@"car_id"];
                lift._id = [getLifts[i] objectForKey:@"_id"];
                lift.driver_id = [getLifts[i] objectForKey:@"driver_id"];
                
                //Start point
                NSDictionary *start_point = [getLifts[i] objectForKey:@"start_point"];
                lift.start_address_date = [start_point objectForKey:@"date"];
                lift.start_address = [start_point objectForKey:@"address"];
                
                NSDictionary *start_point_coord = [start_point objectForKey:@"point"];
                lift.start_address_lon = [start_point_coord objectForKey:@"lon"];
                lift.start_address_lat = [start_point_coord objectForKey:@"lat"];
                
                //End point
                NSDictionary *end_point = [getLifts[i] objectForKey:@"end_point"];
                lift.end_address_date = [end_point objectForKey:@"date"];
                lift.end_address = [end_point objectForKey:@"address"];
                
                NSDictionary *end_point_coord = [end_point objectForKey:@"point"];
                lift.end_address_lon = [end_point_coord objectForKey:@"lon"];
                lift.end_address_lat = [end_point_coord objectForKey:@"lat"];
                
                lift.status = [getLifts[i] objectForKey:@"status"];
                lift.ride_id = [getLifts[i] objectForKey:@"ride_id"];
                
                //? trips = [[NSMutableArray alloc]init];
                //? NSArray *getTrips = [getLifts[i] objectForKey:@"trip"];
                NSDictionary *getTrips = [getLifts[i] objectForKey:@"trip"];
                
                NSArray *getSteps = [getTrips objectForKey:@"steps"];
                
                for (int k=0;k<getSteps.count;k++)
                {
                    step = [[Steps alloc]init];
                    
                    NSDictionary *transport = [getSteps[k] objectForKey:@"transport"];
                    
                    
                    NSString *travel_mode = [transport valueForKey:@"travel_mode"];
                    step.travel_mode = travel_mode;
                    
                    UIImage *image_tranport = [[UIImage alloc]init];
                    
                    image_tranport = [parseObjects get_transport_image: travel_mode withCarPoolingProvider:step.has_CAR_POOLING_EXTERNAL];
                    
                    step.transport_image = image_tranport;
                    
                    
                    if ([step.travel_mode isEqualToString:TRANSPORT_CAR_POOLING])
                    {
                        step = [parseObjects assignCarValuesForStep:step withDictionary:transport];
                        
                        step = [parseObjects assignDriverValuesForStep:step withDictionary:transport];
                        
                        Driver *driver = [step.driver objectAtIndex:0];
                        step.transport_long_name = driver.user_name;
                        
                        NSString *rating = driver.rating;
                        
                        //Add asterisks next to driver's name
                        if ([rating intValue] >0)
                        {
                            NSString *ratingAsterisks=@"";
                            
                            for (int i=0;i<([rating intValue]);i++)
                            {
                                ratingAsterisks = [ratingAsterisks stringByAppendingString:@"*"];
                            }
                            
                            step.transport_long_name = [ step.transport_long_name  stringByAppendingString:ratingAsterisks];
                        }
                        
                        step.transport_short_name =@"";
                        step.transport_short_name = step.transport_long_name;
                    }
                    else //NOT CAR_POOLING
                    {
                        NSString *long_name = [transport valueForKey:@"long_name"];
                        step.transport_long_name = long_name;
                        
                        NSString *short_name = [transport valueForKey:@"short_name"];
                        step.transport_short_name = short_name;
                    }
                    
                    //distance
                    NSString *distance = [getSteps[k] valueForKey:@"distance"];
                    step.distance_step = [distance doubleValue];
                    
                    //price
                    NSDictionary *price = [getSteps[k] valueForKey:@"price"];
                    NSString *currency = [price valueForKey:@"currency"];
                    step.currency = currency;
                    
                    if ([step.currency containsString:@"EUR"])
                    {
                        lift.lift_currency = @"€";
                    }
                    
                    NSString *amount = [price valueForKey:@"amount"];
                    
                    NSString* formattedAmount = [NSString stringWithFormat:@"%.02f", [amount doubleValue]];
                    step.amount = [formattedAmount doubleValue];
                    total_amount_steps = total_amount_steps + step.amount;
                    
                    //Get route for each step
                    NSDictionary *route = [getSteps[k] valueForKey:@"route"];
                    //route start_point
                    NSDictionary *start_point = [route valueForKey:@"start_point"];
                    NSString *date1 = [start_point valueForKey:@"date"];
                    step.start_address_date = date1;
                    
                    double time_start = [date1 doubleValue];
                    NSDate *start_date = [NSDate dateWithTimeIntervalSince1970:time_start];
                    
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"dd/mm/yyyy"];
                    // NSDate *date = [dateFormatter dateFromString:string1];
                    NSCalendar *calendar = [NSCalendar currentCalendar];
                    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:start_date];
                    NSInteger hour = [components hour];
                    step.start_hour = (int)hour;
                    NSInteger minute = [components minute];
                    step.start_min = (int)minute;
                    
                    
                    NSDictionary *point1 = [start_point valueForKey:@"point"];
                    
                    //Get float value with 7 digits
                    NSString *point1_lat = [NSString stringWithFormat:@"%.7f",[[point1 valueForKey:@"lat"] floatValue]];
                    step.start_address_lat = point1_lat;
                    
                    NSString *point1_lon = [NSString stringWithFormat:@"%.7f",[[point1 valueForKey:@"lon"] floatValue]];
                    step.start_address_lon = point1_lon;
                    
                    //?    NSDictionary *start_point_address = [start_point valueForKey:@"address"];
                    NSString *start_point_address = [start_point valueForKey:@"address"];
                    step.start_address = start_point_address;
                    
                    //route end_point
                    NSDictionary *end_point = [route valueForKey:@"end_point"];
                    NSString *date2 = [end_point valueForKey:@"date"];
                    step.end_address_date = date2;
                    
                    double step_duration = (double) ([step.end_address_date intValue] - [step.start_address_date intValue]);
                    step_duration = (double) ( (double)(step_duration) /(double) 60);
                    step_duration = ceil(step_duration);
                    total_steps_duration = total_steps_duration + step_duration;
                    
                    NSString* formattedDuration = [NSString stringWithFormat:@"%.0f", step_duration];
                    step.duration_step = formattedDuration;
                    
                    NSDictionary *point2 = [end_point valueForKey:@"point"];
                    NSString *point2_lat = [NSString stringWithFormat:@"%.7f",[[point2 valueForKey:@"lat"] floatValue]];
                    step.end_address_lat = point2_lat;
                    
                    NSString *point2_lon = [NSString stringWithFormat:@"%.7f",[[point2 valueForKey:@"lon"] floatValue]];
                    step.end_address_lon = point2_lon;
                    
                    //?   NSDictionary *end_point_address = [end_point valueForKey:@"address"];
                    
                    NSString *end_point_address = [end_point valueForKey:@"address"];
                    step.end_address = end_point_address;
                    
                    
                    [lift.steps addObject:step];
                    
                }//End for (int k=0;k<getSteps.count;k++
                
                NSString* formattedDuration = [NSString stringWithFormat:@"%.0d", total_steps_duration];
                lift.lift_total_duration = formattedDuration;
                
                NSString* formattedAmount = [NSString stringWithFormat:@"%.02f", total_amount_steps];
                lift.lift_total_price = formattedAmount;
                
                [sharedRoutesAsPassenger.lifts addObject:lift];
                
            }//End for (int i=0;i< getLifts.count;i++)
        
        NSArray *viewControllers = [self viewControllers];
        RequestedTripsViewController *requestedTripsViewController = [viewControllers objectAtIndex:1];
        
    }//end else
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    [indicatorView stopAnimating];
    
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
*/

#pragma mark - End of NSURLSession


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
