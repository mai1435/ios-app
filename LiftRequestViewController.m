//
//  LiftRequestViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH)  on 29/09/17.
//  Copyright © 2017 CERTH. All rights reserved.
//

#import "LiftRequestViewController.h"

@interface LiftRequestViewController () <SFSafariViewControllerDelegate>

@end

@implementation LiftRequestViewController
//
//-(void) viewWillAppear:(BOOL)animated
- (void)viewDidLoad
{
//    [super viewWillAppear:animated];
    [super viewDidLoad];
    
    commonData = [[CommonData alloc]init];
    [commonData initWithValues];
    
    myTools = [[MyTools alloc]init];
    
    sharedProfile = [SharedProfileData sharedObject];
    sharedLiftNotified = [SharedLiftNotified sharedLiftNotifiedObject];
    sharedRoutesAsPassenger = [SharedRoutesAsPassenger sharedRoutesAsPassengerObject];
    
    sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];

    parseObjects = [[ParseObjects alloc]init];
    [parseObjects initWithValues];
    
////****** Data coming from notification ****
    //These lines are just to test the lift coming from push notification
    //For test purposes - remove two line below
    
    
    //?sharedLiftNotified.notified_by_driver = YES;
    //REMOVE the above  lines
///////////**********************************************
    
    //Check to see if it driver or passenegre
    if (sharedLiftNotified.notified_by_driver)
    {
        [self setTitle:@"Driver details"];
        [self retrieveDriverOrPassenger:sharedLiftNotified.notified_lift.driver_id];
    }
    else
    {
        [self setTitle:@"Passenger details"];
        [self retrieveDriverOrPassenger:sharedLiftNotified.notified_lift.passenger_id];
    }
    
    self.btn_social_media.layer.borderWidth = 0.4;
    self.btn_social_media.layer.borderColor = UIColor.blackColor.CGColor;
    
    
    self.btn_phone.layer.borderWidth = 0.4;
    self.btn_phone.layer.borderColor = UIColor.blackColor.CGColor;
    
    self.btn_message.layer.borderWidth = 0.4;
    self.btn_message.layer.borderColor = UIColor.blackColor.CGColor;

    
    
}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
//}

#pragma mark - Retrieve user - for driver
- (void)retrieveDriverOrPassenger : (NSString *) user
{
    //1. Create URL
    NSString *ulrStr = commonData.BASEURL;
    
    ulrStr = [ulrStr stringByAppendingString:commonData.URL_users];
    ulrStr = [ulrStr stringByAppendingString:user];
    
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
                                      
                                      [self fill_user:parseJSON];
                                      
                                  }];
    
    [task resume];
    
    //8. Start UIActivityIndicatorView for GUI purposes
    indicatorView = [myTools setActivityIndicator:self];
    [indicatorView startAnimating];
    
}


