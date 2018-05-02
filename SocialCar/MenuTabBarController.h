//
//  MenuTabBarController.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 28/02/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"

#import "LoginViewController_FINAL.h"
#import "MyTripsNavigationController.h"

#import "SharedDriverProfileData.h"
#import "ShareRoutes.h"

#import "SharedRoutesAsPassenger.h"
#import "SharedRoutesAsDriver.h"

#import "SharedProfileData.h"
#import "RequestedTripsViewController.h"

#import "Lift.h"
#import "Steps.h"
#import "Driver.h"
#import "Car.h"

#import "CommonData.h"
#import "MyTools.h"
#import "ParseObjects.h"

@interface MenuTabBarController : UITabBarController <UITabBarControllerDelegate, NSURLSessionDataDelegate>// , UINavigationControllerDelegate, UITableViewDelegate>

{
    SharedProfileData *sharedProfile;
    SharedDriverProfileData *sharedDriverProfile;
    SharedRoutesAsDriver *sharedRoutesAsDriver;
    
    ShareRoutes *sharedRoutes;
    
    SharedRoutesAsPassenger *sharedRoutesAsPassenger;
    
    NSURLSessionConfiguration *sessionConfiguration;
    int case_call_API;
    UIActivityIndicatorView *indicatorView;
    
    MyTools *myTools;
    CommonData *commonData;
    ParseObjects *parseObjects;
    
    // 1 Lift has many trips and 1 trip has many steps
    Lift *lift;
    //  NSMutableArray *trips; //No need
    Steps *step;
}

@property int tabBarItemPrevious;



@end
