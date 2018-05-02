//
//  ReportTableViewController.h
//  SocialCar
//
//  Created by Vittorio Tauro on 01/08/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FCAlertView.h"
#import "SharedProfileData.h"
#import "CommonData.h"

@interface ReportTableViewController : UITableViewController <UITextFieldDelegate>{
    SharedProfileData *sharedProfile;
    CommonData *commonData;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageWork;
@property (weak, nonatomic) IBOutlet UIImageView *imageTraffic;
@property (weak, nonatomic) IBOutlet UIImageView *imageAccident;
@property (weak, nonatomic) IBOutlet UIImageView *imageLow;
@property (weak, nonatomic) IBOutlet UIImageView *imageMedium;
@property (weak, nonatomic) IBOutlet UIImageView *imageHigh;
@property (weak, nonatomic) IBOutlet UILabel *labelWork;
@property (weak, nonatomic) IBOutlet UILabel *labelTraffic;
@property (weak, nonatomic) IBOutlet UILabel *labelAccident;
@property (weak, nonatomic) IBOutlet UILabel *labelLow;
@property (weak, nonatomic) IBOutlet UILabel *labelMedium;
@property (weak, nonatomic) IBOutlet UILabel *labelHigh;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFrom;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTo;
@property (weak, nonatomic) IBOutlet UIButton *buttonSend;
@property (nonatomic) BOOL from;



@end
