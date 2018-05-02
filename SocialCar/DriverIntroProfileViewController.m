//
//  DriverIntroProfileViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou(CERTH) on 04/05/17.
//  Copyright © 2017 Kostas Kalogirou(CERTH). All rights reserved.
//

#import "DriverIntroProfileViewController.h"

@interface DriverIntroProfileViewController ()

@end

@implementation DriverIntroProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    sharedProfile = [SharedProfileData sharedObject];
    
    if (sharedProfile.hasCar)
    {
        [self.btn_driver setTitle:NSLocalizedString(@"EDIT DRIVER PROFILE", @"EDIT DRIVER PROFILE") forState:UIControlStateNormal];
    }
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

- (IBAction)btn_become_driver:(id)sender
{
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardDriverProfile"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
