//
//  LoginViewController_GOOD.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 19/12/16.
//  Copyright © 2016 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "LoginViewController_GOOD.h"

@interface LoginViewController_GOOD ()

@end

@implementation LoginViewController_GOOD

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //For btn_signIn_facebook
    self.btn_facebook.layer.borderWidth = 0.8;
    self.btn_facebook.layer.borderColor = UIColor.blackColor.CGColor;
    
    //For btn_signIn_googleplus
    self.btn_googlePlus.layer.borderWidth = 0.8;
    self.btn_googlePlus.layer.borderColor = UIColor.blackColor.CGColor;
    
    //For btn_signUp
    self.btn_signUp.layer.borderWidth = 0.8;
    self.btn_signUp.layer.borderColor = UIColor.blackColor.CGColor;
    
    
 /* //Left Line
#pragma view_lineLeft UIView
    self.view_lineLeft = [self.view_lineLeft initWithFrame:CGRectMake(0, 0, self.view_lineLeft.bounds.size.width, 1)];
    
    self.view_lineLeft.backgroundColor = [UIColor blackColor];
    
    [self.stackview_line addArrangedSubview:self.view_lineLeft];
    
    [self.stackview_line addArrangedSubview:self.label_OR];
    
    //Right Line UIVIew
#pragma view_lineRight UIView
    self.view_lineRight = [self.view_lineRight initWithFrame:CGRectMake(0, 0, self.view_lineRight.bounds.size.width, 1)];
    
    self.view_lineRight.backgroundColor = [UIColor blackColor];
    [self.stackview_line addArrangedSubview:_view_lineRight];
  
   */
    
    
   

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

- (IBAction)HaveAccount:(id)sender {
    
    NSString *message1 = NSLocalizedString(@"Already have account tapped!", @"Already have account tapped!");
    NSLog(@"%@", message1);
    
    
}

- (IBAction)btn_signUp_Touched:(id)sender {
    
    NSLog(@"Sign UP clicked!");
}
@end
