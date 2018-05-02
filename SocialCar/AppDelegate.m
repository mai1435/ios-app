//
//  AppDelegate.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 29/11/16.
//  Copyright © 2016 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Firebase/Firebase.h>
#import "UIUtils.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

NSString *const kGCMMessageIDKey = @"gcm.message_id";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    sharedProfile = [SharedProfileData sharedObject];
    sharedDriverProfile = [SharedDriverProfileData sharedObject];
    
    sharedRoutesAsPassenger = [SharedRoutesAsPassenger sharedRoutesAsPassengerObject];
    sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];
    
    
    commonData = [[CommonData alloc]init];
    [commonData initWithValues];
    
    //Clear NSUSerDefaults <<<<<< ****** !!!!!**********>>>>
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController *navController;
    
    
    //first-time ever defaults check and set
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"TermsAccepted"]!=YES)
    {
        UINavigationController *termsAndConditionsNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"termsAndConditionsNavigationController"];
        
        navController = termsAndConditionsNavigationController;
        
    }
    else
    {
         UINavigationController *mainNavigationController = [storyboard instantiateViewControllerWithIdentifier:@"mainNavigationController"];
         
         navController = mainNavigationController;
       
    }
    
    self.window.rootViewController=navController;
    
    //Configure GGLContext for Google Sign-in
    NSError* configureError;
    [[GGLContext sharedInstance] configureWithError: &configureError];
    //NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
    [GIDSignIn sharedInstance].delegate = self;
    
    /*
     To post-process the results from actions that require you to switch to the native Facebook app or Safari,
     such as Facebook Login or Facebook Dialogs, you need to connect your AppDelegate class to the FBSDKApplicationDelegate object
     */
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    // Add any custom logic here.
    [FIRApp configure];
    [FIRMessaging messaging].delegate = self;
    [FIRMessaging messaging].shouldEstablishDirectChannel = YES;

    [self setupNotifications];

    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    if ( [countryCode isEqualToString:@"GB"] )
    {
        
    }
	[UIUtils startAppCustomization];
    return YES;
}

/*
 The method should call the handleURL method of the GIDSignIn instance, which will properly handle the URL that your application receives at the end of the authentication process.
 */

#pragma mark - GIDSignInDelegate  and FBSDKApplicationDelegate method
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options

{

    NSString *stringURL = [ url absoluteString];
    
    if([stringURL containsString:@"fb"])
    {
        return ([[FBSDKApplicationDelegate sharedInstance] application:app
                                                               openURL:url
                                                     sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                            annotation:options[UIApplicationOpenURLOptionsAnnotationKey]]);
    }
    else //if (sharedProfile.useGoogle)
    {
        return ([[GIDSignIn sharedInstance] handleURL:url
                               sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                      annotation:options[UIApplicationOpenURLOptionsAnnotationKey]]);
    }
}

/*#pragma mark - FaceBook
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled;
}*/

#pragma mark - GIDSignInDelegate method
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    
    if (user != nil)
    {
        // Perform any operations on signed in user here.
        NSString *userId = user.userID;// For client-side use only!
        sharedProfile.google_userID = userId;
        
        NSString *idToken = user.authentication.idToken; // Safe to send to the server
        sharedProfile.google_idToken = idToken;
        
        NSString *fullName = user.profile.name;
        sharedProfile.user_name = fullName;
        
        NSString *givenName = user.profile.givenName;
        
        NSString *familyName = user.profile.familyName;
        
        NSString *email = user.profile.email;
        sharedProfile.email = email;
        
        
        // ...
        if ([GIDSignIn sharedInstance].currentUser.profile.hasImage)
        {
            // NSUInteger dimension = round(thumbSize.width * [[UIScreen mainScreen] scale]);
            NSURL *imageURL = [user.profile imageURLWithDimension:80];
            sharedProfile.google_picture_URL = imageURL;
            
            //You have to upload picture
            //NSURL *imageURL = [NSURL URLWithString:sharedProfile.picture_file];
            NSData *imageData = [NSData dataWithContentsOfURL:sharedProfile.google_picture_URL];
            
            UIImage *image = [UIImage imageWithData:imageData];
            sharedProfile.user_image = image;
        }
        
        
        NSLog(@"Login user %@",user.profile.name);
        NSLog(@"Login user google idToken %@",idToken);
        NSLog(@"Login user google userId %@",userId);
    
        sharedProfile.useGoogle = YES;
    
        [self findUserFaceBookOrGoogle];
    }
    else
    {
         //Go back to previous page
        //mainPageStoryboard
        //LoginViewController_FINAL
       //? sharedProfile.userGoogleNil = YES;
        
      /*  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        LoginViewController_FINAL *profileVC = [storyboard instantiateViewControllerWithIdentifier:@"mainPageStoryboard"];
        
        [(UINavigationController*)self.window.rootViewController pushViewController:profileVC animated:NO];
       */
   //?     [[GIDSignIn sharedInstance] disconnect];
        
    }
    
}

- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
    // ...
    NSLog(@"Diconnect user %@", user.profile.name);
    sharedProfile.useGoogle = NO;
    
}

#pragma mark - End of GIDSignInDelegate methods


#pragma mark - Check whether Google or Facebook user exists in SocialCar
- (void)findUserFaceBookOrGoogle
{
    //http://api.socialcar-project.eu:5000/rest/v2/users?email=testXX
    //http://BASEURL/users?social_provider.social_network=FACEBOOK&social_provider.social_id=123456
    
    NSString *ulrStr = commonData.BASEURL;
    ulrStr = [ulrStr stringByAppendingString:@"users?social_provider.social_network="];
    
    
    if (sharedProfile.useGoogle)
    {
        //ulrStr = [ulrStr stringByAppendingString:sharedProfile.email];
        ulrStr = [ulrStr stringByAppendingString:SOCIAL_NETWORK_GOOGLE];
    }
    else if (sharedProfile.useFacebook)
    {
        //ulrStr = [ulrStr stringByAppendingString:sharedProfile.email];
        ulrStr = [ulrStr stringByAppendingString:SOCIAL_NETWORK_FACEBOOK];
    }
    ulrStr = [ulrStr stringByAppendingString:@"&social_provider.social_id="];
    
    if (sharedProfile.useGoogle)
    {
        ulrStr = [ulrStr stringByAppendingString:sharedProfile.google_userID];
    }
    
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    NSLog(@"urlWitString=%@",urlWithString);
    
    //2. Create and send Request
    
    //You need dummy credentials accoridng to API documentatin paragraph 2.4
    NSURLCredential *dummyCredentials = [NSURLCredential credentialWithUser:@"TestUser"
        password:@"TestUserPassword" persistence:NSURLCredentialPersistenceNone];
    
    NSString *authStr = [dummyCredentials user];
    authStr = [authStr stringByAppendingString:@":"];
    authStr  = [authStr stringByAppendingString:[dummyCredentials password] ];
    
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
                                      //                                      indicatorView = [myTools setActivityIndicator:self];
                                      //                                      [indicatorView startAnimating];
                                      
                                      NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                      
                                      NSLog(@"ParseJson[users] =%@", parseJSON);
                                      
                                      NSArray *usersArray = [parseJSON valueForKey:@"users"];
                                      
                                      if (usersArray.count == 0)
                                      {
                                          [self goNextScreen:NO];
                                      }
                                      else
                                      {
                                       
                              //            sharedProfile.userID = [usersArray[0] valueForKey:@"_id"];
                                          
                                //          sharedProfile.email = [usersArray[0] valueForKey:@"email"];
                                          
                                          [self fill_userProfile :usersArray[0]];
                                          
                                          [self goNextScreen:YES];
                                          
                                      }
                                      
                                      
                                      
                                      
                                  }];
    [task resume];
    
    //8. Start UIActivityIndicatorView for GUI purposes
    //    indicatorView = [myTools setActivityIndicator:self];
    //    [indicatorView startAnimating];
    
}



