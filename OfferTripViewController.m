//
//  OfferTripViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH)on 25/07/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import "OfferTripViewController.h"

@interface OfferTripViewController ()

@end

@implementation OfferTripViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
// Do any additional setup after loading the view.
    
    sharedProfileData = [SharedProfileData sharedObject];
    
    if (sharedProfileData.hasCar)
    {
        UIColor *color_title = [UIColor whiteColor];
        [self.btn_offerTrip setTitleColor:color_title forState:UIControlStateNormal];
        
        [self.btn_offerTrip setEnabled:YES];
        
       
    }
    else
    {
        UIColor *color_title =[UIColor lightGrayColor];
        [self.btn_offerTrip setTitleColor:color_title forState:UIControlStateNormal];
        
        [self.btn_offerTrip setEnabled:NO];
        
        //Display only when it is viewed first time
        if (!self.isFirstTime)
        {
            [self alertCustom];
            self.isFirstTime = YES;
        }
        
    }
    
}

#pragma mark - alertCustom
-(void) alertCustom
{
    NSString *ok = NSLocalizedString(@"OK", @"OK");
    //  NSString *message_title = NSLocalizedString(@"Credentials", @"Credentials");
    NSString *message_title = NSLocalizedString(@"Car details required!", @"Car details required!");
    NSString *message_content = NSLocalizedString(@"It looks like you are not registered as a driver.Please fill in car details from Profile.", @"It looks like you are not registered as a driver.Please fill in car details from Profile.");
    
    UIAlertController *alertAuthenticationError = [UIAlertController
                                                   alertControllerWithTitle:message_title
                                                   message:message_content
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

- (IBAction)btn_offerTrip_pressed:(id)sender
{
    
    
	[self.navigationController performSegueWithIdentifier:@"segueSelectNewTripMode" sender:self.navigationController];

   /* HomePassengerViewController *homePassengerViewController = [MainStoryboard instantiateViewControllerWithIdentifier:@"Segment_Passenger"];
    
//    HomePassengerViewController *homePassengerViewController = [[HomePassengerViewController alloc]
//            initWithName:@"Segment_OfferedTrip"];
    
  //  HomePassengerViewController *homePassengerViewController = [[HomePassengerViewController alloc] init];
    
    [homePassengerViewController comingFrom: @"Segment_OfferedTrip"];
                                                                
    
    [self.navigationController pushViewController:homePassengerViewController animated:YES];
  */
    
   // NSArray *viewContorllers = [self.navigationController viewControllers];
    
    
  //OfferTripNavigationControllerViewController *offerTripNavigation = [[OfferTripNavigationControllerViewController alloc]init];
    
  //  [self.navigationController pop:offerTripNavigation animated:YES];
    
    //offerredTripNavigation
 
//    OfferTripNavigationControllerViewController *offerTripNavigation =  [MainStoryboard instantiateViewControllerWithIdentifier:@"offerredTripNavigation"];
//
//    [self presentViewController:offerTripNavigation animated:YES completion:nil];
    
    
}
@end
