//
//  LaunchFirstTimeViewController.m
//  SocialCar
//
//  Created by Nikolaos Dimokas (CERTH)  on 04/08/17.
//  Copyright © 2017 Nikolaos Dimokas (CERTH) . All rights reserved.
//

#import "LaunchFirstTimeViewController.h"

@interface LaunchFirstTimeViewController ()

@end

@implementation LaunchFirstTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)btn_decline_pressed:(id)sender
{
    
    //Keep it NO
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"TermsAccepted"];
    
    NSString *title = NSLocalizedString(@"Decline Terms&Conditions", @"Decline Terms&Conditions");
    
    NSString *message = NSLocalizedString(@"Please, close application!", @"Please, close application");
    
    [self alertCustom:title andMessage:message];
  //  [self dismissViewControllerAnimated:YES completion:nil];
    //exit(0);
}

- (IBAction)btn_accept_pressed:(id)sender
{
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TermsAccepted"];
    
    /* Writes any modifications to the persistent domains to disk and updates all unmodified persistent domains to what is on disk.
    
       Because this method is automatically invoked at periodic intervals, use this method only if you cannot wait for the automatic synchronization (for example, if your application is about to exit) or if you want to update the user defaults to what is on disk even though you have not made any changes.
     */
     [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - alertCustom
-(void) alertCustom : (NSString *)title andMessage:(NSString *)message
{
    NSString *ok = NSLocalizedString(@"OK", @"OK");
    
    UIAlertController *alertMessage = [UIAlertController
                                                   alertControllerWithTitle:title
                                                   message:message
                                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:ok
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [alertMessage dismissViewControllerAnimated:YES completion:nil];
                                   
                                   
                               }];
    [alertMessage addAction:okAction];
    [self presentViewController:alertMessage animated:NO completion:nil];
}

@end
