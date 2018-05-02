//
//  SignInOrSignUpViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH)  on 06/09/17.
//  Copyright © 2017 CERTH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpViewController.h"
#import "SharedProfileData.h"
#import "KeychainItemWrapper.h"

@interface SignInOrSignUpViewController : UIViewController
{
    SharedProfileData *sharedProfile;
}

@property (strong, nonatomic) IBOutlet UIStackView *stackViewOR;
@property (strong, nonatomic) IBOutlet UIView *viewLineLeft;

@property (strong, nonatomic) IBOutlet UILabel *labelOR;

@property (strong, nonatomic) IBOutlet UIView *viewLineRight;

- (IBAction)btn_SignUp_pressed:(id)sender;


@end
