
//
//  DriverDetailsViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou(CERTH) on 11/04/17.
//  Copyright © 2017 Kostas Kalogirou(CERTH). All rights reserved.
//

#import "DriverDetailsViewController.h"

@interface DriverDetailsViewController () <SFSafariViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@end

@implementation DriverDetailsViewController

- (void) comingFrom:(NSString *)viewControllerString
{
    viewControllerComesFrom = viewControllerString;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//-(void) viewWillAppear:(BOOL)animated
//{
    
  //  [super viewWillAppear:animated];
    // Do any additional setup after loading the view.
    
    sharedRoutes = [ShareRoutes sharedObject];
    
    sharedRoutesAsPassenger = [SharedRoutesAsPassenger sharedRoutesAsPassengerObject];
    sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];
    
    myTools = [[MyTools alloc]init];
    
    Steps *step = [[Steps alloc]init];
    
    int feedback_counter=0;
    
    //Comes form "RetrieveLifts"
    if ([viewControllerComesFrom isEqualToString:@"Passenger"])  //]@"RetrieveLifts"])
    {
        NSMutableArray *lifts = [[NSMutableArray alloc]init];
        lifts = sharedRoutesAsPassenger.lifts;
        Lift *lift = [lifts objectAtIndex:(int) sharedRoutesAsPassenger.lift_selected];
        
        NSMutableArray *stepsMArray = [[NSMutableArray alloc]init];
        stepsMArray = lift.steps;
        
        step = [stepsMArray objectAtIndex:(int) sharedRoutesAsPassenger.step_selected];
        
        feedback_counter = (int)sharedRoutesAsPassenger.feedbackArray.count;
        
   }
   else if ([viewControllerComesFrom isEqualToString:@"Driver"]) //]@"RetrieveLifts"])
   {
        NSMutableArray *lifts = [[NSMutableArray alloc]init];
        lifts = sharedRoutesAsDriver.lifts;
        Lift *lift = [lifts objectAtIndex:(int) sharedRoutesAsDriver.lift_selected];
        
        NSMutableArray *stepsMArray = [[NSMutableArray alloc]init];
        stepsMArray = lift.steps;
        
        step = [stepsMArray objectAtIndex:(int) sharedRoutesAsDriver.step_selected];
       
       feedback_counter = (int) sharedRoutesAsDriver.feedbackArray.count;
        
    }
  /* else if ([viewControllerComesFrom isEqualToString:@"Rides"]) //]@"RetrieveLifts"])
   {
       NSMutableArray *lifts = [[NSMutableArray alloc]init];
       lifts = sharedRoutesAsDriver.lifts;
       Lift *lift = [lifts objectAtIndex:(int) sharedRoutesAsDriver.lift_selected];
       
       NSMutableArray *stepsMArray = [[NSMutableArray alloc]init];
       stepsMArray = lift.steps;
       
       step = [stepsMArray objectAtIndex:(int) sharedRoutesAsDriver.step_selected];
       
   }*/
    else //comes from "findTrips"
    {
        NSMutableArray *stepsMArray = [[NSMutableArray alloc]init];
        stepsMArray = [sharedRoutes.tripSteps objectAtIndex:(int)sharedRoutes.trip_selected];

        step= [stepsMArray objectAtIndex:(int)sharedRoutes.step_selected];
        
        feedback_counter = (int) sharedRoutes.feedbackArray.count;
        
//        stepsMArray = sharedRoutes.steps;
//        step = [stepsMArray objectAtIndex: sharedRoutes.trip_selected];
    }
    
    driver = [step.driver objectAtIndex:0];
    car = [step.cars objectAtIndex:0];
    
    self.btn_facebook.layer.borderWidth = 0.4;
    self.btn_facebook.layer.borderColor = UIColor.blackColor.CGColor;
    
    self.btn_phone.layer.borderWidth = 0.4;
    self.btn_phone.layer.borderColor = UIColor.blackColor.CGColor;
    
    self.btn_message.layer.borderWidth = 0.4;
    self.btn_message.layer.borderColor = UIColor.blackColor.CGColor;
    
    
