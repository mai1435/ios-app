//
//  SignInOrSignUpViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH)  on 06/09/17.
//  Copyright © 2017 CERTH. All rights reserved.
//

#import "SignInOrSignUpViewController.h"

@interface SignInOrSignUpViewController ()

@end

@implementation SignInOrSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Check if user aleady logged in with NSUserDefaults
    /*NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *savedUsername = [prefs stringForKey:@"userName"];
    NSString *savedPassword = [prefs stringForKey:@"password"];
    */
  
    //Check if user aleady logged in with KeychainItemWrapper
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"RideMyRouteLoginData" accessGroup:nil];
    
    NSString *savedUsername = [keychain objectForKey:(id)kSecAttrAccount];
  //  NSString *savedPassword = [keychain objectForKey:(id)kSecValueData];
    
    NSData *passwordData = [keychain objectForKey:(id)kSecValueData];
    NSString *passwordString = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
   
    
    //if ( (savedUsername !=nil) && (savedPassword != nil) ) //For NSUserDeafults
    if ( (![savedUsername isEqualToString:@""]) && (![passwordString isEqualToString:@""]) ) //For KeychainItemWrapper
    {
        sharedProfile = [SharedProfileData sharedObject];
        
        sharedProfile.alreadyloggeIn = YES;
        sharedProfile.email = savedUsername;
        sharedProfile.password =  passwordString;
        
        [self.navigationController performSegueWithIdentifier:@"segueToSignInViewController" sender:self];
    }
    
    
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

}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
//	[[self navigationController] setNavigationBarHidden:YES animated:NO];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage new]
												  forBarMetrics:UIBarMetricsDefault]; //UIImageNamed:@"transparent.png"
	self.navigationController.navigationBar.shadowImage = [UIImage new];////UIImageNamed:@"transparent.png"
	self.navigationController.navigationBar.translucent = YES;
	self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
	self.navigationController.view.backgroundColor = [UIColor clearColor];
}

- (IBAction)btn_SignUp_pressed:(id)sender {
    //    [self.navigationController performSegueWithIdentifier:@"showSocialSeque" sender:self];
    
    SignUpViewController *signUpVC = (SignUpViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"signUpStoryboard_new"];
    
    [self.navigationController pushViewController:signUpVC animated:YES];
    
    
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

@end
