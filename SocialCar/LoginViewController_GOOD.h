//
//  LoginViewController_GOOD.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 19/12/16.
//  Copyright © 2016 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController_GOOD : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *btn_facebook;
@property (strong, nonatomic) IBOutlet UIButton *btn_googlePlus;
@property (strong, nonatomic) IBOutlet UIButton *btn_signUp;

@property (strong, nonatomic) IBOutlet UIView *view_lineLeft;
@property (strong, nonatomic) IBOutlet UILabel *label_OR;

@property (strong, nonatomic) IBOutlet UIView *view_lineRight;
@property (strong, nonatomic) IBOutlet UIStackView *stackview_line;



@property (strong, nonatomic) IBOutlet UILabel *label_alreadyAccount;
- (IBAction)HaveAccount:(id)sender;
- (IBAction)btn_signUp_Touched:(id)sender;

@end