-(void)fill_user:(NSDictionary *)parseJSON
{
    if (sharedLiftNotified.notified_by_driver)
    {
        sharedLiftNotified.notified_lift.driver_name = [parseJSON valueForKey:@"name"];
        sharedLiftNotified.notified_lift.driver_rating  = [ [parseJSON valueForKey:@"rating"] stringValue];
        sharedLiftNotified.notified_lift.driver_phone =  [parseJSON valueForKey:@"phone"];
    }
    else
    {
        sharedLiftNotified.notified_lift.passenger_name = [parseJSON valueForKey:@"name"];
        sharedLiftNotified.notified_lift.passenger_rating  = [ [parseJSON valueForKey:@"rating"] stringValue];
        sharedLiftNotified.notified_lift.passenger_phone =  [parseJSON valueForKey:@"phone"];
    }
    
    NSDictionary *social_provider = [parseJSON valueForKey:@"social_provider"];
    
    NSString *social_network = [social_provider valueForKey:@"social_network"];
    if ([social_network isEqualToString:SOCIAL_NETWORK_FACEBOOK])
    {
        if (sharedLiftNotified.notified_by_driver)
        {
            sharedLiftNotified.notified_lift.driver_hasFacebookAccount = YES;
            sharedLiftNotified.notified_lift.driver_social_media_id = [social_provider valueForKey:@"social_id"];
        }
        else
        {
            sharedLiftNotified.notified_lift.passenger_hasFacebookAccount = YES;
            sharedLiftNotified.notified_lift.passenger_social_media_id = [social_provider valueForKey:@"social_id"];
        }
        
        UIImage *facebookImage = [UIImage imageNamed:@"facebook"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.btn_social_media setImage:facebookImage forState:UIControlStateNormal];
           //  self.btn_social_media.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 50);
            
        });
    }
    else if ([social_network isEqualToString:SOCIAL_NETWORK_GOOGLE])
    {
        if (sharedLiftNotified.notified_by_driver)
        {
            sharedLiftNotified.notified_lift.driver_hasGoogleAccount = YES;
            sharedLiftNotified.notified_lift.driver_social_media_id = [social_provider valueForKey:@"social_id"];
        }
        else
        {
            sharedLiftNotified.notified_lift.passenger_hasGoogleAccount = YES;
            sharedLiftNotified.notified_lift.passenger_social_media_id = [social_provider valueForKey:@"social_id"];
        }
        
        UIImage *googleImage = [UIImage imageNamed:@"ic_google"];//google_plus"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
          //self.btn_social_media.imageEdgeInsets = UIEdgeInsetsMake(50, 50, 50, 50);
            
            [self.btn_social_media setImage:googleImage forState:UIControlStateNormal];
            
        });
    }
//SOCIAL_NETWORK_GOOGLE
    
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
        
        if (sharedLiftNotified.notified_by_driver)
        {
            sharedLiftNotified.notified_lift.driver_picture = image;
        }
        else
        {
            sharedLiftNotified.notified_lift.passenger_picture = image;
        }
        
    }
    else
    {
        if (sharedLiftNotified.notified_by_driver)
        {
            sharedLiftNotified.notified_lift.driver_picture = [UIImage imageNamed:@"account-circle-grey"];
        }
        else
        {
            sharedLiftNotified.notified_lift.passenger_picture = [UIImage imageNamed:@"account-circle-grey"];
        }
    }
    
    if (sharedLiftNotified.notified_by_driver)
    {
        [self retrieveFeedback:sharedLiftNotified.notified_lift.driver_id];
    }
    else
    {
        [self retrieveFeedback:sharedLiftNotified.notified_lift.passenger_id];
    }
    
}

