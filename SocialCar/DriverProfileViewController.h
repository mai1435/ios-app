//
//  DriverProfileViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou(CERTH) on 24/04/17.
//  Copyright © 2017 Kostas Kalogirou(CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedDriverProfileData.h"
#import "SharedProfileData.h"
#import "DriverIntroProfileViewController.h"
#import "MyTripsViewController.h"
#import "HomeSegmentsViewController.h"
#import "MyTools.h"
#import "CommonData.h"

@interface DriverProfileViewController : UIViewController <UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, NSURLSessionDataDelegate>
{
    //Keep current UITextField entered
    UITextField *txtfield_current;
    
    SharedProfileData *sharedProfile;
    SharedDriverProfileData *sharedDriverProfile;
    
    //Indicator showing the progress
    UIActivityIndicatorView *indicatorView;
    
    MyTools *myTools;
    CommonData *commonData;
    
    int case_call_API;
    
    //Used to see whether car_image changed in order to
    //upload the new image.
    //UIImage *tmp_car_image;
    BOOL picturePicked;
    
    //Used for custom colours
    NSArray *arrayChoices;
    
    //#E1D7D7
    UIColor *car_color_white_gray;
    //color name="car_color_grey">#9E9E9E</color>
    UIColor *car_color_grey;
    
    //color name="car_color_blue_grey">#607D8B</color>
    UIColor *car_color_blue_grey;
    
    //color name="car_color_black">#212121</color>
    UIColor *car_color_black;
    //color name="car_color_yellow">#FFEB3B</color>
    UIColor *car_color_yellow;
    //color name="car_color_orange">#FF9800</color>
    UIColor *car_color_orange;
    //color name="car_color_red">#F44336</color>
    UIColor *car_color_red;
    
    //color name="car_color_brown">#795548</color>
    UIColor *car_color_brown;
    
    //color name="car_color_pink">#F06292</color>
    UIColor *car_color_pink;
    
    //color name="car_color_purple">#9C27B0</color>
    UIColor *car_color_purple;
    // "car_color_blue">#3F51B5</color>
    UIColor *car_color_blue;
    
    //color name="car_color_green">#4CAF50</color>
    UIColor *car_color_green;
    //  UIColor *pinkColorDark = [UIColor colorWithRed: 255.0/255.0 green:105.0/255.0 blue: 180.0/255.0 alpha:1];
    
    // UIColor *pinkColorLight = [UIColor colorWithRed: 255.0/255.0 green:182.0/255.0 blue: 193.0/255.0 alpha:1];
    
    //UIColor *pinkColor = [UIColor colorWithRed: 255.0/255.0 green:192.0/255.0 blue: 203.0/255.0 alpha:1];
    
    // NSArray *colourArray = [[NSArray alloc] initWithObjects:[UIColor whiteColor],[UIColor lightGrayColor],[UIColor darkGrayColor],[UIColor grayColor], [UIColor blackColor],[UIColor yellowColor], [UIColor orangeColor], [UIColor redColor],[UIColor brownColor],pinkColorDark, [UIColor purpleColor], [UIColor blueColor],[UIColor greenColor],nil];
    
    
    NSArray *imagesNameArray;
    
    NSArray *colourCustomArray;
    
  //  BOOL picturePicked;
    
    
    NSURLSessionConfiguration *sessionConfiguration;
    NSURLSession *sessionRequest;
    
    NSData *authData;
    NSString *authValue;
    NSString *authStr;
    NSURLCredential *newCredential;


}

@property (strong, nonatomic) IBOutlet UIView *view_white;

@property (strong, nonatomic) IBOutlet UIImageView *image_photo;

//Car info line
@property (strong, nonatomic) IBOutlet UIView *view_car_info_line_left;

@property (strong, nonatomic) IBOutlet UILabel *label_car_info;

@property (strong, nonatomic) IBOutlet UIView *view_car_info_line_right;

//@property (strong, nonatomic) IBOutlet UILabel *label_login_line_left;

//@property (strong, nonatomic) IBOutlet UILabel *label_login_line_right;

@property (strong, nonatomic) IBOutlet UIStackView *stackview_car_info;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_model;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_car_plate;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_colour;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_seats;

@property (strong, nonatomic) IBOutlet UIButton *btn_register;

//Additionial info line
@property (strong, nonatomic) IBOutlet UIView *view_additional_info_line_left;

@property (strong, nonatomic) IBOutlet UIView *view_additional_info_line_right;

@property (strong, nonatomic) IBOutlet UILabel *label_additional_info;

@property (strong, nonatomic) IBOutlet UIStackView *stackview_additional_info;

//Car photo line
@property (strong, nonatomic) IBOutlet UIView *view_car_photo_line_left;

@property (strong, nonatomic) IBOutlet UIView *view_car_photo_line_right;

@property (strong, nonatomic) IBOutlet UILabel *label_car_photo;

@property (strong, nonatomic) IBOutlet UIStackView *stackview_car_photo;


@property (strong, nonatomic) IBOutlet UITextField *txtfield_food;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_smoking;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_airconditiong;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_pets;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_luggage;


@property (strong, nonatomic) IBOutlet UITextField *txtfield_childseat;

@property (strong, nonatomic) IBOutlet UITextField *txtfield_music;


@property (nonatomic) BOOL areTextFieldsEditable;

//- (IBAction)cameraTouched:(id)sender;

- (IBAction)carPhotoTouched:(id)sender;


//Checking if camere is available
//- (void) isCameraAvailable;

//- (BOOL)txtfield_password_OnTouch;

- (void) setStyleForImageRectangle: (UIImageView *) imageView;

- (UITextField *) textfieldWithIcon: (NSString *)iconName  withTextField:(UITextField *) txtField;

- (IBAction)btn_Register_pressed:(id)sender;

@end
