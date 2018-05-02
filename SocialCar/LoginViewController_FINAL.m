	//
//  LoginViewController_FINAL.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 13/01/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "LoginViewController_FINAL.h"

@interface LoginViewController_FINAL () <SFSafariViewControllerDelegate>

@end

//BOOL loginFacebook;

@implementation LoginViewController_FINAL

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Initialise singleton
    sharedProfile = [SharedProfileData sharedObject];
    sharedDriverProfile = [SharedDriverProfileData sharedObject];
    
    commonData = [[CommonData alloc]init];
    [commonData initWithValues];
    
 /*
    //Use FaceBook button
    
    //Add Facebook Login to Your Code
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    loginButton.center = self.view.center;
   
    //[loginButton setFrame:CGRectMake(self.btn_faceBook_custom.bounds.origin.x, self.btn_faceBook_custom.bounds.origin.y,                                     self.btn_faceBook_custom.bounds.size.width,selfbtn_faceBook_custom.bounds.size.height)];
    
    
    loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
   [self.view addSubview:loginButton];
//    [self.stackViewChoicesLogin addArrangedSubview:self.loginButton];
    
    
    if ([FBSDKAccessToken currentAccessToken])
    {
        // User  logged in, do work such as go to next view controller.
        NSLog(@"User with id=%@ is already logged in!",[FBSDKAccessToken currentAccessToken] );
        
        //Go to next screen and make it root View Controller after
        //succesful sign in.
        MenuTabBarController *menuTabBarController = (MenuTabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"menuTabStoryboard"];
        
        //UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:menuTabBarController];
        //if the window has an existing view hierarchy, the old views are removed before the new ones are installed.
         
 
 
        self.view.window.rootViewController = menuTabBarController;
        [self.view.window makeKeyAndVisible];
  
    }
*/
    
    
    
    //Left Line
#pragma view_lineLeft UIView
    
    self.viewLineLeft = [self.viewLineLeft initWithFrame:CGRectMake(0, 0, self.viewLineLeft.bounds.size.width, 1)];
    
    self.viewLineLeft.backgroundColor = [UIColor grayColor];
    
    [self.stackViewOR addArrangedSubview:self.viewLineLeft];// addSubview:self.view_lineLeft];
    
    //[self.view addSubview:self.view_social];

#pragma label_social UILabel
    [self.stackViewOR addArrangedSubview:self.labelOR];//
    
    //Right Line
#pragma view_lineRight UIView
    self.viewLineRight = [self.viewLineRight initWithFrame:CGRectMake(0, 0, self.viewLineRight.bounds.size.width, 1)];
    
    self.viewLineRight.backgroundColor = [UIColor grayColor];
    
    [self.stackViewOR addArrangedSubview:self.viewLineRight];

    //Instantiate FBSDKLoginManager
    self.fbSDKLogin = [[FBSDKLoginManager alloc] init];
 
 //   if (loginFacebook)
    //User already logged in
    if ([FBSDKAccessToken currentAccessToken])
    {
        //loginFacebook = NO;
        sharedProfile.useFacebook = NO;
        
        [self.fbSDKLogin logOut];
        [self.btn_facebook setTitle:NSLocalizedString(@"Sign in with Facebook",@"Sign in with Facebook") forState:UIControlStateNormal];
        
        NSLog(@"User Logout");
       // NSLog(@"User with id=%@ is logged out!",[FBSDKAccessToken currentAccessToken]);
    }
    
    //Google Sign In delegate
    [GIDSignIn sharedInstance].uiDelegate = self;
    
    // Uncomment to automatically sign in the user.
    //[[GIDSignIn sharedInstance] signInSilently];
  
    
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



//Not used
/*- (IBAction)btn_SignUp_pressed:(id)sender
{

    SignUpViewController *signUpVC = (SignUpViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"signUpStoryboard"];
        
    [self.navigationController pushViewController:signUpVC animated:YES];
    
}
*/

