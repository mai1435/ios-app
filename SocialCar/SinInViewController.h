//
//  SinInViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 03/01/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <SafariServices/SafariServices.h>

#import "KeychainItemWrapper.h"

#import "MenuTabBarController.h"
#import "SignUpViewController.h"
#import "SharedProfileData.h"
#import "SharedDriverProfileData.h"
#import "SharedRoutesAsPassenger.h"
#import "SharedRoutesAsDriver.h"
#import "ShareRoutes.h"


#import "Lift.h"
#import "Steps.h"
#import "Driver.h"
#import "Car.h"
#import "Ride.h"

#import "CommonData.h"
#import "MyTools.h"
#import "ParseObjects.h"

@interface SinInViewController : UIViewController <NSURLSessionDataDelegate , UITextFieldDelegate>
{    
    SharedProfileData *sharedProfile;
    SharedDriverProfileData *sharedDriverProfile;
    ShareRoutes *sharedRoutes;
    SharedRoutesAsPassenger *sharedRoutesAsPassenger;
    SharedRoutesAsDriver *sharedRoutesAsDriver;
 
    MyTools *myTools;
    CommonData *commonData;
    ParseObjects *parseObjects;
    NSURLSessionConfiguration *sessionConfiguration;
   
    NSData *authData;
    NSString *authValue;
    NSString *authStr;
    NSURLCredential *newCredential;
    
    // 1 Lift has many trips and 1 trip has many steps
    Lift *lift;
    //  NSMutableArray *trips; //No need
    Steps *step;
    
    int case_call_API; //1 = Authenticat euser, 2 = Find user
    
    UIActivityIndicatorView *indicatorView;
}

@property (strong, nonatomic) IBOutlet UITextField *txtfield_email;
@property (strong, nonatomic) IBOutlet UITextField *txtfield_password;
@property (strong, nonatomic) IBOutlet UIButton *btn_signUp;

@property (strong, nonatomic) IBOutlet UIButton *btn_signIn;
- (IBAction)btn_forgot_password:(id)sender;


- (IBAction)btn_signIn_pressed:(id)sender;

- (IBAction)btn_signUp_pressed:(id)sender;

- (void) authenticateUser;
- (void) authorizedUser;

@end
