//
//  MyTools.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 23/01/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "MyTools.h"


@interface MyTools()

@end

@implementation MyTools

UIActivityIndicatorView *indicator;

/*
This method adds icon to a textfiled
*/
-(UITextField *) textfieldWithIcon: (NSString *)iconName  withTextField:(UITextField *) txtField
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    
    imageView.frame = CGRectMake(imageView.frame.origin.x,imageView.frame.origin.y,imageView.frame.size.width +10, imageView.frame.size.height);
    imageView.contentMode = UIViewContentModeCenter;
    
    txtField.leftViewMode = UITextFieldViewModeAlways;
    
    txtField.leftView = imageView;
    
    return txtField;
}

- (UITextField *) textfieldWithIconRight: (NSString *)iconName  withTextField:(UITextField *) txtField
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    
    imageView.frame = CGRectMake(imageView.frame.origin.x,imageView.frame.origin.y,imageView.frame.size.width +10, imageView.frame.size.height);
    imageView.contentMode = UIViewContentModeCenter;
    
    txtField.rightViewMode = UITextFieldViewModeAlways;
    
    txtField.rightView = imageView;
    
    return txtField;
}

#pragma mark - init UIActivityIndicatorView
- (UIActivityIndicatorView *) setActivityIndicator: (UIViewController *)viewContoller
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
	indicator.backgroundColor = [UIColor whiteColor];
    indicator.center = viewContoller.view.center;
    
    [viewContoller.view addSubview:indicator];
    
    [indicator bringSubviewToFront:viewContoller.view];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    return indicator;
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    //?NSString *stricterFilterString = @"^[A-Z0-9a-z.]@([A-Za-z0-9-].)[A-Za-z]{2,4}$";
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    //?NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
   
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
  
    if ([checkString containsString:@"+"])
    {
        return NO;
    }
    return [emailTest evaluateWithObject:checkString];
}

#pragma mark - Convert dictionary to JSON string
//Convert dictionary to JSON string
-(NSString *)dictionaryToJSONString:(NSDictionary *)dict
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    
    //data is not null-terminated, you should use -initWithData:encoding:
    NSString* strFromData = [[NSString alloc] initWithData:jsonData
                                                  encoding:NSUTF8StringEncoding];
    //OR with bytes
    //return  [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    
    return strFromData;
}

#pragma mark - Convert Yes/No to true/false
- (NSString *) from_Yes_No_to_TrueFalse : (NSString *)valueStr
{
    NSString *true_false = @"false";
    
    if ( [valueStr isEqualToString:@"Yes"] )
    {
        true_false = @"true";
    }
    
    return true_false;
}

#pragma convert localized MALE/FEMALE to MALE/FEMALE
-(NSString *)localized_male_femal_to_male_female : (NSString *)valueStr
{
    NSString *male_female;
    
    if ( [valueStr isEqualToString:NSLocalizedString(@"MALE",@"MALE") ] )
    {
        male_female = @"MALE";
    }
    else
    {
        male_female = @"FEMALE";
    }
    
    return male_female;
}

#pragma convert MALE/FEMALE to localized MALE/FEMALE
-(NSString *) male_female_to_localized_male_female : (NSString *)valueStr
{
    NSString *localized_male_female;
    
    if ( [valueStr isEqualToString:@"MALE" ] )
    {
        localized_male_female = NSLocalizedString(@"MALE",@"MALE");
    }
    else
    {
        localized_male_female = NSLocalizedString(@"FEMALE",@"FEMALE");
    }
    
    return localized_male_female;
}

#pragma mark - Convert Yes/No to true/false Number
- (NSNumber *) from_Yes_No_to_TrueFalse_Number : (NSString *)valueStr
{
    NSNumber *true_false=[NSNumber numberWithBool:NO];
    
    //if ( [valueStr isEqualToString:@"Yes"] )
    if ( [valueStr isEqualToString:NSLocalizedString(@"Yes", @"Yes") ] )
    {
        true_false = [NSNumber numberWithBool:YES];
    }
    else
    {
        true_false = [NSNumber numberWithBool:NO];
    }
    
    
    return true_false;
}

#pragma mark - Convert Float to String
-(NSString *) convertFloatToString:(NSNumber*) floatNumber
{
    //  NSNumber *yourFloatNumber = [yourArray objectAtIndex:0]
    float yourFloat = [floatNumber floatValue];
    
    NSString *strValue = [NSString stringWithFormat:@"%f", yourFloat];
    
    return strValue;
}

