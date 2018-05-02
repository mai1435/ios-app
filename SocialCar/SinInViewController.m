
//
//  SinInViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 03/01/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "SinInViewController.h"

@interface SinInViewController ()  <SFSafariViewControllerDelegate>


@end

@implementation SinInViewController

NSMutableData *receivedData;

/*
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
   
    if (self)
    {
        NSLog(@"initialization");
        
        myTools = [[MyTools alloc]init];
        commonData = [[CommonData alloc]init];
        [commonData initWithValues];
        
        parseObjects = [[ParseObjects alloc]init];
        [parseObjects initWithValues];
        
        //Initialise singletons
        sharedProfile = [SharedProfileData sharedObject];
        sharedDriverProfile = [SharedDriverProfileData sharedObject];
        sharedRoutesAsPassenger = [SharedRoutesAsPassenger sharedRoutesAsPassengerObject];
        sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];
        

        if (sharedProfile.useGoogle)
        {
            self.txtfield_email.text = sharedProfile.email;
            
            self.txtfield_password.text = sharedProfile.password;
            
            [self authorizedUser];
            [self authenticateUser];
            
        }
    }
    return self;
}
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    myTools = [[MyTools alloc]init];
    commonData = [[CommonData alloc]init];
    [commonData initWithValues];
    
    parseObjects = [[ParseObjects alloc]init];
    [parseObjects initWithValues];
    
    //Initialise singletons
    sharedProfile = [SharedProfileData sharedObject];
    sharedDriverProfile = [SharedDriverProfileData sharedObject];
    sharedRoutesAsPassenger = [SharedRoutesAsPassenger sharedRoutesAsPassengerObject];
    sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];
    
    
    
#pragma SIGN UP button
    //For SIGN UP button
    self.btn_signUp.layer.borderWidth = 0.5;
    self.btn_signUp.layer.borderColor = UIColor.blackColor.CGColor;
 
#pragma TextField Email
    //Show icon to txtfiled_email
    UIImageView *imageView_email = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"email.png"]];
    
    imageView_email.frame = CGRectMake(imageView_email.frame.origin.x,imageView_email.frame.origin.y,imageView_email.frame.size.width +10, imageView_email.frame.size.height);
    imageView_email.contentMode = UIViewContentModeCenter;
    
    self.txtfield_email.leftViewMode = UITextFieldViewModeAlways;
    
    self.txtfield_email.leftView = imageView_email;
    //self.txtfield_email.borderStyle = UITextBorderStyleNone;
#pragma TextField Password
    UIImageView *imageView_password = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lock.png"]];
    
    imageView_password.frame = CGRectMake(imageView_password.frame.origin.x,imageView_password.frame.origin.y,imageView_password.frame.size.width +10, imageView_password.frame.size.height);
    imageView_password.contentMode = UIViewContentModeCenter;
    
    self.txtfield_password.leftViewMode = UITextFieldViewModeAlways;
    
    self.txtfield_password.leftView = imageView_password;
    

    //Define delegates
    self.txtfield_email.delegate = self;
    self.txtfield_password.delegate = self;
    
    if ( (sharedProfile.useGoogle) ||  (sharedProfile.useFacebook) || (sharedProfile.alreadyloggeIn) )
    {
        self.txtfield_email.text = sharedProfile.email;
        self.txtfield_password.text = sharedProfile.password;
        
//        self.txtfield_email.text = @"movesmartdemo@gmail.com";
//        self.txtfield_password.text = @"socialcar";
        
        [self.btn_signUp setEnabled:NO];
        [self.btn_signIn setEnabled:NO];
        
        [self authorizedUser];
        [self authenticateUser];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	//	[[self navigationController] setNavigationBarHidden:YES animated:NO];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage new]
												  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
	self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
	self.navigationController.navigationBar.translucent = YES;
	self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
	self.navigationController.view.backgroundColor = [UIColor clearColor];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)btn_forgot_password:(id)sender
{

    NSString *contact_url;
    
    
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    if ( [countryCode isEqualToString:@"GB"] )
    {
        contact_url = @"http://socialcar-project.eu/contact-en";
    }
    else if ( [countryCode isEqualToString:@"NL"] )
    {
        contact_url = @"http://socialcar-project.eu/contact-nl";
    }
    else if ( [countryCode isEqualToString:@"IT"] )
    {
        contact_url = @"http://socialcar-project.eu/contact-it";
    }
    else if ( [countryCode isEqualToString:@"FR"] )
    {
        contact_url = @"http://socialcar-project.eu/contact-fr";
    }
    else if ( [countryCode isEqualToString:@"SI"] )
    {
        contact_url = @"http://socialcar-project.eu/contact-si";
    }
    else
    {
        contact_url = @"http://socialcar-project.eu/contact";
    }
    
    
    SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:contact_url] entersReaderIfAvailable:NO];
    
    safariVC.delegate = self;
    [self presentViewController:safariVC animated:NO completion:nil];

}

- (IBAction)btn_signIn_pressed:(id)sender
{
//    sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    //2. Get credentials from GUI
//    newCredential = [NSURLCredential credentialWithUser:self.txtfield_email.text
//                                               password:self.txtfield_password.text
//                                            persistence:NSURLCredentialPersistenceNone];
//    authStr = [newCredential user];
//    authStr = [authStr stringByAppendingString:@":"];
//    authStr  = [authStr stringByAppendingString:[newCredential password] ];
//    NSLog(@"authStr=%@",authStr);
//    
//    NSLog(@"username=%@",[newCredential user]);
//    NSLog(@"hasPassword=%i",[newCredential hasPassword]);
//    NSLog(@"password=%@",[newCredential password]);
//    authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
//    authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
//    
//    sharedProfile.authCredentials = authValue;
    
 //   [self.btn_signUp setEnabled:NO];
 //   [self.btn_signIn setEnabled:NO];
    
    [self authorizedUser];
    [self authenticateUser];
    
    
    /*
    MenuTabBarController *menuTabBarController = (MenuTabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"menuTabStoryboard"];
    
    //UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:menuTabBarController];
   
    self.view.window.rootViewController = menuTabBarController;
    [self.view.window makeKeyAndVisible];
     */
    
   