-(void) goNextScreen:(BOOL) foundUser
{

    //Update GUI with safe-thread
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!foundUser)
        {
            //push view manually
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            //ProfileDataViewControllerRegister *profileVC = [storyboard instantiateViewControllerWithIdentifier:@"profileDataRegisterStoryboard"];
            
            ProfileDataViewControllerRegister *profileVC = [storyboard instantiateViewControllerWithIdentifier:@"profileDataRegisterStoryboardLIMIT"];
            
            [(UINavigationController*)self.window.rootViewController pushViewController:profileVC animated:NO];

        }
        else
        {
            //Assgin values to
           /* UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            MenuTabBarController *menuTabBarController = (MenuTabBarController *)[storyboard instantiateViewControllerWithIdentifier:@"menuTabStoryboard"];
            
            self.window.rootViewController = menuTabBarController;
            [self.window makeKeyAndVisible];
            */
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            SinInViewController *sinInViewController = (SinInViewController *)[storyboard instantiateViewControllerWithIdentifier:@"signInStoryboard"];
            
            self.window.rootViewController = sinInViewController;
            [self.window makeKeyAndVisible];
            
            
            //signInStoryboard
        }
        /*[UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
        [indicatorView stopAnimating];
        
        MenuTabBarController *menuTabBarController = (MenuTabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"menuTabStoryboard"];
        
        self.view.window.rootViewController = menuTabBarController;
        [self.view.window makeKeyAndVisible];*/
        
    });
}

#pragma mark - Notifications


- (void)setupNotifications
{
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_9_x_Max)
    {
        UIUserNotificationType allNotificationTypes = (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    else
    {
        // iOS 10 or later
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        // For iOS 10 display notification (sent via APNS)
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
        }];
#endif
    }
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenRefreshNotification) name:kFIRInstanceIDTokenRefreshNotification object:nil];
}

- (void)tokenRefreshNotification
{
    NSString *token = [FIRInstanceID instanceID].token;
    if (token)
    {
        sharedProfile.fcm_token = [FIRInstanceID instanceID].token;
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // If you are receiving a notification message while your app is in the background,
    // this callback will not be fired till the user taps on the notification launching the application.
    // TODO: Handle data of notification
    
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // [[Messaging messaging] appDidReceiveMessage:userInfo];
    
    // Print full message.
    NSLog(@"%@", userInfo);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    // Print full message.
    NSLog(@"%@", userInfo);
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)applicationReceivedRemoteMessage:(FIRMessagingRemoteMessage *)remoteMessage
{
    NSLog(@"%@", [remoteMessage appData]);
}

// [START ios_10_message_handling]
// Receive displayed notifications for iOS 10 devices.
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// Handle incoming notification messages while app is in the foreground.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    // Print full message.
    NSLog(@"%@", userInfo);
    
    // Change this to your preferred presentation option
    completionHandler(UNNotificationPresentationOptionAlert|UNAuthorizationOptionSound);
}

