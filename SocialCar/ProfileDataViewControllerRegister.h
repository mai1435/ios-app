//
//  ProfileDataViewControllerTabItem.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 13/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SharedProfileData.h"
#import "MyTools.h"
#import "CommonData.h"
#import "MultipleSelectionTableViewController.h"
#import "MenuTabBarController.h"

//UITextFieldDelegate for all textfields
@interface ProfileDataViewControllerRegister : UIViewController <UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,NSURLSessionDataDelegate>
{
 
    UIDatePicker *datepicker;
    
    SharedProfileData *sharedProfile;
    
    MyTools *myTools;
    
    CommonData *commonData;
    
    //Keep current UITextField entered
    UITextField *txtfield_current;
    //Keep current UITextField entered as string value
    NSString *txtfield_current_str;
    
    //Indicator showing the progress
    UIActivityIndicatorView *indicatorView;
    
    int case_call_API;
    
    NSURLSession *sessionRequest;
    
    BOOL goBackToRootViewController;
    BOOL pickedImage; //if user picked image
}


@property (strong, nonatomic) IBOutlet UIView *view_white;

@property (strong, nonatomic) IBOutlet UIImageView *image_photo;
@property (strong, nonatomic) IBOutlet UIImageView *image_edit;

@property (strong, nonatomic) IBOutlet UILabel *label_add_photo;

@property (strong, nonatomic) IBOutlet UILabel *label_login_line_left;

@property (strong, nonatomic) IBOutlet UILabel *label_login_line_right;

@property (strong, nonatomic) IBOutlet UILabel *label_login_info;

@property (strong, nonatomic) IBOutlet UIStackView *stackview_login_info;


@property (strong, nonatomic) IBOutlet UITextField *txtfield_email;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_password;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_name;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_phone;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_dateOfBirth;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_gender;

@property (strong, nonatomic) IBOutlet UIButton *btn_register;


@property (strong, nonatomic) IBOutlet UIView *view_other_info_line_left;
@property (strong, nonatomic) IBOutlet UIView *view_other_info_line_right;
@property (strong, nonatomic) IBOutlet UILabel *label_other_info;
@property (strong, nonatomic) IBOutlet UIStackView *stackview_other_info;

//Optional - Date of birth and gender
@property (strong, nonatomic) IBOutlet UIView *view_optional_line_left;
@property (strong, nonatomic) IBOutlet UILabel *label_optional;
@property (strong, nonatomic) IBOutlet UIView *view_optional_right_line;

@property (strong, nonatomic) IBOutlet UIStackView *stack_view_optional;

//Travel preferences
@property (strong, nonatomic) IBOutlet UIView *view_travel_info_line_left;

@property (strong, nonatomic) IBOutlet UIView *view_travel_info_line_right;

@property (strong, nonatomic) IBOutlet UILabel *label_travel_info;

@property (strong, nonatomic) IBOutlet UIStackView *stackview_travel_info;


@property (strong, nonatomic) IBOutlet UITextField *txtfield_max_no_transfers;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_max_cost;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_max_distance;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_gps_tracking;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_travel_modes;


@property (strong, nonatomic) IBOutlet UITextField *txtfield_optimise_travel;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_carpooler_gender;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_carpooler_age;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_special_needs;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_pets;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_music;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_smoking;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_food;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_luggage;

//@property (nonatomic) BOOL areTextFieldsEditable;

- (IBAction)cameraTouched:(id)sender;

- (IBAction)viewTouched:(id)sender;

//Checking if camere is available
- (void) isCameraAvailable;

- (BOOL)txtfield_password_OnTouch;

- (void) setStyleForImageCirle: (UIImageView *) imageView;

- (UITextField *) textfieldWithIcon: (NSString *)iconName  withTextField:(UITextField *) txtField;

- (IBAction)btn_Register_pressed:(id)sender;

@end

