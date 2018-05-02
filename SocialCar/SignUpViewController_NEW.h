//
//  SignUpViewController_NEW.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH)  on 11/09/17.
//  Copyright © 2017 CERTH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>
#import "SharedProfileData.h"
#import "SharedDriverProfileData.h"

#import "MenuTabBarController.h"
#import "ProfileDataViewControllerRegister.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface SignUpViewController_NEW : UIViewController <GIDSignInUIDelegate>
{
    SharedProfileData *sharedProfile;
    SharedDriverProfileData *sharedDriverProfile;
    
    CommonData *commonData;
}


@property (strong, nonatomic) IBOutlet UIView *view_lineLeft;

@property (strong, nonatomic) IBOutlet UIView *view_lineRight;


@property (strong, nonatomic) IBOutlet UIStackView *stackview_social;

@property (strong, nonatomic) IBOutlet UILabel *label_social;

@property (strong, nonatomic) IBOutlet UIStackView *stackView_facebook;

@property (strong, nonatomic) IBOutlet UIStackView *stackView_googlePlus;

@property (strong, nonatomic) IBOutlet UIButton *btn_continueByEmail;

@property (strong, nonatomic) FBSDKLoginManager* fbSDKLogin;

- (IBAction)tap_Facebook:(id)sender;
- (IBAction)tap_Google:(id)sender;

@end