//    [self.navigationController pushViewController:menuTabBarController.navigationController  animated:YES];
   /*
    //Another way without stoyboard
    UIViewController *viewController = [viewControllers objectAtIndex:0];
    DriverIntroProfileViewController *driverIntroProfileVC;
    
    if ([viewController isKindOfClass:[HomeSegmentsViewController class]] )
    {
    HomeSegmentsViewController *homeViewController = (HomeSegmentsViewController *)viewController;//[viewControllers objectAtIndex:0];
    
    driverIntroProfileVC = homeViewController.driverViewController;
    
    }
    */

}

- (IBAction)btn_signUp_pressed:(id)sender {
    
    SignUpViewController *signUpVC = (SignUpViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"signUpStoryboard_new"];
    
    [self.navigationController pushViewController:signUpVC animated:YES];
    
}

#pragma mark - Authorize user
-(void) authorizedUser
{
    //Initialise singletons again for GOOGLE or FACEBOOK sign in
   /* sharedProfile = [SharedProfileData sharedObject];
    sharedDriverProfile = [SharedDriverProfileData sharedObject];
    sharedRoutesAsPassenger = [SharedRoutesAsPassenger sharedRoutesAsPassengerObject];
    sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];
    */
    
    sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //2. Get credentials
    if ( (sharedProfile.useGoogle) || (sharedProfile.useFacebook) )
    {
        newCredential = [NSURLCredential credentialWithUser:sharedProfile.email
                                                   password:sharedProfile.password
                                                persistence:NSURLCredentialPersistenceNone];
        
       // self.txtfield_email.text = sharedProfile.email;
       // self.txtfield_password.text = sharedProfile.password;
        
    }
    else //from GUI
    {
        newCredential = [NSURLCredential credentialWithUser:self.txtfield_email.text
                                               password:self.txtfield_password.text
                                            persistence:NSURLCredentialPersistenceNone];
    }
    
    authStr = [newCredential user];
    authStr = [authStr stringByAppendingString:@":"];
    authStr  = [authStr stringByAppendingString:[newCredential password] ];
    NSLog(@"authStr=%@",authStr);
    
    NSLog(@"username=%@",[newCredential user]);
    NSLog(@"hasPassword=%i",[newCredential hasPassword]);
    NSLog(@"password=%@",[newCredential password]);
    authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
    
    sharedProfile.authCredentials = authValue;
    
}

#pragma mark - Authentication
-(void) authenticateUser
{
   
    if  ( (![self.txtfield_email.text isEqualToString:@""]) &&
         (![self.txtfield_password.text isEqualToString:@""] ) )  //&& (userID != nil) )
    {
        case_call_API = 1;
        
        [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Cache-Control": @"no-cache", @"Accept" : @"application/json", @"Content-Type" : @"application/json", @"Authorization" : authValue  }];
        
        [sessionConfiguration setTimeoutIntervalForRequest:120];
        
        //Create Session delegate
        sharedProfile.sessionGlobal = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate: self delegateQueue: [NSOperationQueue mainQueue]]; /*An operation queue for scheduling the delegate calls and completion handlers. The queue should be a serial queue, in order to ensure the correct ordering of callbacks. If nil, the session creates a serial operation queue for performing all delegate method calls and completion handler calls.*/
        
        //? NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        
        //Send Request to http:46.101.238.243:5000/rest/v2/
        NSURL *url = [NSURL URLWithString:commonData.BASEURL];
        
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
        
        //Send Request to Server
        // NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:url];
        NSURLSessionDataTask *dataTask = [sharedProfile.sessionGlobal dataTaskWithRequest:urlRequest];
        
        [dataTask resume];
        
        //9. Start UIActivityIndicatorView for GUI purposes
        indicatorView = [myTools setActivityIndicator:self];
        [indicatorView startAnimating];
        
       
    }
    else
    {
        [self alertCustom];
    }
    
    

}


#pragma mark - Find user
- (void)findUser
{
    if  ( (![self.txtfield_email.text isEqualToString:@""]) &&
         (![self.txtfield_password.text isEqualToString:@""] ) )
    {
        
        case_call_API = 2;
        //1. Create URL
        NSString *ulrStr = commonData.BASEURL;
        ulrStr = [ulrStr stringByAppendingString:commonData.URL_users];
        ulrStr = [ulrStr stringByAppendingString:@"?email="];
        ulrStr = [ulrStr stringByAppendingString:self.txtfield_email.text];
        
        NSURL *urlWithString = [NSURL URLWithString:ulrStr];
        
        NSLog(@"urlWitString=%@",urlWithString);
        
//        //2. Get credentials from GUI
//        NSURLCredential *newCredential = [NSURLCredential credentialWithUser:self.txtfield_email.text
//                                                                    password:self.txtfield_password.text
//                                                                 persistence:NSURLCredentialPersistenceNone];
//        NSString *authStr = [newCredential user];
//        authStr = [authStr stringByAppendingString:@":"];
//        authStr  = [authStr stringByAppendingString:[newCredential password] ];
//        NSLog(@"authStr=%@",authStr);
//        
//        NSLog(@"username=%@",[newCredential user]);
//        NSLog(@"hasPassword=%i",[newCredential hasPassword]);
//        NSLog(@"password=%@",[newCredential password]);
        
        //2.1 Create string authValue for sessionConfiguration (3) => "Basic xxxxxxxxx"
//        NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
//        NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
        
        //3. Create Session Configuration
  //      NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        //3.1 Configure Session Configuration with HTTP Additional Headers
       // [sessionConfiguration setAllowsCellularAccess:YES];
      //  [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Accept" : @"application/json", @"Content-Type" : @"application/json", @"Authorization" : authValue  }];
          [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Cache-Control": @"no-cache", @"Content-Type" : @"application/json", @"Authorization" : authValue  }];
        
        //4. Create Session delegate
        sharedProfile.sessionGlobal = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate: self delegateQueue: [NSOperationQueue mainQueue]]; /*An operation queue for scheduling the delegate calls and completion handlers. The queue should be a serial queue, in order to ensure the correct ordering of callbacks. If nil, the session creates a serial operation queue for performing all delegate method calls and completion handler calls.*/
        
        
        //5. Create and send Request
        //NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://46.101.238.243:5000/rest/v2/users?email="]];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
        //6. Set HTTP Method
        [urlRequest setHTTPMethod:HTTP_METHOD_GET];//]@"GET"];
        
        //7. Send Request to Server
        NSURLSessionDataTask *dataTask = [sharedProfile.sessionGlobal dataTaskWithRequest:urlRequest];
        [dataTask resume];
        
        //8. Start UIActivityIndicatorView for GUI purposes
        indicatorView = [myTools setActivityIndicator:self];
        [indicatorView startAnimating];
        
    }
    else
    {
        [self alertCustom];
    }
    
}

