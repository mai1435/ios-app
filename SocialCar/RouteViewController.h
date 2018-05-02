//
//  ViewController.h
//  TableViewSocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 20/02/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareRoutes.h"
#import "CommonData.h"
#import "Car.h"
#import "Driver.h"
#import "MyTools.h"
#import "SharedProfileData.h"
#import "MultipleSelectionTableViewController.h"
#import "ParseObjects.h"


@interface RouteViewController : UIViewController <UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate,NSURLSessionDataDelegate>
{
    SharedProfileData *sharedProfile;
    
    ShareRoutes *sharedRoutes;
    CommonData *commonData;
    MyTools *myTools;
    ParseObjects *parseObjects;
    
    NSURLSessionConfiguration *sessionConfiguration;
    
    UIActivityIndicatorView *indicatorView;

    NSString *txtfield_current_str;
    
    int case_call_API;
    
    
    
   
}

@property (strong, nonatomic) IBOutlet UILabel *label_line_left;
@property (strong, nonatomic) IBOutlet UILabel *label_line_right;
@property (strong, nonatomic) IBOutlet UIButton *btn_invert_addresses;
@property (strong, nonatomic) IBOutlet UILabel *label_origin;
@property (strong, nonatomic) IBOutlet UILabel *label_destination;
@property (strong, nonatomic) IBOutlet UITextField *txtfield_departure;
@property (strong, nonatomic) IBOutlet UITextField *txtfield_preferences;

- (IBAction)btn_invert_addresses_pressed:(id)sender;


@property (strong, nonatomic) IBOutlet UIStackView *stackView_invert_addresses;


@property NSArray *getRoutes;
@property (strong, nonatomic) NSString *parametersForRequest;


@end