#pragma mark - Retrieve Feedbacks for selected driver
-(void) retrieveFeedback:(NSString *)user_id
{
    
    //1. Create URL
    NSString *ulrStr = commonData.BASEURL_FOR_FEEDBACKS;
    
    ulrStr = [ulrStr stringByAppendingString:user_id];
    
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
                                      
                                      NSLog(@"ParseJson[retrieveFeedback] =%@", json);
                                      
                                      
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
        
        NSArray *getfeedbackData = [parseJSON objectForKey:@"feedbacks"];
        
        if (sharedLiftNotified.notified_by_driver)
        {
            sharedRoutesAsDriver.feedbackArray = [[NSMutableArray alloc]init];
        }
        else
        {
            sharedRoutesAsPassenger.feedbackArray = [[NSMutableArray alloc]init];
        }
        
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
                [sharedRoutesAsDriver.feedbackArray addObject:feedbackData];
            }
            else
            {
                [sharedRoutesAsPassenger.feedbackArray addObject:feedbackData];
            }
        }
        //if (sharedLiftNotified.notified_by_driver)
        //Now update GUI
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.label_feedback.text  = @" (";
            NSString *feedbackCounter;
            
            if (sharedLiftNotified.notified_by_driver)
            {
                feedbackCounter= [NSString stringWithFormat:@"%lu",(unsigned long)sharedRoutesAsDriver.feedbackArray.count];
            }
            else
            {
                feedbackCounter= [NSString stringWithFormat:@"%lu",(unsigned long)sharedRoutesAsPassenger.feedbackArray.count];
            }
            
            self.label_feedback.text  = [self.label_feedback.text  stringByAppendingString:feedbackCounter];
            
            int feedbackCounterInt = [feedbackCounter intValue];
            
            if (feedbackCounterInt >1)
            {
                self.label_feedback.text  = [ self.label_feedback.text  stringByAppendingString:@" feedbacks)"];
            }
            else
            {
                self.label_feedback.text  = [ self.label_feedback.text  stringByAppendingString:@" feedback)"];
            }
            //End of creating "X (cnt feedback)"
            
            self.label_origin.text = sharedLiftNotified.notified_lift.start_address;
            
            self.label_destiantion.text = sharedLiftNotified.notified_lift.end_address;
            
            self.label_date_time.text = [myTools convertTimeStampToStringWithDateAndTime:sharedLiftNotified.notified_lift.start_address_date];
            
            if (sharedLiftNotified.notified_by_driver)
            {
                if (sharedLiftNotified.notified_lift.driver_picture)
                {
                    self.image_driver.image = sharedLiftNotified.notified_lift.driver_picture;
                
                    CGSize size = CGSizeMake(80, 80);
                    self.image_driver.image= [self imageWithImage:self.image_driver.image convertToSize:size];
                
                    [self setStyleForImageCirle:self.image_driver];
                }
            
                self.label_driver_name.text = sharedLiftNotified.notified_lift.driver_name;
            }
            else
            {
                if (sharedLiftNotified.notified_lift.passenger_picture)
                {
                    self.image_driver.image = sharedLiftNotified.notified_lift.passenger_picture;
                    
                    CGSize size = CGSizeMake(80, 80);
                    self.image_driver.image= [self imageWithImage:self.image_driver.image convertToSize:size];
                    
                    [self setStyleForImageCirle:self.image_driver];
                }
                
                self.label_driver_name.text = sharedLiftNotified.notified_lift.passenger_name;
            }
            
            [self retrieve_lift];
            
        });
        
        
    }
    
    
}


#pragma mark - Styling picture as as circle
-(void) setStyleForImageCirle: (UIImageView *) imageView
{
    self.image_driver.backgroundColor = [UIColor clearColor];
    
    self.image_driver.layer.cornerRadius = self.image_driver.frame.size.width /2;
    
    //Core Animation creates an implicit clipping mask that matches the bounds of the layer and includes any corner radius effects
    self.image_driver.layer.masksToBounds =  YES;
    
    //self.image_photo.clipsToBounds = YES;
    
    //[self.image_photo.layer setBorderColor:[[UIColor colorWithPatternImage:[UIImage imageNamed:@"img_circle_dots"]] CGColor]];
    //self.image_photo.layer.borderWidth = 0.5f;
    
}

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

#pragma mark buttons pressed
- (IBAction)btn_accept_pressed:(id)sender
{
    
    sharedLiftNotified.notified_lift.status = ACTIVE;
    [self updateLift:ACTIVE];
}

- (IBAction)btn_decline_pressed:(id)sender
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
                                    
                                    
                                    sharedLiftNotified.notified_lift.status = CANCELLED;
                                    
                                    [self updateLift:CANCELLED];
                                    
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                    
                                }];
    
    [alertCancelRequest addAction:noAction];
    [alertCancelRequest addAction:yesAction];
    [self presentViewController:alertCancelRequest animated:NO completion:nil];

}

