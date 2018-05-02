//
//  LeaveFeedbackViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 20/07/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "LeaveFeedbackViewController.h"

@interface LeaveFeedbackViewController ()

@end

@implementation LeaveFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    commonData = [[CommonData alloc]init];
    [commonData initWithValues];
  
    //Set default to zero
    ratingValue = @"0";
    
    myTools = [[MyTools alloc]init];
    
    sharedRoutesAsPassenger = [SharedRoutesAsPassenger sharedRoutesAsPassengerObject];
    sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];
    
    sharedProfileData = [SharedProfileData sharedObject];
  
    NSMutableArray *lifts =[[NSMutableArray alloc]init];
    
    
    if ([self.comingFromViewController isEqualToString:@"RouteDetailsStatus_leave_feedback_for_driver"])
    {
        NSLog(@"Coming from RouteDetailsStatus_leave_feedback_for_driver"); //=> I am Passenger
       
        lifts = sharedRoutesAsPassenger.lifts;
        lift = [lifts objectAtIndex:sharedRoutesAsPassenger.lift_selected];
        
        if (lift.driver_picture !=nil )
        {
            self.image_driver.image = lift.driver_picture;
            
            CGSize size = CGSizeMake(80, 80);
            self.image_driver.image= [self imageWithImage:self.image_driver.image convertToSize:size];
            
            [self setStyleForImageCirle:self.image_driver];
        }
        else
        {
            //  UIImage *image = [UIImage imageNamed:@"Makrygiannis"];
            UIImage *image = [UIImage imageNamed:@"account-circle-grey"];
            self.image_driver.image = image;
            
            CGSize size = CGSizeMake(80, 80);
            self.image_driver.image= [self imageWithImage:self.image_driver.image convertToSize:size];
            
            [self setStyleForImageCirle:self.image_driver];
        }
        
        self.label_driver_name.text = lift.driver_name;
    }
    else if ([self.comingFromViewController isEqualToString:@"RouteDetailsStatus_leave_feedback_for_passenger"])
    {
        NSLog(@"Coming from RouteDetailsStatus_leave_feedback_for_passenger");//I am DRIVER
        
        lifts = sharedRoutesAsDriver.lifts;
        lift = [lifts objectAtIndex:sharedRoutesAsDriver.lift_selected];
        
        if (lift.passenger_picture !=nil )
        {
            self.image_driver.image = lift.passenger_picture;
            
            CGSize size = CGSizeMake(80, 80);
            self.image_driver.image= [self imageWithImage:self.image_driver.image convertToSize:size];
            
            [self setStyleForImageCirle:self.image_driver];
        }
        else
        {
            //  UIImage *image = [UIImage imageNamed:@"Makrygiannis"];
            UIImage *image = [UIImage imageNamed:@"account-circle-grey"];
            self.image_driver.image = image;
            
            CGSize size = CGSizeMake(80, 80);
            self.image_driver.image= [self imageWithImage:self.image_driver.image convertToSize:size];
            
            [self setStyleForImageCirle:self.image_driver];
        }
        
        self.label_driver_name.text = lift.passenger_name;
    }
    
    self.textView_leaveFeedback.layer.borderWidth = 1.0f;
    self.textView_leaveFeedback.layer.borderColor = [[UIColor lightGrayColor] CGColor];
   
    image_star_black = [UIImage imageNamed:@"star_black"];
    
    image_star_empty = [UIImage imageNamed:@"ic_star_border"];
    
    self.textView_leaveFeedback.delegate = self;
 
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
}

#pragma mark - Dismiss keyboard when pressed outside UITextVIew
-(void)dismissKeyboard
{
    [self.textView_leaveFeedback resignFirstResponder];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.textView_leaveFeedback.text =@"";
    
    return YES;
}


//- (BOOL)textViewShouldEndEditing:(UITextView *)textView
//{
//    //self.textView_leaveFeedback resignFirstResponder
//    return YES;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btn_send_pressed:(id)sender
{
    indicatorView = [myTools setActivityIndicator:self];
    [indicatorView startAnimating];
    
    NSTimeInterval start_timeTimeInterval = [[NSDate date] timeIntervalSince1970];
    start_timeInseconds = (long) (start_timeTimeInterval);
    
    
    if ([self.comingFromViewController isEqualToString:@"RouteDetailsStatus_leave_feedback_for_driver"])
    {
        //I am PASSENGER
        [self createFeedbackForDriver];
    }
    else if ([self.comingFromViewController isEqualToString:@"RouteDetailsStatus_leave_feedback_for_passenger"])
    {
       // I am DRIVER
        [self createFeedbackForPassenger];
    }

    
}