#pragma mark - Convert date string into dd/MM/YYYY formatted string
-(NSString *) convertTimeStampToString:(NSString *)dateString
{
    // Convert string to date object
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/YYYY"];
    //Convert Stiring into timestamp and format it to the "dd/MM/YYYY"
    NSTimeInterval _interval=[dateString longLongValue];
    NSDate *dateStr	 = [NSDate dateWithTimeIntervalSince1970:_interval];

    NSString *stringDate = [formatter stringFromDate:dateStr];
    
    return stringDate;
}

#pragma mark - Convert date string into dd/MM/YYYY formatted string
-(NSString *) convertTimeStampToStringWithFormatDetailed:(NSString *)dateString
{
    // Convert string to date object
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/YYYY"];
    //Convert String into timestamp and format it to the "dd/MM/YYYY"
    NSTimeInterval _interval=[dateString longLongValue];
    NSDate *dateStr	 = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    [formatter setDateFormat:@"EEE dd MMM yyyy  HH:mm"];
    NSString *stringDate = [formatter stringFromDate:dateStr];
    
    return stringDate;
}


#pragma mark - Convert date string into dd/MM/YYYY HH:mm formatted string
-(NSString *) convertTimeStampToStringWithDateAndTime:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    [formatter setDateFormat:@"dd/MM/YYYY HH:mm"];
    
    //Convert String into timestamp and format it to the "dd/MM/YYYY"
    NSTimeInterval _interval=[dateString longLongValue];
    NSDate *dateStr	 = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    NSString *stringDate = [formatter stringFromDate:dateStr];
    
    return stringDate;
  
}

#pragma mark - Convert date string into EEE dd MMM yyyy HH:mm" formatted string e.g. Mon 24 Jul 2017
-(NSString *) convertTimeStampToStringWithFormat:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    //[formatter setDateFormat:@"yyyy-MM-dd HH:mm"];//dd/MM/YYYY hh:min"];//"YYYY-MM-dd hh:min"];//dd-MM-YYYY"];

    [formatter setDateFormat:@"dd/MM/YYYY HH:mm"];

    // converting into our required date format
    //[formatter setDateFormat:@"EEEE, MMMM dd, yyyy  HH:mm"];

    [formatter setDateFormat:@"EEE dd MMM yyyy  HH:mm"];
    NSString *reqDateString = [formatter stringFromDate:date];
    
    //NSLog(@"date is %@", reqDateString);

    //NSString *getDateTime = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    
    return reqDateString;
}

#pragma mark - Set datepciker min and max
-(void)datePickerMinAndMaxDates:(UIDatePicker *) datePicker
{
     
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:-18];
    NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    [comps setYear:-100];
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
    
    //The maximum date that a date picker can show.
    [datePicker setMaximumDate:maxDate];
    //The minimum date that a date picker can show.
    [datePicker setMinimumDate:minDate];
}



//Table data for luggage type

#pragma mark - Convert luggage type to back-end values
-(NSString *)localized_luggageType_to_luggageType : (NSString *)localisedValue
{
    //NSMutableArray *englishValues= [[NSMutableArray alloc]init];
    NSString *englishValue;
    
    NSArray *arrayStandardValues =  [NSArray arrayWithObjects:@"SMALL",@"MEDIUM",@"LARGE",@"NO", nil];
    
    NSString *small = NSLocalizedString(@"SMALL", @"SMALL");
    NSString *medium = NSLocalizedString(@"MEDIUM", @"MEDIUM");
    NSString *large = NSLocalizedString(@"LARGE", @"LARGE");
    NSString *no = NSLocalizedString(@"NO", @"NO");
    
    NSArray *arrayLocalisedValues = [NSArray arrayWithObjects:small,medium,large,no, nil];
    
    for (int i=0;i<arrayLocalisedValues.count;i++)
    {
        if ([arrayLocalisedValues[i] isEqualToString:localisedValue])
        {
            // [englishValues addObject:arrayStandardValues[i]];
            englishValue = arrayStandardValues[i];
            break;
        }
    
    }

    return englishValue;

}