#pragma mark image photo
  //  [self setStyleForImageCirle:self.image_photo];
    
    if (driver.user_image)
    {
        self.image_photo.image = driver.user_image;
        
        CGSize size = CGSizeMake(80, 80);
        self.image_photo.image= [self imageWithImage:self.image_photo.image convertToSize:size];
        
        [self setStyleForImageCirle:self.image_photo];
  
    }
    
     if (driver.facebook_id != nil )
     {
         [self.btn_facebook setHidden:NO];
     }
     else
     {
         [self.btn_facebook setHidden:YES];
     }
//    else
//    {
//        self.image_photo.image = [UIImage imageNamed:@"Makrygiannis"];
//    }
    self.label_name.text = driver.user_name;
    self.label_feedback.text = driver.rating;
    
    self.label_feedback.text  = [self.label_feedback.text stringByAppendingString:@" ("];
    
    NSString *feedbackCounter = [NSString stringWithFormat:@"%lu",(unsigned long)feedback_counter];
    
    self.label_feedback.text = [self.label_feedback.text stringByAppendingString:feedbackCounter];
    
    if (feedback_counter >1)
    {
        self.label_feedback.text  = [self.label_feedback.text stringByAppendingString:@" feedbacks)"];
    }
    else
    {
        self.label_feedback.text  = [self.label_feedback.text  stringByAppendingString:@" feedback)"];
    }
    
//    self.label_feedback.text = [self.label_feedback.text stringByAppendingString:@" "];
//    self.label_feedback.text = [self.label_feedback.text stringByAppendingString:NSLocalizedString(@"feedback", @"feedback")];
    
    self.label_model.text = car.model;
    self.label_plate.text = car.plate;
    int seatsNumber = [car.seats intValue];
    
    self.label_seats.text = [NSString stringWithFormat:@"%i",seatsNumber];
  
  //  UIColor *colourCar = [self colourFromHexValue:[car.colour intValue]];
  //  [self.btn_colour setBackgroundColor:colourCar];

    
    NSString *getCarColourHexStr = car.colour;
    //if contains "#", then remove the "#" from hexadecimal String
    if ([getCarColourHexStr hasPrefix:@"#"])
    {
        //Remove first character which is "#" and keep the other 6 elements
        getCarColourHexStr = [getCarColourHexStr substringWithRange:NSMakeRange(1,6)];
    }
    
    unsigned colourInt = 0;
    //BOOL ok =
    [[NSScanner scannerWithString:getCarColourHexStr] scanHexInt:&colourInt];
    
   // BOOL ok = [[NSScanner scannerWithString:car.colour] scanHexInt:&colorInt];
 /*   NSString *hexStr= @"0xff4433"; //OK
    BOOL ok = [[NSScanner scannerWithString:hexStr] scanHexInt:&colorInt];
    
    hexStr= @"ff4433"; //OK
    ok = [[NSScanner scannerWithString:hexStr] scanHexInt:&colorInt];
    
    hexStr= @"#ff4433"; //NO
    ok = [[NSScanner scannerWithString:hexStr] scanHexInt:&colorInt];
    
    hexStr= @"ff443321"; //OK
    ok = [[NSScanner scannerWithString:hexStr] scanHexInt:&colorInt];

    hexStr= @"#ff443321"; //NO
    ok = [[NSScanner scannerWithString:hexStr] scanHexInt:&colorInt];
  
    NSString *hexStr= @"ff2121"; //NO
    ok = [[NSScanner scannerWithString:hexStr] scanHexInt:&colorInt];
    */
    UIColor *colourCar = UIColorFromRGB(colourInt); //define in .h file
    [self.btn_colour setBackgroundColor:colourCar];
    
    [self.table_driver_feedback reloadData];
    
}