#pragma mark - Call CREATE feedback for Driver
-(void) createFeedbackForDriver
{
  /*  NSString *urlStr = commonData.BASEURL_CREATE_FEEDBACK_FOR_DRIVER;
    
    urlStr = [urlStr stringByAppendingString:driver.userID];
    urlStr = [urlStr stringByAppendingString:@"/driver"];
  */
   
    //Send feedback as passenger for a driver
    NSString *urlStr = commonData.BASEURL_CREATE_FEEDBACKS;
  //  urlStr = [urlStr stringByAppendingString:sharedProfileData.userID];
  //  urlStr = [urlStr stringByAppendingString:@"/passenger"];
    
    //Send feedback as driver for a passenger
    //urlStr = [urlStr stringByAppendingString:passenger.userID];
    //urlStr = [urlStr stringByAppendingString:@"/passenger"];
    
    NSURL *urlWithString = [NSURL URLWithString:urlStr];
    NSLog(@"urlWithString=%@",urlWithString);
    
    //2. Create and send Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //3. Set HTTP Headers and HTTP Method
    [urlRequest setValue:sharedProfileData.authCredentials forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //4. Set HTTP Method
    [urlRequest setHTTPMethod:HTTP_METHOD_POST];
    
    //7.Send parameters as JSON
    //Here sharedProfileData.userID == lift.passenger_id
    NSDictionary *sendFeedbackDictionary = @{
                                       @"reviewer_id": sharedProfileData.userID,
                                       @"reviewed_id":lift.driver_id,
                                       @"lift_id": lift._id,
                                       @"review": self.textView_leaveFeedback.text,
                                       @"rating": ratingValue,
                                       @"date": [NSString stringWithFormat:@"%ld",
                                                 start_timeInseconds],
                                       @"role": @"driver"
                                       
                                       };
    
    NSString *strRes = [myTools dictionaryToJSONString:sendFeedbackDictionary];
    
    //[urlRequest setHTTPBody:[parametersRequest dataUsingEncoding:NSUTF8StringEncoding]];
    
    [urlRequest setHTTPBody:[strRes dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      case_call_API = 1;
                                      
                                      NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                      NSLog(@"ParseJson[createFeedbackForDriver] =%@", parseJSON);
                                      
                                      [self getResponse:parseJSON];
                                      
                                  }];
    [task resume];
    
}

#pragma mark - Call CREATE feedback
-(void) createFeedbackForPassenger
{
    /*  NSString *urlStr = commonData.BASEURL_CREATE_FEEDBACK_FOR_DRIVER;
     
     urlStr = [urlStr stringByAppendingString:driver.userID];
     urlStr = [urlStr stringByAppendingString:@"/driver"];
     */
    
    //Send feedback as passenger for a driver
    NSString *urlStr = commonData.BASEURL_CREATE_FEEDBACKS;
    //  urlStr = [urlStr stringByAppendingString:sharedProfileData.userID];
    //  urlStr = [urlStr stringByAppendingString:@"/passenger"];
    
    //Send feedback as driver for a passenger
    //urlStr = [urlStr stringByAppendingString:passenger.userID];
    //urlStr = [urlStr stringByAppendingString:@"/passenger"];
    
    NSURL *urlWithString = [NSURL URLWithString:urlStr];
    NSLog(@"urlWithString=%@",urlWithString);
    
    //2. Create and send Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //3. Set HTTP Headers and HTTP Method
    [urlRequest setValue:sharedProfileData.authCredentials forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //4. Set HTTP Method
    [urlRequest setHTTPMethod:HTTP_METHOD_POST];
    //Here sharedProfileData.userID == lift.driver_id
    //7.Send parameters as JSON
    NSDictionary *sendFeedbackDictionary = @{
                                             @"reviewer_id": sharedProfileData.userID,
                                           
                                             @"reviewed_id":lift.passenger_id,
                                             
                                             @"lift_id": lift._id,
                                             @"review": self.textView_leaveFeedback.text,
                                             @"rating": ratingValue,
                                             @"date": [NSString stringWithFormat:@"%ld",
                                                       start_timeInseconds],
                                             @"role": @"passenger"
                                             
                                             };
    
    NSString *strRes = [myTools dictionaryToJSONString:sendFeedbackDictionary];
    
    //[urlRequest setHTTPBody:[parametersRequest dataUsingEncoding:NSUTF8StringEncoding]];
    
    [urlRequest setHTTPBody:[strRes dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      case_call_API = 1;
                                      
                                      NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                      NSLog(@"ParseJson[createFeedbackForDriver] =%@", parseJSON);
                                      
                                      [self getResponse:parseJSON];
                                      
                                  }];
    [task resume];
    
}

-(void) getResponse: (NSDictionary *)parseJSON
{
    
    if ( [parseJSON objectForKey:@"_error"])
    {
        NSString *str = [parseJSON objectForKey:@"_issues"];
        NSString *strFormatted = [NSString stringWithFormat: @"%@",str];
        
        NSLog(@"_issues(strFormatted)=%@",strFormatted);
        
        
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
    else if (case_call_API == 1)
    {
        NSLog(@"Ok!");
       
        lift.status = REVIEWED;
        //Update GUI with safe-thread
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
            [indicatorView stopAnimating];
            
            
            // [self.tabBarController setSelectedIndex:2];
            NSArray *viewContollers = [self.navigationController viewControllers];
            RouteDetailsStatusViewController *routeDetailsStatusViewController = [viewContollers objectAtIndex:1];
            
            routeDetailsStatusViewController.view_ratingBanner_height.constant = 0.0f;
            
            routeDetailsStatusViewController.view_status_height.constant = 130.0f;
            
            NSString *statusStr = NSLocalizedString(@"STATUS: ", @"STATUS: ");
            routeDetailsStatusViewController.label_status.text = [statusStr stringByAppendingString:REVIEWED];
            
            [routeDetailsStatusViewController.btn_cancel setHidden:YES];
            [routeDetailsStatusViewController.image_pending setHidden:YES];
            
            routeDetailsStatusViewController.label_driver_status.text =@"";
            
            //Got back to previous UIViewContoller
            //?   [self.navigationController popViewControllerAnimated:YES];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            //    RequestedTripsViewController *requestedTripsViewController =[viewContollers objectAtIndex:0];
            
            
            
        });
 
    }
   /* else if (case_call_API == 2)
    {
       // lift.status = REVIEWED;
        lift.status = COMPLETED;

        //Update GUI with safe-thread
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
            [indicatorView stopAnimating];
            
            
           // [self.tabBarController setSelectedIndex:2];
            NSArray *viewContollers = [self.navigationController viewControllers];
            RouteDetailsStatusViewController *routeDetailsStatusViewController = [viewContollers objectAtIndex:1];
            
            routeDetailsStatusViewController.view_ratingBanner_height.constant = 0.0f;
            
            routeDetailsStatusViewController.view_status_height.constant = 130.0f;
            
            NSString *statusStr = NSLocalizedString(@"STATUS: ", @"STATUS: ");
            routeDetailsStatusViewController.label_status.text = [statusStr stringByAppendingString:COMPLETED];
            
            [routeDetailsStatusViewController.btn_cancel setHidden:YES];
            [routeDetailsStatusViewController.image_pending setHidden:YES];
            
            routeDetailsStatusViewController.label_driver_status.text =@"";
            
            //Got back to previous UIViewContoller
         //?   [self.navigationController popViewControllerAnimated:YES];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        //    RequestedTripsViewController *requestedTripsViewController =[viewContollers objectAtIndex:0];
            
            
            
        });
    }
    */
    
}

//Not used
//#pragma mark - Call updateLift_COMPLETE
//-(void) updateLift_COMPLETE //updateLift_REVIEWED
//{
//    NSString *ulrStr = commonData.BASEURL_UDATE_LIFTS;
//    ulrStr = [ulrStr stringByAppendingString:lift._id];
//    
//    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
//    NSLog(@"urlWitString=%@",urlWithString);
//    
//    //2. Create and send Request
//    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
//    //3. Set HTTP Headers and HTTP Method
//    [urlRequest setValue:sharedProfileData.authCredentials forHTTPHeaderField:@"Authorization"];
//    [urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
//    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    
//    //4. Set HTTP Method
//    [urlRequest setHTTPMethod:HTTP_METHOD_PATCH];
//    
//    //7.Send parameters as JSON
//    NSDictionary *statusDictionary = @{
//                                        STATUS : COMPLETED //REVIEWED
//                                       // STATUS : REVIEWED
//                                       };
//    
//    NSString *strRes = [myTools dictionaryToJSONString:statusDictionary];
//    
//    //[urlRequest setHTTPBody:[parametersRequest dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [urlRequest setHTTPBody:[strRes dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
//                                  {
//                                      case_call_API = 2;
//                                      
//                                      NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                                      NSLog(@"ParseJson[createFeedbackForDriver] =%@", parseJSON);
//                                      
//                                      [self getResponse:parseJSON];
//                                      
//                                  }];
//    [task resume];
//    
//}
//


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
    self.image_driver.backgroundColor = [UIColor clearColor];
    
    self.image_driver.layer.cornerRadius = self.image_driver.frame.size.width /2;
    
    //Core Animation creates an implicit clipping mask that matches the bounds of the layer and includes any corner radius effects
    self.image_driver.layer.masksToBounds =  YES;
}