//Table Data for Special Needs
#pragma mark - Convert special needs to back-end values
-(NSMutableArray *)localized_specialNeeds_to_specialNeeds : (NSArray *)localisedValues
{
    NSMutableArray *englishValues= [[NSMutableArray alloc]init];
    
    NSArray *arrayStandardValues =  [NSArray arrayWithObjects:@"WHEELCHAIR",@"DEAF",@"BLIND",@"ELDERLY", nil];
    
    NSString *wheelchair = NSLocalizedString(@"WHEELCHAIR", @"WHEELCHAIR");
    NSString *deaf = NSLocalizedString(@"DEAF", @"DEAF");
    NSString *blind = NSLocalizedString(@"BLIND", @"BLIND");
    NSString *elderly = NSLocalizedString(@"ELDERLY", @"ELDERLY");
    
    NSArray *arrayLocalisedValues = [NSArray arrayWithObjects:wheelchair,deaf,blind,elderly, nil];
    
    for (int i=0;i<arrayLocalisedValues.count;i++)
    {
        for (int j=0;j<localisedValues.count;j++)
        {
            if ([arrayLocalisedValues[i] isEqualToString:localisedValues[j]])
            {
                [englishValues addObject:arrayStandardValues[i]];
            }
        }
    }
    
    return englishValues;
    
}

#pragma mark - Convert Travel modes with back-end values
-(NSMutableArray *)localized_travelModes_to_travelModes : (NSArray *)localisedValues
{
    NSMutableArray *englishValues= [[NSMutableArray alloc]init];
    
    NSArray *arrayStandardValues =  [NSArray arrayWithObjects:@"BUS",@"CAR_POOLING",@"FEET",@"METRO",@"RAIL",@"TRAM", nil];
    
    NSString *bus = NSLocalizedString(@"BUS", @"BUS");
    NSString *car_pooling = NSLocalizedString(@"CAR_POOLING", @"CAR_POOLING");
    NSString *feet = NSLocalizedString(@"FEET", @"FEET");
    NSString *metro = NSLocalizedString(@"METRO", @"METRO");
    NSString *rail = NSLocalizedString(@"RAIL", @"RAIL");
    NSString *tram = NSLocalizedString(@"TRAM", @"TRAM");
    
    NSArray *arrayLocalisedValues = [NSArray arrayWithObjects:bus,car_pooling,feet,metro,rail,tram,nil];
    
    for (int i=0;i<arrayLocalisedValues.count;i++)
    {
        for (int j=0;j<localisedValues.count;j++)
        {
            if ([arrayLocalisedValues[i] isEqualToString:localisedValues[j]])
            {
                [englishValues addObject:arrayStandardValues[i]];
            }
        }
    }
    
    return englishValues;
    
}

#pragma mark - Convert Optimise solutions with back-end values
-(NSMutableArray *)localized_optimisedSolutions_to_optimisedSolutions : (NSArray *)localisedValues
{
    NSMutableArray *englishValues= [[NSMutableArray alloc]init];
   
    NSArray *arrayStandardValues =  [NSArray arrayWithObjects:@"CHEAPEST",@"COMFORT",@"FASTEST",@"SAFEST",@"SHORTEST", nil];
    
    NSString *cheapest = NSLocalizedString(@"CHEAPEST", @"CHEAPEST");
    NSString *comfort = NSLocalizedString(@"COMFORT", @"COMFORT");
    NSString *fastest = NSLocalizedString(@"FASTEST", @"FASTEST");
    NSString *safest = NSLocalizedString(@"SAFEST", @"SAFEST");
    NSString *shortest = NSLocalizedString(@"SHORTEST", @"SHORTEST");
    NSArray *arrayLocalisedValues =  [NSArray arrayWithObjects:cheapest,comfort,fastest,safest,shortest, nil];
    
    for (int i=0;i<arrayLocalisedValues.count;i++)
    {
        for (int j=0;j<localisedValues.count;j++)
        {
            if ([arrayLocalisedValues[i] isEqualToString:localisedValues[j]])
            {
                [englishValues addObject:arrayStandardValues[i]];
            }
        }
    }
    
    
    return englishValues;

}

-(void)hideNavigationControllerRelativeBar : (UINavigationController *)nc
{
	[nc setNavigationBarHidden:YES animated:NO];
	return;
}

-(void)showNavigationControllerRelativeBar : (UINavigationController *)nc
{
	[nc setNavigationBarHidden:NO animated:NO];
	return;
}
/*
#pragma convert MALE/FEMALE to localized MALE/FEMALE
-(NSString *) male_female_to_localized_male_female : (NSString *)valueStr
{
    NSString *localized_male_female;
    
    if ( [valueStr isEqualToString:@"MALE" ] )
    {
        localized_male_female = NSLocalizedString(@"MALE",@"MALE");
    }
    else
    {
        localized_male_female = NSLocalizedString(@"FEMALE",@"FEMALE");
    }
    
    return localized_male_female;
}
*/

@end
