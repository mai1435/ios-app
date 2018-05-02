//
//  DriverIntroProfileViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou(CERTH) on 04/05/17.
//  Copyright © 2017 Kostas Kalogirou(CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedProfileData.h"

@interface DriverIntroProfileViewController : UIViewController
{
    SharedProfileData *sharedProfile;
}
@property (strong, nonatomic) IBOutlet UILabel *label_intro;
@property (strong, nonatomic) IBOutlet UIButton *btn_driver;
- (IBAction)btn_become_driver:(id)sender;

@end