- (IBAction)star1_tapped:(id)sender
{
    
    if (!star1_isTapped)
    {
        self.star_1.image = image_star_black;
        
        star1_isTapped = YES;
        
        ratingValue = @"1";
    }
    else
    {
        self.star_1.image = image_star_empty;
        self.star_2.image = image_star_empty;
        self.star_3.image = image_star_empty;
        self.star_4.image = image_star_empty;
        self.star_5.image = image_star_empty;
        
        
        star1_isTapped = NO;
        
        ratingValue = @"0";
    }
}

- (IBAction)star2_tapped:(id)sender
{
    if (!star2_isTapped)
    {
        self.star_1.image = image_star_black;
        self.star_2.image = image_star_black;
        
        star2_isTapped = YES;
        ratingValue = @"2";
    }
    else
    {
        self.star_2.image = image_star_empty;
        self.star_3.image = image_star_empty;
        self.star_4.image = image_star_empty;
        self.star_5.image = image_star_empty;
        
        star2_isTapped = NO;
        ratingValue = @"1";
    }
}

- (IBAction)star3_tapped:(id)sender
{
    if (!star3_isTapped)
    {
        self.star_1.image = image_star_black;
        self.star_2.image = image_star_black;
        self.star_3.image = image_star_black;
        
        star3_isTapped = YES;
        ratingValue = @"3";
    }
    else
    {
        self.star_3.image = image_star_empty;
        self.star_4.image = image_star_empty;
        self.star_5.image = image_star_empty;
        
        star3_isTapped = NO;
        ratingValue = @"2";
    }
}

