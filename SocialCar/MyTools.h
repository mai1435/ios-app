//
//  MyTools.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 23/01/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Additions.h"

//#ifndef MyTools_h
//#define MyTools_h

// Colors
#define SocialCarPrimaryColor01		[UIColor colorWithHex:@"96145C" andAlpha:0.1f]
#define SocialCarPrimaryColor05		[UIColor colorWithHex:@"96145C" andAlpha:0.5f]

// Utils for models
#define ObjectOrNull(obj) (obj ?: [NSNull null])
#define ObjectOrNil(obj) (obj == [NSNull null] ? nil : obj)
#define ObjectOrEmptyString(obj) (obj ?: @"")
#define RetrieveObj(dict, key) (ObjectOrNil(dict[key]))

typedef enum
{
	DRIVER,
	PASSENGER
} RECEIVER_TYPE;

@interface MyTools : NSObject

- (UITextField *) textfieldWithIcon: (NSString *)iconName  withTextField:(UITextField *) txtField;
- (UITextField *) textfieldWithIconRight: (NSString *)iconName  withTextField:(UITextField *) txtField;

- (UIActivityIndicatorView *) setActivityIndicator:(UIViewController *)viewContoller;

-(BOOL) NSStringIsValidEmail:(NSString *)checkString;

-(NSString *)dictionaryToJSONString:(NSDictionary *)dict;

-(NSString *) localized_male_femal_to_male_female : (NSString *)valueStr;
-(NSString *) male_female_to_localized_male_female : (NSString *)valueStr;

-(NSString *) from_Yes_No_to_TrueFalse : (NSString *)valueStr;
-(NSNumber *) from_Yes_No_to_TrueFalse_Number : (NSString *)valueStr;

-(NSString *) convertFloatToString:(NSNumber*) floatNumber;

-(NSString *) convertTimeStampToString:(NSString *)dateString;
-(NSString *) convertTimeStampToStringWithDateAndTime:(NSString *)dateString;
-(NSString *) convertTimeStampToStringWithFormatDetailed:(NSString *)dateString;


-(NSString *) convertTimeStampToStringWithFormat:(NSDate *)date;

-(void)datePickerMinAndMaxDates:(UIDatePicker *) datePicker;

-(NSMutableArray *)localized_travelModes_to_travelModes : (NSArray *)localisedValues;
-(NSMutableArray *)localized_optimisedSolutions_to_optimisedSolutions : (NSArray *)localisedValues;
-(NSMutableArray *)localized_specialNeeds_to_specialNeeds : (NSArray *)localisedValues;
-(NSString *)localized_luggageType_to_luggageType : (NSString *)localisedValue;

-(void)hideNavigationControllerRelativeBar : (UINavigationController *)nc;
-(void)showNavigationControllerRelativeBar : (UINavigationController *)nc;

//Add obverlay to textfield
//see documentation
/*
 //Listing 1
 //Adding an overlay view to a text field
 UIButton* overlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
 [overlayButton setImage:[UIImage imageNamed:@"bookmark"] forState:UIControlStateNormal];
 [overlayButton addTarget:self action:@selector(displayBookmarks:)
 forControlEvents:UIControlEventTouchUpInside];
 overlayButton = CGRectMake(0, 0, 28, 28);
 
 // Assign the overlay button to a stored text field
 self.textField.leftView = overlayButton;
 self.textField.leftViewMode = UITextFieldViewModeAlways;
 */

@end

//#endif /* MyTools_h */
