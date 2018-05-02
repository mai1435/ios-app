//
//  AppDelegate.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 29/11/16.
//  Copyright © 2016 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <Google/SignIn.h>
#import "SharedProfileData.h"
#import "SharedDriverProfileData.h"
#import "CommonData.h"
#import "ProfileDataViewControllerRegister.h"
#import "MenuTabBarController.h"
#import "ParseObjects.h"
#import "SinInViewController.h"

@import Firebase;
@import FirebaseMessaging;

#define MainStoryboard [UIStoryboard storyboardWithName:@"Main" bundle: nil]

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate,GIDSignInDelegate,FIRMessagingDelegate>
{
    SharedProfileData *sharedProfile;
    SharedDriverProfileData *sharedDriverProfile;
    
    SharedRoutesAsPassenger *sharedRoutesAsPassenger;
    SharedRoutesAsDriver *sharedRoutesAsDriver;
    
    ParseObjects *parseObjects;
    
    CommonData *commonData;
    
    Lift *lift;
    //  NSMutableArray *trips; //No need
    Steps *step;
}

@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) NSString *strDeviceToken;


@end

