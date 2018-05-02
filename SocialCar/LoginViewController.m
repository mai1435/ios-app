//
//  LoginViewController.m
//  MyApp
//
//  Created by Kostas Kalogirou (CERTH) on 25/11/16.
//  Copyright © 2016 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //For btn_signIn_facebook
    self.btn_signIn_facebook.layer.borderWidth = 0.8;
    self.btn_signIn_facebook.layer.borderColor = UIColor.blackColor.CGColor;
    
    //For btn_signIn_googleplus
    self.btn_signIn_googleplus.layer.borderWidth = 0.8;
    self.btn_signIn_googleplus.layer.borderColor = UIColor.blackColor.CGColor;
    
    //For btn_signUp
    self.btn_signUp.layer.borderWidth = 0.8;
    self.btn_signUp.layer.borderColor = UIColor.blackColor.CGColor;
    
    /*UIView *view_line = [[UIView alloc] initWithFrame:CGRectMake(50, 120, self.view.bounds.size.width, 5)];
    view_line.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view_line];*/
    
    //Left Line
    #pragma view_lineLeft UIView
    self.view_lineLeft = [self.view_lineLeft initWithFrame:CGRectMake(0, 0, self.view_lineLeft.bounds.size.width, 0.5)];
    
    self.view_lineLeft.backgroundColor = [UIColor grayColor];
    
    [self.view_line addSubview:self.view_lineLeft];
    
    [self.view addSubview:self.view_line];
    
    //Right Line UIVIew
    #pragma view_lineRight UIView
    self.view_lineRight = [self.view_lineRight initWithFrame:CGRectMake(0, 0, self.view_lineRight.bounds.size.width, 0.5)];
    
    self.view_lineRight.backgroundColor = [UIColor grayColor];
    
    [self.view_line addSubview:self.view_lineRight];
    
    [self.view addSubview:self.view_line];
    
    //Already have an account UIView
    #pragma Already_have_an_account
    
    self.view_lineHaveAccount = [self.view_lineHaveAccount initWithFrame:CGRectMake(0, 0, self.label_haveAccount.text.length, 0.5)];
    
    self.view_lineHaveAccount.backgroundColor = [UIColor whiteColor];
    
    [self.view_haveAccount addSubview:self.view_lineHaveAccount];
    
    ///[[myButton layer] setBorderWidth:2.0f];
    //[[myButton layer] setBorderColor:[UIColor greenColor].CGColor];
    
  /*  [self.btn_signIn_facebook addTarget:self action:@selector(pressButtonSelector:) forControlEvents:UIControlEventTouchUpInside];*/
	

}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[[self navigationController] setNavigationBarHidden:YES animated:NO];
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


- (IBAction)click_buttons:(id)sender {
    
    NSString *message1 = NSLocalizedString(@"Button just pressed!", @"Button just pressed!");
    
    if ([sender isEqual: (self.btn_signIn_facebook) ])
    {
        NSString *message = NSLocalizedString(@"btn_signIn Facebook pressed!", @"btn_signIn Facebook pressed!");
        
        NSLog(@"%@", message);
        
        [self.btn_signIn_facebook setHighlighted:YES];
        //self.btn_signIn_facebook.titleLabel.text = message1;
        
        [self.btn_signIn_facebook setTitle:message1 forState: UIControlStateHighlighted];
    }
    else if ([sender isEqual:(self.btn_signIn_googleplus)])
    {
        
        NSString *message_highlighted = NSLocalizedString(@"highlighted!", @"highlighted!");
        
        NSString *message = NSLocalizedString(@"btn_signIn_googleplus pressed!", @"btn_signIn_googleplus pressed!");
        NSLog(@"%@", message);
        
        /*self.btn_signIn_googleplus.backgroundColor = [self.btn_signIn_googleplus setBackgroundColor:[UIColor blueColor]  forState:UIControlStateHighlighted];
        */
        
        [self.btn_signIn_googleplus setHighlighted:YES];

        [self.btn_signIn_googleplus setTitle: message_highlighted forState: UIControlStateHighlighted];

        [self.btn_signIn_googleplus setBackgroundColor:[UIColor yellowColor]];
        [self.btn_signIn_googleplus setBackgroundColor:[UIColor grayColor]];
        
        //[self.btn_signIn_googleplus setSelected:YES];
        //[self.btn_signIn_googleplus setTitle: message_selected forState: UIControlStateSelected];
        
        
       /* [self.btn_signIn_googleplus.backgroundColor setBackgroundImage:[self.btn_signIn_googleplus.backgroundColor imageWithColor:[UIColor greenColor]] forState:UIControlStateHighlighted];
        */
     /*[_btn_signIn_googleplus setBackgroundColor:[self backgroungColor:[UIColor greenColor]] forState:UIControlStateHighlighted];
       */
    }
    else if ([sender isEqual:(self.btn_signUp)])
    {
         NSString *message = NSLocalizedString(@"btn_signUp pressed!", @"btn_signUp pressed!");
         
         NSLog(@"%@", message);
         
         [self.btn_signUp setHighlighted:YES];
         
         //[self.btn_signUp setTitle:message1 forState: UIControlStateHighlighted];
    }
    
}

//See http://stackoverflow.com/questions/4660371/how-to-add-a-touch-event-to-a-uiview
// at Adding a Gesture in the Interface Builder
- (IBAction)view_onclick:(id)sender {
    
    NSString *message = NSLocalizedString(@"View gesture taped!", @"View gesture taped!");
    NSLog(@"%@", message);

    [self.view_haveAccount setBackgroundColor:[UIColor grayColor]];
}
@end