- (IBAction)btn_googleplus_pressed:(id)sender
{
    if (!sharedProfile.useGoogle)
    {
       // if (!sharedProfile.userGoogleNil)
        //{
            [[GIDSignIn sharedInstance] signIn];
    
        //if ([ [GIDSignIn sharedInstance] currentUser] )
        //{
  //?          [self.btn_google setTitle:NSLocalizedString(@"Logout",@"Logout") forState:UIControlStateNormal];
        //}
        //else
        //{
          //  [self.btn_google setTitle:NSLocalizedString(@"Sign in with Google",@"Sign in with Google") forState:UIControlStateNormal];
        //}
       /* }
        else
        {
            sharedProfile.userGoogleNil = NO;
        }*/
    }
    else
    {
       
        [[GIDSignIn sharedInstance] disconnect];
        
        [self.btn_google setTitle:NSLocalizedString(@"Sign in with Google",@"Sign in with Google") forState:UIControlStateNormal];
        
        //Clear sharedProfile object
        sharedProfile.email = @"";
        sharedProfile.user_name = @"";
        sharedProfile.user_image= nil;
        
        NSLog(@"User Google Logout");
    }
    
    
}




//- (IBAction)btn_googleplus_pressed:(id)sender
//{
//    ///Not recommended by Apple' review process.
//    //Use SFSafariViewController instead.
//
//  // Check if GooglePlus app installed on device
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"gplus://plus.google.com/"] options:@{} completionHandler:^(BOOL success)
//     {
//         if (!success)
//         {
//             /////Not recommended by Apple' review process.
//             //Use SFSafariViewController instead.
//             /*[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://plus.google.com/"] options:@{} completionHandler:nil]; */
//             
//             [self displayGooglePlusInBrowser];
//         }
//     }];
// 
//}
//
//- (void)displayGooglePlusInBrowser
//{
//    SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"https://plus.google.com/"] entersReaderIfAvailable:NO];
//    safariVC.delegate = self;
//    [self presentViewController:safariVC animated:NO completion:nil];
//}

- (IBAction)btn_facebook_pressed:(id)sender
{
//    // Check if FB app installed on device
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://"] options:@{} completionHandler:^(BOOL success)
//     {
//         if (!success)
//         {
//             /////Not recommended by Apple' review process.
//             //Use SFSafariViewController instead.
//            /* [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com"] options:@{} completionHandler:nil]; */
//             [self displayFacebookInBrowser];
//         }
//     }];

    //if (!loginFacebook)
    if (!sharedProfile.useFacebook)
    {
     
        //?sharedProfile.useFacebook = YES;
        [self.fbSDKLogin logInWithReadPermissions: @[@"public_profile", @"email",@"user_friends"]
                               fromViewController:self
                                          handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
         {
             if (error)
             {
                 NSLog(@"Process error");
             }
             else if (result.isCancelled)
             {
                 NSLog(@"Cancelled");
               
             }
             else
             {
                 //self.currentUserLoggedIn = [FBSDKAccessToken currentAccessToken];
                 NSLog(@"Logged in");
                 sharedProfile.useFacebook = YES;
                 
                 //loginFacebook = YES;
                 
                 [self.btn_facebook setTitle:NSLocalizedString(@"Logout",@"Logout") forState:UIControlStateNormal];
                 
                 [self findUserFaceBookOrGoogle];
                 
             }
         }];
    }
    else
    {
        //loginFacebook = NO;
        sharedProfile.useFacebook = NO;
        [self.fbSDKLogin logOut];
        
        [self.btn_facebook setTitle:NSLocalizedString(@"Sign in with Facebook",@"Sign in with Facebook") forState:UIControlStateNormal];
        
        //Clear sharedProfile object
        sharedProfile.email = @"";
        sharedProfile.user_name = @"";
        sharedProfile.gender = @"";
        sharedProfile.user_image= nil;
        sharedProfile.useFacebook = NO;
        
        NSLog(@"User Logout");
        
    }
 
    
}