#pragma mark - Retrieve user
- (void)retrieveUser
{
        case_call_API = 3;
        //1. Create URL
        NSString *ulrStr = commonData.BASEURL;
        ulrStr = [ulrStr stringByAppendingString:commonData.URL_users];
        ulrStr = [ulrStr stringByAppendingString:sharedProfile.userID];
    
        NSURL *urlWithString = [NSURL URLWithString:ulrStr];
        
        NSLog(@"urlWitString=%@",urlWithString);
    
        //3.1 Configure Session Configuration with HTTP Additional Headers
   //     [sessionConfiguration setAllowsCellularAccess:YES];
        [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Cache-Control": @"no-cache", @"Accept" : @"application/json", @"Content-Type" : @"application/json", @"Authorization" : authValue  }];
        
        //4. Create Session delegate
        sharedProfile.sessionGlobal = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate: self delegateQueue: [NSOperationQueue mainQueue]]; /*An operation queue for scheduling the delegate calls and completion handlers. The queue should be a serial queue, in order to ensure the correct ordering of callbacks. If nil, the session creates a serial operation queue for performing all delegate method calls and completion handler calls.*/
        
        //5. Create and send Request
        //NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://46.101.238.243:5000/rest/v2/users?email="]];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
        //6. Set HTTP Method
    [urlRequest setHTTPMethod:HTTP_METHOD_GET];//@"GET"];
        
        //7. Send Request to Server
        NSURLSessionDataTask *dataTask = [sharedProfile.sessionGlobal dataTaskWithRequest:urlRequest];
        [dataTask resume];
        
        //8. Start UIActivityIndicatorView for GUI purposes
      //  indicatorView = [myTools setActivityIndicator:self];
      //  [indicatorView startAnimating];
    
}

#pragma mark - retrieve CAR
- (void)retrieveCar
{
    case_call_API = 4;
    //1. Create URL
    //http://BASEURL/cars/57d6710ba377f26c67fd6ac5
    NSString *ulrStr = commonData.BASEURL;
    ulrStr = [ulrStr stringByAppendingString:commonData.URL_cars];
    ulrStr = [ulrStr stringByAppendingString:sharedDriverProfile.car_id];
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    NSLog(@" ********    RETRIEVE   CAR *********");
    NSLog(@"urlWitString=%@",urlWithString);
    
    sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Cache-Control": @"no-cache", @"Accept" : @"application/json", @"Content-Type" : @"application/json", @"Authorization" : authValue  }];
    
    //4. Create Session delegate
    sharedProfile.sessionGlobal  = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate: self delegateQueue: [NSOperationQueue mainQueue]]; /*An operation queue for scheduling the delegate calls and completion handlers. The queue should be a serial queue, in order to ensure the correct ordering of callbacks. If nil, the session creates a serial operation queue for performing all delegate method calls and completion handler calls.*/
    
    //5. Create and send Request
    //NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://46.101.238.243:5000/rest/v2/users?email="]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //6. Set HTTP Method
    [urlRequest setHTTPMethod:HTTP_METHOD_GET];//@"GET"];
    
    //7. Send Request to Server
    NSURLSessionDataTask *dataTask = [sharedProfile.sessionGlobal  dataTaskWithRequest:urlRequest];
    [dataTask resume];
    
    //8. Start UIActivityIndicatorView for GUI purposes
 //   indicatorView = [myTools setActivityIndicator:self];
 //   [indicatorView startAnimating];
    
}


#pragma mark - Retrieve Lifts as passenger
-(void) retrieveLiftsPassenger
{
    case_call_API = 5;
    
    //1. Create URL
    NSString *ulrStr = commonData.BASEURL_LIFTS_PASSENGER;
   
    ulrStr = [ulrStr stringByAppendingString:sharedProfile.userID];
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    
    NSLog(@"urlWitString=%@",urlWithString);
    //2. Create and send Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //3. Set HTTP Headers and HTTP Method
    [urlRequest setValue:authValue forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
   
    //4. Set HTTP Method
    [urlRequest setHTTPMethod:@"GET"];
    
    //5. Send Request to Server
    //?        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest];
    //?        [dataTask resume];
    //create the task
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                      NSLog(@"ParseJson [retrieveLiftsPassenger] =%@", json);
                                      
                                      [self fill_lifts:json AsPassenger:YES];
   
                                  }];
    [task resume];
    
}


#pragma mark - Retrieve Lifts as driver
-(void) retrieveLiftsAsDriver
{
    case_call_API = 6;
    
    //1. Create URL
    //http://BASEURL/lifts?driver_id=57d6710ba377f26c67c
    NSString *ulrStr = commonData.BASEURL_LIFTS_DRIVER;
    
    ulrStr = [ulrStr stringByAppendingString:sharedProfile.userID];
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    
    NSLog(@"urlWitString=%@",urlWithString);
    //2. Create and send Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //3. Set HTTP Headers and HTTP Method
    [urlRequest setValue:authValue forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    
    //4. Set HTTP Method
    [urlRequest setHTTPMethod:@"GET"];
    
    //5. Send Request to Server
    //?        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest];
    //?        [dataTask resume];
    //create the task
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                      NSLog(@"ParseJson[retrieveLiftsDriver]=%@", json);
                                      [self fill_lifts:json AsPassenger:NO];
                                      
                                      
                                  }];
    [task resume];
    
}