// Handle notification messages after display notification is tapped by the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler
{
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    // Print full message.
    NSError *error;
    NSLog(@"%@", [userInfo objectForKey:@"body"]);
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[[[userInfo valueForKey:@"body"] stringByReplacingOccurrencesOfString:@"'" withString:@"\""] dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];

   if ([[json objectForKey:@"status"] isEqualToString:@"PENDING"])
   {
        SharedLiftNotified *sharedLiftNotified = [SharedLiftNotified sharedLiftNotifiedObject];
        //sharedLiftNotified.notified_by_driver = NO;
        sharedLiftNotified.notified_lift = [[Lift alloc]init];
        sharedLiftNotified.notified_lift._id = [json objectForKey:@"_id"];
        sharedLiftNotified.notified_lift.driver_id = [json objectForKey:@"driver_id"];
        // @"58d3ac2de04bd5249b4f6600";
        
        sharedLiftNotified.notified_lift.passenger_id = [json objectForKey:@"passenger_id"];
       
       if ([sharedProfile.userID isEqualToString:sharedLiftNotified.notified_lift.driver_id])
       {
           //I AM DRIVER
           sharedLiftNotified.notified_by_driver = NO;
           
           for (int i=0; i< sharedRoutesAsDriver.lifts.count;i++)
           {
               Lift *lift_found = sharedRoutesAsDriver.lifts[i];
               
               if ([lift_found._id isEqualToString: sharedLiftNotified.notified_lift._id])
               {
                   lift_found.status = sharedLiftNotified.notified_lift.status;
                   
                   [sharedRoutesAsDriver.lifts replaceObjectAtIndex:i withObject:lift_found];
                   
                   break;
               }
           }
           
           [(MenuTabBarController*)self.window.rootViewController setSelectedIndex:2];
           MyTripsNavigationController *myTripNC = [[(MenuTabBarController*)self.window.rootViewController viewControllers] objectAtIndex:2];
           [myTripNC performSegueWithIdentifier:@"showSegueDriverDetailsFromNotification" sender:self];
           
           //Instead of perform Segue
           
       }
       else
       {
           //I AM PASSENGER
           sharedLiftNotified.notified_by_driver = YES;
           
           for (int i=0; i< sharedRoutesAsPassenger.lifts.count;i++)
           {
               Lift *lift_found = sharedRoutesAsPassenger.lifts[i];
               
               if ([lift_found._id isEqualToString: sharedLiftNotified.notified_lift._id])
               {
                   lift_found.status = sharedLiftNotified.notified_lift.status;
                   
                   [sharedRoutesAsPassenger.lifts replaceObjectAtIndex:i withObject:lift_found];
                   
                   break;
                   
               }
               
           }
           
           [(MenuTabBarController*)self.window.rootViewController setSelectedIndex:2];
           MenuTabBarController *menuTabBarController = (MenuTabBarController*)self.window.rootViewController;
           
           MyTripsNavigationController *mTripsNC = [menuTabBarController selectedViewController];
           [mTripsNC comingFrom:@"Passenger"];
           
       }
       
       
    }
 
//    else if ([[json objectForKey:@"status"] isEqualToString:@"CANCELLED"]) {
//        SharedLiftNotified *sharedLiftNotified = [SharedLiftNotified sharedLiftNotifiedObject];
//        sharedLiftNotified.notified_by_driver = NO;
//        sharedLiftNotified.notified_lift = [[Lift alloc]init];
//        sharedLiftNotified.notified_lift._id = [json objectForKey:@"_id"];
//        sharedLiftNotified.notified_lift.driver_id = [json objectForKey:@"driver_id"];
//        // @"58d3ac2de04bd5249b4f6600";
//        
//        sharedLiftNotified.notified_lift.passenger_id = [json objectForKey:@"passenger_id"];
//        
//        [(MenuTabBarController*)self.window.rootViewController setSelectedIndex:2];
//        MyTripsNavigationController *myTripNC = [[(MenuTabBarController*)self.window.rootViewController viewControllers] objectAtIndex:2];
//        [myTripNC performSegueWithIdentifier:@"showSegueDriverDetailsFromNotification" sender:self];
//    }
// ?
    else if ([[json objectForKey:@"status"] isEqualToString:@"ACTIVE"])
    {
        /////Code added by Kostas
        
        SharedLiftNotified *sharedLiftNotified = [SharedLiftNotified sharedLiftNotifiedObject];
        
        sharedLiftNotified.notified_lift = [[Lift alloc]init];
        sharedLiftNotified.notified_lift._id = [json objectForKey:@"_id"];
        sharedLiftNotified.notified_lift.status = [json objectForKey:@"status"];
        sharedLiftNotified.notified_lift.driver_id = [json objectForKey:@"driver_id"];
        
        sharedLiftNotified.notified_lift.passenger_id = [json objectForKey:@"passenger_id"];
        
        if ([sharedProfile.userID isEqualToString:sharedLiftNotified.notified_lift.passenger_id])
        {
            //I AM PASSENGER
            sharedLiftNotified.notified_by_driver = YES;
            
            for (int i=0; i< sharedRoutesAsPassenger.lifts.count;i++)
            {
                Lift *lift_found = sharedRoutesAsPassenger.lifts[i];
                
                if ([lift_found._id isEqualToString: sharedLiftNotified.notified_lift._id])
                {
                    lift_found.status = sharedLiftNotified.notified_lift.status;
                    
                    [sharedRoutesAsPassenger.lifts replaceObjectAtIndex:i withObject:lift_found];
                    
                    break;
                    
                }
                
            }

        }
        ////
        if ([sharedProfile.userID isEqualToString:sharedLiftNotified.notified_lift.driver_id])
        {
            //I AM DRIVER
            sharedLiftNotified.notified_by_driver = NO;
            
            for (int i=0; i< sharedRoutesAsDriver.lifts.count;i++)
            {
                Lift *lift_found = sharedRoutesAsDriver.lifts[i];
                
                if ([lift_found._id isEqualToString: sharedLiftNotified.notified_lift._id])
                {
                    lift_found.status = sharedLiftNotified.notified_lift.status;
                    
                    [sharedRoutesAsDriver.lifts replaceObjectAtIndex:i withObject:lift_found];
                    
                    break;
                    
                }
                
            }
            
        }

        
        
        
        ///
        /////Code added by Kostas
        //[(MenuTabBarController*)self.window.rootViewController setSelectedIndex:2];
        //IF AND ONLY IF I AM PASSENGER
        //I AM PASSENGER
        if (sharedLiftNotified.notified_by_driver)
        {
            [(MenuTabBarController*)self.window.rootViewController setSelectedIndex:2];
            MenuTabBarController *menuTabBarController = (MenuTabBarController*)self.window.rootViewController;
            
            MyTripsNavigationController *mTripsNC = [menuTabBarController selectedViewController];
            [mTripsNC comingFrom:@"Passenger"];
            
            ///
            NSArray *viewControllers = [mTripsNC viewControllers];
            
            MyTripsViewController*myTripsVC = viewControllers[0];
            //I AM PASSENGER
            [myTripsVC.segmentControl setSelectedSegmentIndex:0];
            //REFRESH table with the new value in "Cancelled" trip in the row
            RequestedTripsViewController *requestedTripsVC = (RequestedTripsViewController *)myTripsVC.currentViewController;
            [requestedTripsVC comingFrom:@"Passenger"];
            
            [requestedTripsVC.tableView_requestedTrips reloadData];
 
        }
        else //if I AM DRIVER
        {
            [(MenuTabBarController*)self.window.rootViewController setSelectedIndex:2];
            MenuTabBarController *menuTabBarController = (MenuTabBarController*)self.window.rootViewController;
            
            MyTripsNavigationController *mTripsNC = [menuTabBarController selectedViewController];
            [mTripsNC comingFrom:@"Driver"];
            
            ///
            NSArray *viewControllers = [mTripsNC viewControllers];
            
            MyTripsViewController*myTripsVC = viewControllers[0];
            //I AM DRIVER
            [myTripsVC.segmentControl setSelectedSegmentIndex:1];
            //REFRESH table with the new value in "Cancelled" trip in the row
            RequestedTripsViewController *requestedTripsVC = (RequestedTripsViewController *)myTripsVC.currentViewController;
            [requestedTripsVC comingFrom:@"Driver"];
            
            [requestedTripsVC.tableView_requestedTrips reloadData];
        }
        /////////
        
    }
    else if ([[json objectForKey:@"status"] isEqualToString:@"CANCELLED"])
    {
    
        SharedLiftNotified *sharedLiftNotified = [SharedLiftNotified sharedLiftNotifiedObject];
    
        sharedLiftNotified.notified_lift = [[Lift alloc]init];
        sharedLiftNotified.notified_lift._id = [json objectForKey:@"_id"];
        sharedLiftNotified.notified_lift.status = [json objectForKey:@"status"];
        sharedLiftNotified.notified_lift.driver_id = [json objectForKey:@"driver_id"];
        
        sharedLiftNotified.notified_lift.passenger_id = [json objectForKey:@"passenger_id"];
        
        if ([sharedProfile.userID isEqualToString:sharedLiftNotified.notified_lift.passenger_id])
        {
            //I AM PASSENGER
            sharedLiftNotified.notified_by_driver = YES;
            
            for (int i=0; i< sharedRoutesAsPassenger.lifts.count;i++)
            {
                Lift *lift_found = sharedRoutesAsPassenger.lifts[i];
                
                if ([lift_found._id isEqualToString: sharedLiftNotified.notified_lift._id])
                {
                    lift_found.status = sharedLiftNotified.notified_lift.status;
                    
                    [sharedRoutesAsPassenger.lifts replaceObjectAtIndex:i withObject:lift_found];
                    
                    break;
                    
                }
                
            }
            
            [(MenuTabBarController*)self.window.rootViewController setSelectedIndex:2];
            MenuTabBarController *menuTabBarController = (MenuTabBarController*)self.window.rootViewController;
            
            MyTripsNavigationController *mTripsNC = [menuTabBarController selectedViewController];
            [mTripsNC comingFrom:@"Passenger"];
        
            ///
            NSArray *viewControllers = [mTripsNC viewControllers];
            
            MyTripsViewController*myTripsVC = viewControllers[0];
            //I AM PASSENGER
            [myTripsVC.segmentControl setSelectedSegmentIndex:0];
            //REFRESH table with the new value in "Cancelled" trip in the row
            RequestedTripsViewController *requestedTripsVC = (RequestedTripsViewController *)myTripsVC.currentViewController;
            [requestedTripsVC comingFrom:@"Passenger"];
            
            [requestedTripsVC.tableView_requestedTrips reloadData];
            //////
            
            
        }
        else
        {
            
            //I AM DRIVER
            sharedLiftNotified.notified_by_driver = NO;
      
            for (int i=0; i< sharedRoutesAsDriver.lifts.count;i++)
            {
                Lift *lift_found = sharedRoutesAsDriver.lifts[i];
                
                if ([lift_found._id isEqualToString: sharedLiftNotified.notified_lift._id])
                {
                    lift_found.status = sharedLiftNotified.notified_lift.status;
                    
                    [sharedRoutesAsDriver.lifts replaceObjectAtIndex:i withObject:lift_found];
                    
                    break;
                }
            }
            
            [(MenuTabBarController*)self.window.rootViewController setSelectedIndex:2];
            MenuTabBarController *menuTabBarController = (MenuTabBarController*)self.window.rootViewController;
            
            MyTripsNavigationController *mTripsNC = [menuTabBarController selectedViewController];
            [mTripsNC comingFrom:@"Driver"];
            
            ///
            NSArray *viewControllers = [mTripsNC viewControllers];
            
            MyTripsViewController*myTripsVC = viewControllers[0];
            //I AM DRIVER
            [myTripsVC.segmentControl setSelectedSegmentIndex:1];
            //REFRESH table with the new value in "Cancelled" trip in the row
            RequestedTripsViewController *requestedTripsVC = (RequestedTripsViewController *)myTripsVC.currentViewController;
            [requestedTripsVC comingFrom:@"Driver"];
            
            [requestedTripsVC.tableView_requestedTrips reloadData];
            //////
            
        }
        
    } //YOU SHOULD DO THE ABOVE WITH CANCELLED
    else if ([[json objectForKey:@"status"] isEqualToString:@"REFUSED"]) {
        [(MenuTabBarController*)self.window.rootViewController setSelectedIndex:2];
    }

    completionHandler();
    
}