- (void)displayFacebookInBrowser
{
    SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"*"] entersReaderIfAvailable:NO];
    safariVC.delegate = self;
    [self presentViewController:safariVC animated:NO completion:nil];
}



#pragma mark - Check whether Google or Facebook user exists in SocialCar
- (void) findUserFaceBookOrGoogle
{
    
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
    else if (sharedProfile.useFacebook)
    {
        NSLog(@"Current Facebook tokenID = %@",[[FBSDKAccessToken currentAccessToken] tokenString]);
        NSLog(@"Current Facebook useId = %@",[[FBSDKAccessToken currentAccessToken] userID]);
        
        sharedProfile.facebook_tokenID = [ [FBSDKAccessToken currentAccessToken] tokenString];
        
        sharedProfile.facebook_userID = [ [FBSDKAccessToken currentAccessToken] userID];
        
        ulrStr = [ulrStr stringByAppendingString:sharedProfile.facebook_userID];
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
                                            //Enter to ProfileViewController and fill fields with FaceBook values
                                          [self retrieveUserDataFromFacebook];
                                          
                                      }
                                      else
                                      {
                                       
                                          //Go to SignInViewController; user is already registered with his/her Facebook account
                                          [self fill_userProfile:usersArray[0]];
                                          
                                      }
                                     
                                  }];
    [task resume];
    
}

#pragma mark - Retrieve data after signing in with Facebook

#pragma mark - Fill Facebook values for registration process
-(void) retrieveUserDataFromFacebook
{
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"/me?fields=id,name,email,gender,picture"
                                  parameters:nil
                                  HTTPMethod:@"GET"];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
     {
         // Handle the result
         //NSLog(@"result = %@",result);
         
         NSDictionary *name = [result valueForKey:@"name"];
         NSLog(@"name = %@", name);
         //Convert NSDictionary to string
         sharedProfile.user_name = [NSString stringWithFormat:@"%@",name];
         
         NSDictionary *email = [result valueForKey:@"email"];
         NSLog(@"email = %@", email);
         sharedProfile.email = [NSString stringWithFormat:@"%@",email];
         
         NSDictionary *gender = [result valueForKey:@"gender"];
         NSLog(@"gender = %@", gender);
         NSString *genderStr =[NSString stringWithFormat:@"%@",gender];
         //Convert to UpperCase considering localised
         sharedProfile.gender = [genderStr localizedUppercaseString];
         
         NSDictionary *picture = [result valueForKey:@"picture"];
         NSLog(@"picture = %@", picture);
         
         NSDictionary *picture_data = [picture valueForKey:@"data"];
         NSLog(@"picture_data = %@", picture_data);
         
         NSDictionary *picture_url = [picture_data valueForKey:@"url"];
         NSString *picture_urlStr =[NSString stringWithFormat:@"%@",picture_url];
         NSLog(@"picture_urlStr = %@", picture_urlStr);
         
         
         //You have to upload picture
         NSURL *imageURL = [NSURL URLWithString:picture_urlStr];
         NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
         UIImage *image = [UIImage imageWithData:imageData];
         sharedProfile.user_image = image;
         
         /* NSDictionary *birthday = [result valueForKey:@"birthday"];
          NSLog(@"birthday = %@", birthday);
          sharedProfile.dateofBirth = [NSString stringWithFormat:@"%@",birthday];*/
         
         dispatch_async(dispatch_get_main_queue(), ^{
         //Go to Profile registration segue using navigationController
 //?            [self.navigationController performSegueWithIdentifier:@"SegueToProfileViewControllerRegister" sender:self];
             [self.navigationController performSegueWithIdentifier:@"SegueToProfileViewControllerRegisterLIMIT" sender:self];
             
         });
     }];

}



#pragma mark - Fill user profile values for enterimng to application
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
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController performSegueWithIdentifier:@"segueToSignInViewController" sender:self];
    });
}



@end