#pragma mark - Fill Objects
-(void) fill_lifts : (NSDictionary *)parseJSON AsPassenger: (BOOL)asPassenger
{
    NSLog(@"******* RETRIEVE LIFTS *************");
    
    NSArray *getLifts = [parseJSON objectForKey:@"lifts"];
   
    if (asPassenger)
    {
        sharedRoutesAsPassenger.lifts = [[NSMutableArray alloc]init];
    }
    else
    {
        sharedRoutesAsDriver.lifts = [[NSMutableArray alloc]init];
    }
    //EDW !!!!!!
   //? lift.steps  = [[NSMutableArray alloc]init];
    
    //Decrement for loop
    //for (int i=0;i< getLifts.count;i++)
    int totalLifts = (int)(getLifts.count);
    
    for (int i = totalLifts-1 ; i >= 0; --i)
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
        
        
        lift.steps  = [[NSMutableArray alloc]init];
        
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
                
                //Get the external provider URL if exists
                step.public_uri = [transport valueForKey:PUBLIC_URI];
                
                if (step.public_uri!=nil)
                {
                   // NSLog(@"setStep.public_uri=%@",step.public_uri);
                    step.has_CAR_POOLING_EXTERNAL = YES;
                    
                    image_tranport = [parseObjects get_transport_image: travel_mode withCarPoolingProvider:step.has_CAR_POOLING_EXTERNAL];
                    step.transport_image = image_tranport;
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
            
            // Check to see wheteh it is GB
            NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
            NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
            
            if ( [countryCode isEqualToString:@"GB"] )
            {
                float milesNumberFloat = step.distance_step* (float)3.280839895;//0.000621371;
                //Round to closest
                step.distance_step = round(milesNumberFloat);
            }
            
            
            //price
            NSDictionary *price = [getSteps[k] valueForKey:@"price"];
            NSString *currency = [price valueForKey:@"currency"];
            step.currency = currency;
            
            if ([step.currency containsString:@"EUR"])
            {
                lift.lift_currency = @"€";
            }
            else if ([step.currency containsString:@"CHF"])
            {
                lift.lift_currency = @"CHF";
            }
            else if ([step.currency containsString:@"GBP"])
            {
                lift.lift_currency = @"GBP";
            }
            else
            {
                lift.lift_currency = @""; //leave it empty
            }
            
            NSString *amount = [price valueForKey:@"amount"];
            
            NSString* formattedAmount = [NSString stringWithFormat:@"%.02f", [amount doubleValue]];
            step.amount = [formattedAmount doubleValue];
            
            if (step.amount >= 0)
            {
                total_amount_steps = total_amount_steps + step.amount;
            }
            
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
        
        //In case total_price is -X
        if (total_amount_steps > 0)
        {
            NSString* formattedAmount = [NSString stringWithFormat:@"%.02f", total_amount_steps];
            lift.lift_total_price = formattedAmount;
        }
        else
        {
            lift.lift_total_price = commonData.notAvailable;
        }
        
        if (asPassenger)
        {
            [sharedRoutesAsPassenger.lifts addObject:lift];
        }
        else
        {
            [sharedRoutesAsDriver.lifts addObject:lift];
        }
        
    }//End for (int i=0;i< getLifts.count;i++)
    
    NSLog(@"******* END OF RETRIEVE LIFTS *************");
    
    if (case_call_API == 5)
    {
        //Now prepare the next call
        NSLog(@"******* RETRIEVE LIFTS AS DRIVER *************");
        
        [self retrieveLiftsAsDriver];
        
        NSLog(@"******* END OF RETRIEVE LIFTS AS DRIVER *************");

        
    }
    else if (case_call_API == 6)
    {
        //Now prepare the next call
        [self retrieveRides];
//        //Now go to next screen
//        //Update GUI with safe-thread
//        dispatch_async(dispatch_get_main_queue(), ^{
//        
//            [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
//            [indicatorView stopAnimating];
//    
//            MenuTabBarController *menuTabBarController = (MenuTabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"menuTabStoryboard"];
//    
//            self.view.window.rootViewController = menuTabBarController;
//            [self.view.window makeKeyAndVisible];
//        
//        });
    }
}

-(void) fill_userProfile : (NSDictionary *) parseJSON
{
    NSArray *cars = [parseJSON valueForKey:@"cars"];
    
    if (cars.count!=0)
    {
        sharedProfile.hasCar = YES;
        sharedProfile.cars_ids  = [[NSMutableArray alloc]initWithCapacity:cars.count];
        
        for (int i=0;i<cars.count;i++)
        {
            // sharedProfile.cars  = [NSMutableArray arrayWithObjects:cars[,no,no,no,no, nil];
            [sharedProfile.cars_ids addObject:cars[i]];
        }
        sharedDriverProfile.car_id = [sharedProfile.cars_ids lastObject]; //Get the last object
    }
    
    
    sharedProfile.userID = [parseJSON valueForKey:@"_id"];
    NSLog(@"_id=%@",[parseJSON valueForKey:@"_id"]);
    
    sharedProfile.email = [parseJSON valueForKey:@"email"];
    NSLog(@"email=%@",[parseJSON valueForKey:@"email"]);
    
    sharedProfile.password = [parseJSON valueForKey:@"password"];
    NSLog(@"password=%@",[parseJSON valueForKey:@"password"]);
    
    sharedProfile.user_name = [parseJSON valueForKey:@"name"];
    NSLog(@"name=%@",[parseJSON valueForKey:@"name"]);
    
    sharedProfile.phone = [parseJSON valueForKey:@"phone"];
    NSLog(@"phone _id=%@",[parseJSON valueForKey:@"phone"]);
    
    sharedProfile.dateofBirth = [parseJSON valueForKey:@"dob"];
    NSLog(@"dob=%@",[parseJSON valueForKey:@"dob"]);
    
   
    sharedProfile.gender = [parseJSON valueForKey:@"gender"];
    
    if (sharedProfile.gender !=nil)
    {
        NSString *genderString = [myTools male_female_to_localized_male_female :sharedProfile.gender];
        sharedProfile.gender = genderString;
        
        NSLog(@"gender=%@",[parseJSON valueForKey:@"gender"]);
        NSLog(@"gender(localized)=%@",genderString);
    }
   
   
    NSArray *pictures = [parseJSON valueForKey:@"pictures"];
    // NSDictionary *pictures = [parseJSON valueForKey:@"pictures"];
    if (pictures.count !=0 )
    {
        sharedProfile.picture_id = [pictures[0] valueForKey:PICTURE_ID];//]@"_id"];
        NSLog(@"pictures_id=%@",[pictures[0] valueForKey:@"_id"]);
        
        sharedProfile.picture_file = [pictures [0]valueForKey:PICTURE_FILE];//]@"file"];
        NSLog(@"pictures_file=%@", [pictures[0] valueForKey:@"file"]);
        
        ///---------------///
        //Now create URL to download image
        NSString *ulrStr = commonData.BASEURL_FOR_PICTURES;
        ulrStr = [ulrStr stringByAppendingString:sharedProfile.picture_file];
        
        NSLog(@"url of image=%@",ulrStr);
        
        NSURL *imageURLString = [NSURL URLWithString:ulrStr];
        
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageWithData:
                                                                           [NSData dataWithContentsOfURL:imageURLString]])];
        //Display it in the UIImage
        UIImage *image = [UIImage imageWithData:imageData];
        
        sharedProfile.user_image = image;
        
        // [self.imageView setImage:image];
        
        
        ///---------------///
    }
    
    sharedProfile.rating  = [ [parseJSON valueForKey:@"rating"] stringValue];
    NSLog(@"rating=%@", [ parseJSON valueForKey:@"rating"]);
    
    
    // NSArray *travel_preferences = [parseJSON valueForKey:@"travel_preferences"];
    NSDictionary *travel_preferences = [parseJSON valueForKey:@"travel_preferences"];
    
    sharedProfile.max_no_transfers  = [ [travel_preferences valueForKey:@"max_transfers"] stringValue];
    NSLog(@"max_transfers=%@", [travel_preferences valueForKey:@"max_transfers"]);
    
    sharedProfile.max_cost  = [ [travel_preferences valueForKey:@"max_cost"] stringValue];
    NSLog(@"max_cost=%@", [travel_preferences valueForKey:@"max_cost"]);
    
    sharedProfile.max_distance  = [ [travel_preferences valueForKey:@"max_walk_distance"] stringValue];
    NSLog(@"max_distance=%@", [travel_preferences valueForKey:@"max_walk_distance"]);
    
    sharedProfile.carpooler_age  =  [travel_preferences valueForKey:@"carpooler_preferred_age_group"]; //stringValue];
    NSLog(@"carpooler_age=%@", [travel_preferences valueForKey:@"carpooler_preferred_age_group"]);
    
    