#pragma mark - Buttons for calling schemes - open applications
//Change later the id from  fb:<profile>/<id>
- (IBAction)btn_facebook_pressed:(id)sender
{
    
    NSLog(@"Facebook buttonpressed");
    //see URL schemes: http://stackoverflow.com/questions/5707722/what-are-all-the-custom-url-schemes-supported-by-the-facebook-iphone-app
    dispatch_async(dispatch_get_main_queue(), ^{
  
    
        if (sharedLiftNotified.notified_lift.passenger_hasFacebookAccount)
        {
            // NSString *ulr_facebook= @"fb://profile/"; //Directs to your profile
            NSString *ulr_facebook= @"*";
            NSString *passenger_facebook_id = sharedLiftNotified.notified_lift.passenger_social_media_id;
            
            if (passenger_facebook_id != nil)
            {
                ulr_facebook = [ulr_facebook stringByAppendingString:passenger_facebook_id];
            }
            
            // Check if FB app installed on device
            // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://profile/355356557838717"] options:@{} completionHandler:^(BOOL success)
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ulr_facebook] options:@{}completionHandler:^(BOOL success)
             {
                 if (!success)
                 {
                     /////Not recommended by Apple' review process.
                     //Use SFSafariViewController instead.
                     
                     /* [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"*"] options:@{} completionHandler:nil];*/
                     [self displayFacebookInBrowser];
                 }
             }];
        }
        else if (sharedLiftNotified.notified_lift.passenger_hasGoogleAccount)
        {
            //OR if GOOGLE_PLUS account exist
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"*"] options:@{} completionHandler:^(BOOL success)
             {
                 if (!success)
                 {
                     /////Not recommended by Apple' review process.
                     //Use SFSafariViewController instead.
                     
                     [self displayGooglePlusInBrowser];
                     
                 }
             }];
        
        }
    });
    
}

- (void)displayGooglePlusInBrowser
{
    SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"*"] entersReaderIfAvailable:NO];
    safariVC.delegate = self;
    [self presentViewController:safariVC animated:NO completion:nil];
}

- (void)displayFacebookInBrowser
{
    SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"*"] entersReaderIfAvailable:NO];
    safariVC.delegate = self;
    [self presentViewController:safariVC animated:NO completion:nil];
}

//Change later the phone number 123456
- (IBAction)btn_phone_pressed:(id)sender
{
    
    NSLog(@"Phone btn prsssed!");
    //NSString *URLString = @"tel://*"; //
    NSString *URLString = [@"tel://" stringByAppendingString:sharedLiftNotified.notified_lift.passenger_phone]; //[@"tel://"stringByAppendingString:textfield.text];
    
    NSURL *URL = [NSURL URLWithString:URLString];
    
    [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
   
}

//Cahnge later the phone number 30123456
- (IBAction)btn_message_pressed:(id)sender {
    
    NSLog(@"btn_message pressed");
    //  NSString *stringURL = @"sms:+30123456";
    NSString *stringURL = [@"sms:" stringByAppendingString:sharedLiftNotified.notified_lift.passenger_phone];
    
    NSURL *url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
   
}




#pragma mark - Retrieve lift
-(void) retrieve_lift
{
    //1. Create URL
    NSString *ulrStr = commonData.BASEURL;
    
    ulrStr = [ulrStr stringByAppendingString:@"lifts/"];
    
    
    ulrStr = [ulrStr stringByAppendingString:sharedLiftNotified.notified_lift._id];
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    
    NSLog(@"urlWithString=%@",urlWithString);
    //2. Create and send Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //3. Set HTTP Headers and HTTP Method
    [urlRequest setValue:sharedProfile.authCredentials forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //4. Set HTTP Method
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                      
                                      NSLog(@"ParseJson[createRides] =%@", parseJSON);
                                      
                                      [self fill_lift:parseJSON];
                                      
                                  }];
    [task resume];
}