- (IBAction)star4_tapped:(id)sender
{
    
    if (!star4_isTapped)
    {
        self.star_1.image = image_star_black;
        self.star_2.image = image_star_black;
        self.star_3.image = image_star_black;
        self.star_4.image = image_star_black;
        
        star4_isTapped = YES;
        ratingValue = @"4";
    }
    else
    {
        self.star_4.image = image_star_empty;
        self.star_5.image = image_star_empty;
       
        star4_isTapped = NO;
        ratingValue = @"3";
    }
}

- (IBAction)star5_tapped:(id)sender
{
    if (!star5_isTapped)
    {
        self.star_1.image = image_star_black;
        self.star_2.image = image_star_black;
        self.star_3.image = image_star_black;
        self.star_4.image = image_star_black;
        self.star_5.image = image_star_black;
        
        star5_isTapped = YES;
        ratingValue = @"5";
    }
    else
    {
        self.star_5.image = image_star_empty;
        
        star5_isTapped = NO;
        ratingValue = @"4";
    }
}

- (IBAction)stackview_stars_tapped:(id)sender {
    
    NSLog(@"Stack view tapped");
    
}

- (IBAction)view_stars_tapped:(id)sender {
    NSLog(@"View tapped");
}

//- (void)tapRecognized:(UITapGestureRecognizer *)recognizer
//{
//    if(recognizer.state == UIGestureRecognizerStateRecognized)
//    {
//        CGPoint point = [recognizer locationInView:recognizer.view];
//        // again, point.x and point.y have the coordinates
//        //if (point.x == self.star_1.
//        
//    }
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