#endif
// [END ios_10_message_handling]

// [START refresh_token]
- (void)messaging:(nonnull FIRMessaging *)messaging didRefreshRegistrationToken:(nonnull NSString *)fcmToken
{
    // Note that this callback will be fired everytime a new token is generated, including the first
    // time. So if you need to retrieve the token as soon as it is available this is where that
    // should be done.
    NSLog(@"FCM registration token: %@", fcmToken);
    sharedProfile.fcm_token = fcmToken;
    
    // TODO: If necessary send token to application server.
}
// [END refresh_token]

// [START ios_10_data_message]
// Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
// To enable direct data messages, you can set [Messaging messaging].shouldEstablishDirectChannel to YES.
- (void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage
{
        NSLog(@"didReceiveMessages: %@", remoteMessage.appData);
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.userInfo = remoteMessage.appData;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.alertBody = @"ciao";
        localNotification.fireDate = [NSDate date];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

}
// [END ios_10_data_message]

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError: %@", error);
}

// This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
// If swizzling is disabled then this function must be implemented so that the APNs device token can be paired to
// the FCM registration token.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    NSLog(@"APNs device token retrieved: %@", [FIRInstanceID instanceID].token);
    sharedProfile.fcm_token = [FIRInstanceID instanceID].token;
}


#pragma mark - Retrieve data after signing in with Google or Facebook
-(void) fill_userProfile : (NSDictionary *) parseJSON
{
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
    NSLog(@"gender=%@",[parseJSON valueForKey:@"gender"]);
    
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
    
    sharedProfile.carpooler_gender  = [travel_preferences valueForKey:@"carpooler_preferred_gender"];
    NSLog(@"carpooler_gender=%@", [travel_preferences valueForKey:@"carpooler_preferred_gender"]);
    
    //Convert NSNumber value to BOOL and then String
    sharedProfile.gps_tracking =  [[travel_preferences valueForKey:@"gps_tracking"]  boolValue ] ? @"Yes" : @"No" ;
    NSLog(@"sharedProfile.gps_tracking =%@",sharedProfile.gps_tracking );
    
    sharedProfile.luggage =  [[travel_preferences valueForKey:@"luggage"]  boolValue ] ? @"Yes" : @"No" ;
    NSLog(@"sharedProfile.luggage =%@",sharedProfile.luggage );
    
    sharedProfile.pets =  [[travel_preferences valueForKey:@"pets"]  boolValue ] ? @"Yes" : @"No" ;
    NSLog(@"sharedProfile.pets =%@",sharedProfile.pets );
    
    sharedProfile.smoking =  [[travel_preferences valueForKey:@"smoking"]  boolValue ] ? @"Yes" : @"No" ;
    NSLog(@"sharedProfile.smoking =%@",sharedProfile.smoking );
    
    sharedProfile.food =  [[travel_preferences valueForKey:@"food"]  boolValue ] ? @"Yes" : @"No" ;
    NSLog(@"sharedProfile.food =%@",sharedProfile.food );
    
    sharedProfile.music =  [[travel_preferences valueForKey:@"music"]  boolValue ] ? @"Yes" : @"No" ;
    NSLog(@"sharedProfile.music =%@",sharedProfile.music );
    //End of converting NSNumber value to BOOL and then String
    
    
    //Compare NSMutuableArray with CommonData
    //and store "Yes" or "No" value respectively
    //          commonData = [[CommonData alloc]init];
    //          [commonData initWithValues];
    
    NSString *yes = NSLocalizedString(@"Yes", @"Yes");
    NSString *no = NSLocalizedString(@"No", @"No");
    
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
            if ([optimisationArray[i] isEqualToString:commonData.tableOptimiseTravelSolutions[j]])
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
            if ([tableTravelModesValues[i] isEqualToString:commonData.tableTravelModes[j]])
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
            if ([tableSpecialNeeds[i] isEqualToString:commonData.tableSpecialNeeds[j]])
            {
                [sharedProfile.tableSpecialNeeds replaceObjectAtIndex:j withObject:yes];
                break;
            }
        }
    }
    
    
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
        
        //Now call API to get car data
  //?      [self retrieveCar];
        
        //and ride data
    }
    else
    {
        ////call retrieve Lifts
 //?       [self retrieveLiftsPassenger];
    }
}



@end