#pragma mark - Styling picture as as circle
-(void) setStyleForImageCirle: (UIImageView *) imageView
{
    self.image_photo.backgroundColor = [UIColor clearColor];
    
    self.image_photo.layer.cornerRadius = self.image_photo.frame.size.width /2;
    
    //Core Animation creates an implicit clipping mask that matches the bounds of the layer and includes any corner radius effects
    self.image_photo.layer.masksToBounds =  YES;
    
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

#pragma mark - Buttons for calling schemes - open applications
//Change later the id from  fb:<profile>/<id>
- (IBAction)btn_facebook_pressed:(id)sender
{
    //see URL schemes: http://stackoverflow.com/questions/5707722/what-are-all-the-custom-url-schemes-supported-by-the-facebook-iphone-app
    NSString *driver_facebook_id = driver.facebook_id;
    //NSString *ulr_facebook= @"fb://profile/";
    NSString *ulr_facebook= @"*";
    //NSString *ulr_facebook= @"fb://profile?app_scoped_user_id=";
    //fb://profile?app_scoped_user_id=%@
    //NSString *ulr_facebook= @"*";
    
    ulr_facebook = [ulr_facebook stringByAppendingString:driver_facebook_id];
    
    
    // Check if FB app installed on device
   // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://profile/355356557838717"] options:@{}
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

- (void)displayFacebookInBrowser
{
    SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"*"] entersReaderIfAvailable:NO];
    safariVC.delegate = self;
    [self presentViewController:safariVC animated:NO completion:nil];
}

//Change later the phone number 123456
- (IBAction)btn_phone_pressed:(id)sender
{
    
    //NSString *URLString = @"tel://123456"; //
    NSString *URLString = [@"tel://" stringByAppendingString:driver.phone]; //[@"tel://"stringByAppendingString:textfield.text];
    
    NSURL *URL = [NSURL URLWithString:URLString];
    
    [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
   /* 
    //Skype
    
    NSString *contactName = @"user123";
    NSURL *skypeURL = [NSURL URLWithString:[NSString stringWithFormat:@"skype://%@?call",    contactName]];
    if ([[UIApplication sharedApplication] canOpenURL:skypeURL]) {
        [[UIApplication sharedApplication] openURL:skypeURL options:@{} completionHandler:nil];
    } else {
        // Display to the user how to install skype.
        NSLog(@"Cannot open skype");
    }
    */
}


//Cahnge later the phone number 30123456
- (IBAction)btn_message_pressed:(id)sender {
   
  //  NSString *stringURL = @"sms:+30123456";
    NSString *stringURL = [@"sms:" stringByAppendingString:driver.phone];
    
    NSURL *url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITAbleViewDataSource
//Asks the data source for a cell to insert in a particular location of the table view.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellFeedback";
    
    DriverFeedback *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DriverFeedbackCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell.image_driver setHidden:NO];


    Feedback *feedback = [[Feedback alloc] init];
    
    //if ([viewControllerComesFrom isEqualToString:@"RetrieveLifts"])
    if ([viewControllerComesFrom isEqualToString:@"Passenger"])
    {
        feedback = [sharedRoutesAsPassenger.feedbackArray objectAtIndex:(int) indexPath.row];
    }
    else if ([viewControllerComesFrom isEqualToString:@"Driver"])
    {
        feedback = [sharedRoutesAsPassenger.feedbackArray objectAtIndex:(int) indexPath.row];
    }
    else
    {
        feedback = [sharedRoutes.feedbackArray objectAtIndex:(int) indexPath.row];
    }
    
    cell.label_user_name.text = feedback.reviewer;
    
    // Convert string to date object
  /*  NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/YYYY"];
    //Convert Stiring into timestamp and format it to the "dd/MM/YYYY"
    NSTimeInterval _interval=[feedback.date longLongValue];
    NSDate *dateStr	 = [NSDate dateWithTimeIntervalSince1970:_interval];
  
    NSString *stringDate = [formatter stringFromDate:dateStr];
    */
    
    NSString *stringDate = [myTools convertTimeStampToString:feedback.date];
    
    cell.label_datetime.text = stringDate;
  //////////////////\\\\\\\\\\\\\\\\\\\
  
    cell.label_comments.text = feedback.review;
    [self displayStars:cell withRating:[feedback.rating intValue]];
    
    return cell;
}