-(void) fill_lift : (NSDictionary *)parseJSON
{
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
        
        //Fill the rest items from the dat_payload (?) parseJSON to lift object
        
        sharedLiftNotified.notified_lift._id = [parseJSON valueForKey:@"_id"];
        sharedLiftNotified.notified_lift.car_id = [parseJSON valueForKey:@"car_id"];
        sharedLiftNotified.notified_lift.driver_id = [parseJSON valueForKey:@"driver_id"];
        
        sharedLiftNotified.notified_lift.ride_id = [parseJSON valueForKey:@"ride_id"];
        sharedLiftNotified.notified_lift.passenger_id = [parseJSON valueForKey:@"passenger_id"];
        sharedLiftNotified.notified_lift.status = [parseJSON valueForKey:@"status"];
        
        NSDictionary *start_point = [parseJSON objectForKey:@"start_point"];
        sharedLiftNotified.notified_lift.start_address = [start_point valueForKey:@"address"];
        
        NSDictionary *end_point = [parseJSON objectForKey:@"end_point"];
        sharedLiftNotified.notified_lift.end_address = [end_point valueForKey:@"address"];
        
       // sharedLiftNotified.notified_lift = lift;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.label_origin.text = sharedLiftNotified.notified_lift.start_address;
            
            self.label_destiantion.text = sharedLiftNotified.notified_lift.end_address;
            
            self.label_date_time.text = [myTools convertTimeStampToStringWithDateAndTime:sharedLiftNotified.notified_lift.start_address_date];
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
            [indicatorView stopAnimating];
            
        });

    }
}


#pragma mark - Update Lift
- (void)updateLift:(NSString *) liftStatus
{
    //case_call_API = 2;
    //1. Create URL
    NSString *ulrStr = commonData.BASEURL_UDATE_LIFTS;
    ulrStr = [ulrStr stringByAppendingString:sharedLiftNotified.notified_lift._id];
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    NSLog(@"urlWitString=%@",urlWithString);
    
//    NSURLCredential *credentials = [NSURLCredential credentialWithUser:sharedProfile.email password:sharedProfile.password persistence:NSURLCredentialPersistenceNone];
//    
//    NSString *authStr = [credentials user];
//    authStr = [authStr stringByAppendingString:@":"];
//    authStr  = [authStr stringByAppendingString:[credentials password] ];
//    
//    //2.1 Create string authValue for sessionConfiguration (3) => "Basic xxxxxxxxx"
//    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    
    //3. Set HTTP Headers and HTTP Method
    [urlRequest setValue:sharedProfile.authCredentials forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //4. Set HTTP Method
    [urlRequest setHTTPMethod:HTTP_METHOD_PATCH];//@"PATCH"];
    
    //7.Send parameters as JSON
    NSDictionary *statusDictionary = @{
                                       STATUS : liftStatus//CANCELLED
                                       };
    
    NSString *strRes = [myTools dictionaryToJSONString:statusDictionary];
    [urlRequest setHTTPBody:[strRes dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                      
                                      NSLog(@"ParseJson =%@", parseJSON);
                                      
                                      //Store data in Lift.....
                                      Lift *lift = [self fill_lift_tmp:parseJSON];
                                      //Additional values
                                      lift.driver_picture = sharedLiftNotified.notified_lift.driver_picture;
                                      
                                      lift.driver_name = sharedLiftNotified.notified_lift.driver_name;
                                      
                                      lift.passenger_name = sharedLiftNotified.notified_lift.passenger_name;
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          if (sharedLiftNotified.notified_by_driver)
                                          {
                                              if (sharedRoutesAsPassenger.lifts != nil)
                                              {
                                                  //[sharedRoutesAsPassenger.lifts insertObject:sharedLiftNotified.notified_lift atIndex:0];
                                                  [sharedRoutesAsPassenger.lifts insertObject:lift atIndex:0];
                                              }
                                              else
                                              {
                                                  sharedRoutesAsPassenger.lifts = [[NSMutableArray alloc]init];
                                                  //[sharedRoutesAsPassenger.lifts insertObject:sharedLiftNotified.notified_lift atIndex:0];
                                                  [sharedRoutesAsPassenger.lifts insertObject:lift atIndex:0];
                                              }
                                          }
                                          else
                                          {
                                              
                                              
                                              if (sharedRoutesAsDriver.lifts != nil)
                                              {
                                                  //[sharedRoutesAsDriver.lifts insertObject:sharedLiftNotified.notified_lift atIndex:0];
                                                  [sharedRoutesAsDriver.lifts insertObject:lift atIndex:0];
                                              }
                                              else
                                              {
                                                  sharedRoutesAsDriver.lifts = [[NSMutableArray alloc]init];
                                                  //[sharedRoutesAsDriver.lifts insertObject:sharedLiftNotified.notified_lift atIndex:0];
                                                  [sharedRoutesAsDriver.lifts insertObject:lift atIndex:0];
                                              }
                                          }
                                          
                                          //Go to MyTrips - But creates the another NEW instance!!!!!
                                          //?UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MyTripsStoryboard"];
                                          
                                          //?[self.navigationController pushViewController:vc animated:YES];
                                          [(MenuTabBarController*)self.tabBarController setSelectedIndex:2];
                                          MenuTabBarController *menuTabBarController = (MenuTabBarController*)self.tabBarController;
                                          
                                          MyTripsNavigationController *myTripsNC = [menuTabBarController selectedViewController];
                                          //[mTripsNC comingFrom:@"Driver"];
                                          
                                          ///
                                          NSArray *viewControllers = [myTripsNC viewControllers];
                                          
                                          MyTripsViewController*myTripsVC = viewControllers[0];
                                         // [self.navigationController pushViewController:myTripsVC animated:YES];
                                          [myTripsNC popToViewController:myTripsVC animated:YES];
                                          
                                          [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
                                          [indicatorView stopAnimating];
                                          
                                          
                                      });
                                      
                                  }];
    
    [task resume];
    
    //9. Start UIActivityIndicatorView for GUI purposes
    indicatorView = [myTools setActivityIndicator:self];
    [indicatorView startAnimating];
    
}


