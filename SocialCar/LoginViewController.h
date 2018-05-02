//
//  LoginViewController.h
//  MyApp
//
//  Created by Kostas Kalogirou (CERTH) on 25/11/16.
//  Copyright © 2016 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btn_signIn_facebook;

@property (weak, nonatomic) IBOutlet UIButton *btn_signIn_googleplus;

@property (weak, nonatomic) IBOutlet UIButton *btn_signUp;

@property (weak, nonatomic) IBOutlet UIView *view_haveAccount;



@property (strong, nonatomic) IBOutlet UIView *view_lineLeft;
@property (strong, nonatomic) IBOutlet UIView *view_lineRight;
@property (strong, nonatomic) IBOutlet UIView *view_line;

@property (strong, nonatomic) IBOutlet UILabel *label_haveAccount;

@property (strong, nonatomic) IBOutlet UIView *view_lineHaveAccount;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapView;

- (IBAction)view_onclick:(id)sender;



@end