-(void) displayStars: (DriverFeedback *) cell withRating:(int) rating
{
    UIImage *imageStarBlack = [UIImage imageNamed:@"star_black"];
    UIImage *imageStarGrey = [UIImage imageNamed:@"star_grey"];
    
    
    if (rating == 1)
    {
        cell.image_star1.image = imageStarBlack;
        
        cell.image_star2.image = imageStarGrey;
        cell.image_star3.image = imageStarGrey;
        cell.image_star4.image = imageStarGrey;
        cell.image_star5.image = imageStarGrey;
    }
    else if (rating == 2)
    {
        cell.image_star1.image = imageStarBlack;
        cell.image_star2.image = imageStarBlack;
        
        cell.image_star3.image = imageStarGrey;
        cell.image_star4.image = imageStarGrey;
        cell.image_star5.image = imageStarGrey;
    }
    else if (rating == 3)
    {
        cell.image_star1.image = imageStarBlack;
        cell.image_star2.image = imageStarBlack;
        cell.image_star3.image = imageStarBlack;
        
        cell.image_star4.image = imageStarGrey;
        cell.image_star5.image = imageStarGrey;
    }
    else if (rating == 4)
    {
        cell.image_star1.image = imageStarBlack;
        cell.image_star2.image = imageStarBlack;
        cell.image_star3.image = imageStarBlack;
        cell.image_star4.image = imageStarBlack;
        
        cell.image_star5.image = imageStarGrey;
    }
    else if (rating == 5)
    {
        cell.image_star1.image = imageStarBlack;
        cell.image_star2.image = imageStarBlack;
        cell.image_star3.image = imageStarBlack;
        cell.image_star4.image = imageStarBlack;
        cell.image_star5.image = imageStarBlack;
    }
    
}


//return the number of rows in a given section of a table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 1;//[tableData count];
    // return sharedRoutes.routes.count;
    //return sharedRoutes.tripsBE.count;
   
    //if ([viewControllerComesFrom isEqualToString:@"RetrieveLifts"])
    if ([viewControllerComesFrom isEqualToString:@"Passenger"])
    {
        return sharedRoutesAsPassenger.feedbackArray.count;
    }
    else if ([viewControllerComesFrom isEqualToString:@"Driver"])
    {
        return sharedRoutesAsDriver.feedbackArray.count;
    }
    else
    {
        return sharedRoutes.feedbackArray.count;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;//default value
}





/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Row selected = %lu",(unsigned long)indexPath.row);
    //show ViewContollerRouteDetails
    //[self performSegueWithIdentifier:@"segueRouteDetails" sender:self];
    sharedRoutes.trip_selected = indexPath.row;
    
    //show ViewContollerRouteDetails from navigation
    [self.navigationController performSegueWithIdentifier:@"showSegueRouteDetails" sender:self];
    
}*/


//Not used
//To cal it: //[self openScheme:URLString];
/*- (void)openScheme:(NSString *)scheme {
 UIApplication *application = [UIApplication sharedApplication];
 NSURL *URL = [NSURL URLWithString:scheme];
 
 if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
 [application openURL:URL options:@{}
 completionHandler:^(BOOL success) {
 NSLog(@"Open %@: %d",scheme,success);
 }];
 } else {
 BOOL success = [application openURL:URL];
 NSLog(@"Open %@: %d",scheme,success);
 }
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
