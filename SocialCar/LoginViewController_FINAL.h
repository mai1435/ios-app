//
//  LoginViewController_FINAL.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 13/01/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SafariServices/SafariServices.h>

#import "SharedProfileData.h"
#import "SharedDriverProfileData.h"

#import "MultipleSelectionTableViewController.h"
#import "SignUpViewController.h"
#import "SinInViewController.h"

#import "MenuTabBarController.h"
#import "ProfileDataViewControllerRegister.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Google/SignIn.h>
#import "CommonData.h"


@interface LoginViewController_FINAL : UIViewController <GIDSignInUIDelegate>
{
    SharedProfileData *sharedProfile;
    SharedDriverProfileData *sharedDriverProfile;
    CommonData *commonData;
}

@property (strong, nonatomic) IBOutlet UIStackView *stackViewOR;
@property (strong, nonatomic) IBOutlet UIView *viewLineLeft;

@property (strong, nonatomic) IBOutlet UIStackView *stackViewChoicesLogin;

//@property (strong, nonatomic) IBOutlet UIStackView *btn_faceBook_custom;

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *btn_facebook;

@property (strong, nonatomic) FBSDKLoginManager* fbSDKLogin;

@property (strong, nonatomic) IBOutlet UIButton *btn_google;

//@property (strong, nonatomic) FBSDKAccessToken *currentUserLoggedIn;

@property (strong, nonatomic) IBOutlet UILabel *labelOR;

@property (strong, nonatomic) IBOutlet UIView *viewLineRight;

//- (IBAction)btn_SignUp_pressed:(id)sender;

- (IBAction)btn_googleplus_pressed:(id)sender;
- (IBAction)btn_facebook_pressed:(id)sender;

@end