//    sharedProfile.gender = [parseJSON valueForKey:@"gender"];
//    NSString *genderString = [myTools male_female_to_localized_male_female :sharedProfile.gender];
//    sharedProfile.gender = genderString;
//    
//    NSLog(@"gender=%@",[parseJSON valueForKey:@"gender"]);
//    NSLog(@"gender(localized)=%@",genderString);
    
    sharedProfile.carpooler_gender  = [travel_preferences valueForKey:@"carpooler_preferred_gender"];
    
    if (sharedProfile.carpooler_gender !=nil)
    {
        NSString *genderCarPoolerString = [myTools male_female_to_localized_male_female :sharedProfile.carpooler_gender];
        
        sharedProfile.carpooler_gender = genderCarPoolerString;
        
        NSLog(@"carpooler_gender=%@", [travel_preferences valueForKey:@"carpooler_preferred_gender"]);
        NSLog(@"carpooler_gender(localised)=%@", genderCarPoolerString);
    }
    
//    NSString *genderCarPoolerString = [myTools male_female_to_localized_male_female :sharedProfile.carpooler_gender];
//    sharedProfile.carpooler_gender = genderCarPoolerString;
//    
//    NSLog(@"carpooler_gender=%@", [travel_preferences valueForKey:@"carpooler_preferred_gender"]);
//    NSLog(@"carpooler_gender(localised)=%@", genderCarPoolerString);
    
    
    //Convert NSNumber value to BOOL and then String
    sharedProfile.gps_tracking =  [[travel_preferences valueForKey:@"gps_tracking"]  boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No") ;
    
    NSLog(@"sharedProfile.gps_tracking(localized) =%@",sharedProfile.gps_tracking );
    
    sharedProfile.luggage =  [[travel_preferences valueForKey:@"luggage"]  boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No");
    NSLog(@"sharedProfile.luggage (localized) =%@",sharedProfile.luggage );
    
    sharedProfile.pets =  [[travel_preferences valueForKey:@"pets"]  boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No") ;
    NSLog(@"sharedProfile.pets (localized)=%@",sharedProfile.pets );
    
    sharedProfile.smoking =  [[travel_preferences valueForKey:@"smoking"]  boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No") ;
    NSLog(@"sharedProfile.smoking (localized)=%@",sharedProfile.smoking );
    
    sharedProfile.food =  [[travel_preferences valueForKey:@"food"]  boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No") ;
    NSLog(@"sharedProfile.food (localized)=%@",sharedProfile.food );
    
    sharedProfile.music =  [[travel_preferences valueForKey:@"music"]  boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No");
    NSLog(@"sharedProfile.music (localized)=%@",sharedProfile.music );
    //End of converting NSNumber value to BOOL and then String
    
    
    //Compare NSMutuableArray with CommonData
    //and store "Yes" or "No" value respectively
    //          commonData = [[CommonData alloc]init];
    //          [commonData initWithValues];
    
//    NSString *yes = NSLocalizedString(@"Yes", @"Yes");
//    NSString *no = NSLocalizedString(@"No", @"No");
    
    NSString *yes = @"Yes";
    NSString *no =  @"No";
    
    //Copy NSArray values to NSMutableArray
    //tableOptimiseTravelSolutions
    NSArray *optimisationArray = [travel_preferences valueForKey:@"optimisation"];
    
    //Initialise NSMutableArray with "No" values
    //if (sharedProfile.tableOptimiseTravelSolutions == nil)
    sharedProfile.tableOptimiseTravelSolutions = [NSMutableArray arrayWithObjects:no,no,no,no,no, nil];
    
    for (int j=0;j<commonData.tableOptimiseTravelSolutions.count;j++)
    {
        for (int i=0;i<optimisationArray.count;i++)
        {
            if ( [ NSLocalizedString (optimisationArray[i],optimisationArray[i]) isEqualToString:commonData.tableOptimiseTravelSolutions[j]])
            {
                [sharedProfile.tableOptimiseTravelSolutions replaceObjectAtIndex:j withObject:yes];
                
                break;
            }
        }
    }
    
    
    //Copy NSArray values to NSMutableArray
    //tableOptimiseTravelSolutions
    NSArray *tableTravelModesValues = [travel_preferences valueForKey:@"preferred_transport"];
    
    //Initialise NSMutableArray with "No" values
    // if (sharedProfile.tableTravelModesValues == nil)
    sharedProfile.tableTravelModesValues = [NSMutableArray arrayWithObjects:no,no,no,no,no,no, nil];
    
    for (int j=0;j<commonData.tableTravelModes.count;j++)
    {
        for (int i=0;i<tableTravelModesValues.count;i++)
        {
            if ( [ NSLocalizedString (tableTravelModesValues[i],tableTravelModesValues[i])  isEqualToString:commonData.tableTravelModes[j]])
            {
                [sharedProfile.tableTravelModesValues replaceObjectAtIndex:j withObject:yes ];
                
                break;
            }
        }
    }
    
    //Copy NSArray values to NSMutableArray
    //tableOptimiseTravelSolutions
    NSArray *tableSpecialNeeds = [travel_preferences valueForKey:@"special_request"];
    
    //Initialise NSMutableArray with "No" values
    //if (sharedProfile.tableSpecialNeeds == nil)
    sharedProfile.tableSpecialNeeds = [NSMutableArray arrayWithObjects:no,no,no,no, nil];
    
    
    for (int j=0;j<commonData.tableSpecialNeeds.count;j++)
    {
        for (int i=0;i<tableSpecialNeeds.count;i++)
        {
            if ( [NSLocalizedString(tableSpecialNeeds[i],tableSpecialNeeds[i]) isEqualToString:commonData.tableSpecialNeeds[j]])
            {
                [sharedProfile.tableSpecialNeeds replaceObjectAtIndex:j withObject:yes];
                break;
            }
        }
    }
    
    
    //Filters
    sharedProfile.tableFilters = [NSMutableArray arrayWithObjects: yes,yes,yes,yes,yes,yes,yes, nil];
    
    //Assign values of TRAVEL_MODES manually
    if ([sharedProfile.tableTravelModesValues[0] isEqualToString:no]) //BUS
    {
        sharedProfile.tableFilters[0] = no;
    }
    
    if ([sharedProfile.tableTravelModesValues[1] isEqualToString:no]) //CAR_POOLLING
    {
        sharedProfile.tableFilters[1] = no;
    }
    
    if ([sharedProfile.tableTravelModesValues[3] isEqualToString:no]) //METRO
    {
        sharedProfile.tableFilters[2] = no;
    }
    
    if ([sharedProfile.tableTravelModesValues[4] isEqualToString:no]) //RAIL
    {
        sharedProfile.tableFilters[3] = no;
    }
    
    if ([sharedProfile.tableTravelModesValues[5] isEqualToString:no]) //TRAM
    {
        sharedProfile.tableFilters[4] = no;
    }
    
    //Assign values of OPTIMISATION manually
    if ([sharedProfile.tableOptimiseTravelSolutions[0] isEqualToString:no]) //CHEAPEST
    {
        sharedProfile.tableFilters[5] = no;
    }
    if ([sharedProfile.tableOptimiseTravelSolutions[2] isEqualToString:no]) //FASTEST
    {
        sharedProfile.tableFilters[6] = no;
    }



   
}


#pragma mark - Retrieve Rides (as driver)
-(void) retrieveRides
{
    case_call_API = 7;
    
    //1. Create URL
    NSString *ulrStr = commonData.BASEURL_RETRIEVE_RIDES;
    
    ulrStr = [ulrStr stringByAppendingString:sharedProfile.userID];
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    
    NSLog(@"urlWithString=%@",urlWithString);
    //2. Create and send Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //3. Set HTTP Headers and HTTP Method
    [urlRequest setValue:authValue forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    
    //4. Set HTTP Method
    [urlRequest setHTTPMethod:@"GET"];
    
    //5. Send Request to Server
    //?        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest];
    //?        [dataTask resume];
    //create the task
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                      NSLog(@"ParseJson[retrieveRides]=%@", json);
                                      
                                      [self fill_rides:json];
                                      
                                  }];
    [task resume];
    
}

-(void) fill_rides: (NSDictionary *)parseJSON
{
    NSLog(@"******* RETRIEVE RIDES *************");
    
    NSArray *getRides = [parseJSON objectForKey:@"rides"];
    
    sharedRoutesAsDriver.rides = [[NSMutableArray alloc]init];
    
    for (int i=0;i< getRides.count;i++)
    {
        Ride *ride = [[Ride alloc]init];
        
        ride._id = [getRides[i] objectForKey:ID_];
        
        //Start point
        NSDictionary *start_point = [getRides[i] objectForKey:@"start_point"];
        ride.start_point_lat = [start_point objectForKey:@"lat"];
        ride.start_point_lon = [start_point objectForKey:@"lon"];
        
        ride.ride_date = [getRides[i] objectForKey:@"date"];
        //End point
        NSDictionary *end_point = [getRides[i] objectForKey:@"end_point"];
        ride.end_point_lat = [end_point objectForKey:@"lat"];
        ride.end_point_lon = [end_point objectForKey:@"lon"];
        
        ride.name = [getRides[i] objectForKey:@"name"];
        ride.polyline = [getRides[i] objectForKey:@"polyline"];
        
        NSString *valueStr = [[getRides[i] objectForKey:@"activated"] stringValue];
       
        ride.activated = valueStr;//[getRides[i] objectForKey:@"activated"];
        
        ride.car_id = [ getRides[i] objectForKey:CAR_ID_];
        ride.driver_id = [ getRides[i] objectForKey:DRIVER_ID];
        
        //Now check whether lifts exist
        NSArray *getLifts = [getRides[i] objectForKey:@"lifts"];
        
        NSMutableArray *lifts = [[NSMutableArray alloc] init];
        
        for (int i=0;i<getLifts.count;i++)
        {
            lift = [[Lift alloc]init];
            
            lift._id = [getLifts[i] objectForKey:@"_id"];
            lift.passenger_id = [getLifts[i] objectForKey:@"passenger_id"];
            lift.car_id = [getLifts[i] objectForKey:@"car_id"];
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
            lift.passenger_image = [getLifts[i] objectForKey:@"passenger_img"];
            
           // [sharedRoutesAsDriver.lifts addObject:lift];
            [lifts addObject:lift];

        }
        ride.lifts = lifts;
        
        [sharedRoutesAsDriver.rides addObject:ride];
        
    }
    
    NSLog(@"******* END OF RETRIEVE RIDES *************");
    
    //Now go to next screen
    //Update GUI with safe-thread
    dispatch_async(dispatch_get_main_queue(), ^{
        
       [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
        [indicatorView stopAnimating];
        
        MenuTabBarController *menuTabBarController = (MenuTabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"menuTabStoryboard"];
        
        self.view.window.rootViewController = menuTabBarController;
        [self.view.window makeKeyAndVisible];
        
    });
}

#pragma mark - update user's fcm token
-(void) updateUserFcmToken
{
    NSString *ulrStr = commonData.BASEURL;
    ulrStr = [ulrStr stringByAppendingString:commonData.URL_users];
    ulrStr = [ulrStr stringByAppendingString:sharedProfile.userID];
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    NSLog(@"urlWitString=%@",urlWithString);
    
    //2. Create and send Request
    NSURLCredential *credentials = [NSURLCredential credentialWithUser:self.txtfield_email.text                                                             password:self.txtfield_password.text persistence:NSURLCredentialPersistenceNone];
    
    authStr = [credentials user];
    authStr = [authStr stringByAppendingString:@":"];
    authStr  = [authStr stringByAppendingString:[credentials password] ];
    
    authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];

    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    
    //3. Set HTTP Headers and HTTP Method
    [urlRequest setValue:authValue forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //4. Set HTTP Method
    [urlRequest setHTTPMethod:HTTP_METHOD_PATCH];
    
    //Is any case to be nil?
    if (sharedProfile.fcm_token == nil)//case when it runs on emulator
    {
        sharedProfile.fcm_token = FCM_TOKEN_IOS_EMULATOR;//FCM_TOKEN_NOT_INITIALISED;
    }

    NSDictionary *dictionary = @{
                                 FCM_TOKEN_ :  sharedProfile.fcm_token,
                                 @"platform": @"IOS"
                                 };
    
    NSString *strRes = [myTools dictionaryToJSONString:dictionary];
    NSLog(@"strRes=%@",strRes);
    
    
    [urlRequest setHTTPBody:[strRes dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //5. Send Request to Server
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      //                                      indicatorView = [myTools setActivityIndicator:self];
                                      //                                      [indicatorView startAnimating];
                                      
                                      NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                      
                                      NSLog(@"ParseJson =%@", parseJSON);

                                  
                                  }];
    
    
        [task resume];
    

}

#pragma mark - alertCustom
-(void) alertCustom
{
    NSString *ok = NSLocalizedString(@"OK", @"OK");
    //  NSString *message_title = NSLocalizedString(@"Credentials", @"Credentials");
    NSString *error_message = NSLocalizedString(@"Credentials required!", @"Credentials required!");
    
    UIAlertController *alertAuthenticationError = [UIAlertController
                                                   alertControllerWithTitle:error_message
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

#pragma mark - NSURLSessionDataDelegate methods
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    NSLog(@"### handler ");
 
    if (case_call_API == 5)
    {
        receivedData = [[NSMutableData alloc] init];
    }
    
    completionHandler(NSURLSessionResponseAllow);
}



- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    
    NSError *jsonError;
   
    //NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
  
   
 //   NSDictionary  *parseJSON = [NSJSONSerialization  JSONObjectWithData:data options:0 error:&jsonError];
  //  NSDictionary  *parseJSON = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
    
//   NSDictionary  *parseJSON = [NSJSONSerialization  JSONObjectWithData:data options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers|NSJSONWritingPrettyPrinted|NSJSONReadingMutableLeaves error:&jsonError];
    NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:&jsonError];
    NSLog(@"parseJSON = %@", parseJSON);

    
    
    if ( [parseJSON objectForKey:@"_error"])
    {
        NSString *str = [parseJSON objectForKey:@"_issues"];
        NSString *strFormatted = [NSString stringWithFormat: @"%@",str];
        
        NSLog(@"_issues(strFormatted)=%@",strFormatted);
        
        sharedProfile.userID = @""; //set to none
        
        NSDictionary *errorDict = [parseJSON valueForKey:@"_error"];
        //NSArray *userIDArray = [ns valueForKey:@"message"];
        NSString *error_message = [errorDict valueForKey:@"message"];
        
        NSLog(@"error_message=%@",error_message);
        
        NSString *message_title = NSLocalizedString(@"Authentication error", @"Authentication error");
        NSString *ok = NSLocalizedString(@"OK", @"OK");
        
        [self.btn_signUp setEnabled:YES];
        [self.btn_signIn setEnabled:YES];
        
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
            NSLog(@"Authentication ok!");
           
            // store credentials to NSUserDefaults - Not secure way
            /*NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            
            [prefs setObject:self.txtfield_email.text forKey:@"userName"];
            [prefs setObject:self.txtfield_password.text forKey:@"password"];
            
            [prefs synchronize];
            */
            
            // store credentials with KeychainItemWrapper
            
            KeychainItemWrapper *keychain =
            [[KeychainItemWrapper alloc] initWithIdentifier:@"RideMyRouteLoginData" accessGroup:nil];
            [keychain setObject:self.txtfield_email.text  forKey:(id)kSecAttrAccount];
            //[keychain setObject:self.txtfield_password.text forKey:(id)kSecValueData];
            
            NSData *pwdData = [self.txtfield_password.text dataUsingEncoding:NSUTF8StringEncoding];
            
            //store it as NSData to keychain item for password
            [keychain setObject:pwdData forKey:(id)kSecValueData];
            
                       
            [self findUser];
           
        }
        else if (case_call_API == 2)
        {
            //Now get the Array
            NSArray *ns = [parseJSON valueForKey:@"users"];
            NSLog(@"ns.count=%lu",ns.count);
            
            //Retrieve userID and fcm_token
            sharedProfile.userID = [ns[0] valueForKey:@"_id"];
            NSLog(@"_id=%@",[ns[0] valueForKey:@"_id"]);
            //Do not assign fcm_token; it is getting from AppDelegte.m when registered for push notification
        //?    sharedProfile.fcm_token = [ns[0] valueForKey:@"fcm_token"];
        //?    NSLog(@"fcm_token=%@",[ns[0] valueForKey:@"fcm_token"]);
            
            //Check if user has car
            NSArray *cars = [ns[0] valueForKey:@"cars"];
           
            if (cars.count!=0)
            {
                sharedProfile.hasCar = YES;
                sharedProfile.cars_ids  = [[NSMutableArray alloc]initWithCapacity:cars.count];
                
                for (int i=0;i<cars.count;i++)
                {
                   // sharedProfile.cars  = [NSMutableArray arrayWithObjects:cars[,no,no,no,no, nil];
                    [sharedProfile.cars_ids
                     addObject:cars[i]];
                }
                
                 sharedDriverProfile.car_id = [sharedProfile.cars_ids lastObject]; //Get the last object
            }
           
            if   (![sharedProfile.userID isEqualToString:@""] )
            {
                [self retrieveUser];
            }
        }
        else if (case_call_API == 3) //RETRIEVE USER
        {
            //Now get the Array
           // NSArray *ns = [parseJSON valueForKey:@"users"];
            //NSLog(@"ns.count=%lu",ns.count);
            
           // for (int i=0;i<ns.count;i++)
           //{
            //Check if user has car
            [self fill_userProfile:parseJSON];
 
            //If user has a car!
            if (sharedProfile.hasCar)
            {
               [self retrieveCar];
            }
            else
            {
                //call retrieve Lifts
                [self retrieveLiftsPassenger];
            }
            [self updateUserFcmToken];
 
        }
        else if (case_call_API == 4)
        {
            NSLog(@"******* RETRIEVE CAR *************");
            //Get the car id of created car
            sharedDriverProfile.car_id = [parseJSON valueForKey:ID_];
            NSLog(@"ID of car = %@",sharedDriverProfile.car_id);
            
            sharedDriverProfile.model = [parseJSON valueForKey:MODEL_];
            
            sharedDriverProfile.plate = [parseJSON valueForKey:PLATE_];
            
            sharedDriverProfile.colour = [parseJSON valueForKey:COLOUR_];
            
            //DO NOT GET THE COLOUR of the text. You will get it from DriverProfileViewController
          /*  NSString *colourTextRetrieved = [parseJSON valueForKey:COLOUR_];
            
            
            for (int i=0;i<arrayChoices.count;i++)
            {
                //if [colourTextRetrieved
                if ([colourTextRetrieved isEqualToString:arrayChoices[i]])
                {
                    
                    sharedDriverProfile.colour_text = colourCustomArray[i];
                    
                    break;
                }
            }
            self.txtfield_colour.textColor = sharedDriverProfile.colour_text;
            */
            
            sharedDriverProfile.seats = [ [parseJSON valueForKey:SEATS_]stringValue];
            
            //get car_usage_preferences
            NSDictionary *car_usage_preferences = [parseJSON valueForKey:CAR_USAGE_PREFERENCES];
            
            sharedDriverProfile.luggage = [car_usage_preferences valueForKey:LUGGAGE_TYPE];
            
            NSDictionary *foodAllowed= [car_usage_preferences valueForKey:FOOD_ALLOWED];
            NSString *foodAllowedStr = [NSString stringWithFormat:@"%@",foodAllowed];
            sharedDriverProfile.food = [foodAllowedStr boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No");
            
            NSDictionary *smokingAllowed= [car_usage_preferences valueForKey:SMOKING_ALLOWED];
            NSString *smokingAllowedStr = [NSString stringWithFormat:@"%@",smokingAllowed];
            sharedDriverProfile.smoking = [smokingAllowedStr boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No");
            
            NSDictionary *aircondition= [car_usage_preferences valueForKey:AIR_CONDITIONING];
            NSString *airconditionStr = [NSString stringWithFormat:@"%@",aircondition];
            sharedDriverProfile.air_conditioning = [airconditionStr boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No");
            
            NSDictionary *petsAllowed= [car_usage_preferences valueForKey:PETS_ALLOWED];
            NSString *petsStr = [NSString stringWithFormat:@"%@",petsAllowed];
            sharedDriverProfile.pets = [petsStr boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No") ;
            
            NSDictionary *childSeat= [car_usage_preferences valueForKey:CHILD_SEAT];
            NSString *childSeatStr = [NSString stringWithFormat:@"%@",childSeat];
            sharedDriverProfile.child_seat = [childSeatStr boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No") ;
            
            NSDictionary *musicAllowed= [car_usage_preferences valueForKey:MUSIC_ALLOWED];
            NSString *musicAllowedStr = [NSString stringWithFormat:@"%@",musicAllowed];
            sharedDriverProfile.music = [musicAllowedStr boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No") ;
            
            
            //Get picture if exists
            NSArray *pictures = [parseJSON valueForKey:PICTURES_];
            // NSDictionary *pictures = [parseJSON valueForKey:@"pictures"];
            if (pictures.count !=0 )
            {
                sharedDriverProfile.car_picture_id = [pictures[0] valueForKey:PICTURE_ID];
                NSLog(@"pictures_id=%@",[pictures[0] valueForKey:@"_id"]);
                
                sharedDriverProfile.car_picture_file = [pictures [0]valueForKey:PICTURE_FILE];
                NSLog(@"pictures_file=%@", [pictures[0] valueForKey:@"file"]);
                
                ///---------------///
                //Now create URL to download image (URL: BASEURL_FOR_PICTURES/car_picture_file)
                NSString *ulrStr = commonData.BASEURL_FOR_PICTURES;
                ulrStr = [ulrStr stringByAppendingString:sharedDriverProfile.car_picture_file];
                
                NSLog(@"url of image=%@",ulrStr);
                
                NSURL *imageURLString = [NSURL URLWithString:ulrStr];
                
                NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageWithData:
                                                                                   [NSData dataWithContentsOfURL:imageURLString]])];
                //Display it in the UIImage
                UIImage *image = [UIImage imageWithData:imageData];
                
                sharedDriverProfile.car_image = image;
            }
            NSLog(@"******* END OF RETRIEVE CAR *************");
            //call retrieve Lifts
            
//            MenuTabBarController *menuTabBarController = (MenuTabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"menuTabStoryboard2"];
//            
//            
//            self.view.window.rootViewController = menuTabBarController;
//            [self.view.window makeKeyAndVisible];
            
            [self retrieveLiftsPassenger];
        }
       
 
    }
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    [indicatorView stopAnimating];
    
    if (error == nil)
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



#pragma mark - UITextFields delegate
//hide the keyboard when you press the return or done button of the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    /// [textField resignFirstResponder];
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
   // UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
     UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    
    if (nextResponder)
    {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    }
    else
    {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    
    return NO;
}


@end