#pragma mark - Fill Objects
-(Lift *) fill_lift_tmp : (NSDictionary *)parseJSON //AsPassenger: (BOOL)asPassenger
{
    //Calculate total duration and amount
    //for each lift
    int total_steps_duration=0;
    double total_amount_steps=(double)0.0;
    
    
    Lift *lift = [[Lift alloc]init];
    
    lift.passenger_id = [parseJSON objectForKey:@"passenger_id"];
    lift.car_id = [parseJSON objectForKey:@"car_id"];
    lift._id = [parseJSON objectForKey:@"_id"];
    lift.driver_id = [parseJSON objectForKey:@"driver_id"];
    
    //Start point
    NSDictionary *start_point = [parseJSON objectForKey:@"start_point"];
    lift.start_address_date = [start_point objectForKey:@"date"];
    lift.start_address = [start_point objectForKey:@"address"];
    
    NSDictionary *start_point_coord = [start_point objectForKey:@"point"];
    lift.start_address_lon = [start_point_coord objectForKey:@"lon"];
    lift.start_address_lat = [start_point_coord objectForKey:@"lat"];
    
    //End point
    NSDictionary *end_point = [parseJSON objectForKey:@"end_point"];
    lift.end_address_date = [end_point objectForKey:@"date"];
    lift.end_address = [end_point objectForKey:@"address"];
    
    NSDictionary *end_point_coord = [end_point objectForKey:@"point"];
    lift.end_address_lon = [end_point_coord objectForKey:@"lon"];
    lift.end_address_lat = [end_point_coord objectForKey:@"lat"];
    
    lift.status = [parseJSON objectForKey:@"status"];
    lift.ride_id = [parseJSON objectForKey:@"ride_id"];
    
    //get trip values
    NSDictionary *getTrips = [parseJSON objectForKey:@"trip"];
    
    NSArray *getSteps = [getTrips objectForKey:@"steps"];
    
    Steps *step = [[Steps alloc] init];
    
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
    
    return lift;
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


@end
