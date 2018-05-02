
//
//  ProfileDataViewControllerTabItem.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 13/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "ProfileDataViewControllerTabItem.h"

@interface ProfileDataViewControllerTabItem ()
//{
//    SharedProfileData *sharedProfile; //private declaration
//}

@end


@implementation ProfileDataViewControllerTabItem



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //Do not allow edit textfields
    self.areTextFieldsEditable = NO;
   
    sharedProfile = [SharedProfileData sharedObject];
    myTools = [[MyTools alloc]init];
    
    commonData = [[CommonData alloc]init];
    [commonData initWithValues];
    
    // Do any additional setup after loading the view.
    
  /*  self.navigationItem.title = self.title;
    NSString *next_str = NSLocalizedString(@"<Back", @"<Back");
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:next_str style:UIBarButtonItemStylePlain
                                                                  target:self action:nil];//@selector(refreshPropertyList)];
    self.navigationItem.leftBarButtonItem = backButton;
    */
    
    //Add border outside to white view
    CGFloat borderWidth = 0.3f;
    
    self.view_white.frame = CGRectInset(self.view_white.frame, -borderWidth, -borderWidth);
    self.view_white.layer.borderColor = [UIColor grayColor].CGColor;
    self.view_white.layer.borderWidth = borderWidth;
    
#pragma login info line left
    self.label_login_line_left = [self.label_login_line_left initWithFrame:CGRectMake(0,0, self.label_login_line_left.bounds.size.width, 1)];
    self.label_login_line_left.backgroundColor = [UIColor grayColor];
    
    [self.stackview_login_info addArrangedSubview:self.label_login_line_left];
    
#pragma label_social UILabel
    [self.stackview_login_info addArrangedSubview:self.label_login_info];
    
    
#pragma login info line right
    self.label_login_line_right = [self.label_login_line_right initWithFrame:CGRectMake(0,0, self.label_login_line_right.bounds.size.width, 1)];
    self.label_login_line_right.backgroundColor = [UIColor grayColor];
    
    [self.stackview_login_info addArrangedSubview:self.label_login_line_right];
    
#pragma other info lines
    self.view_other_info_line_left = [self.view_other_info_line_left initWithFrame:CGRectMake(0, 0, self.view_other_info_line_left.bounds.size.width, 1)];
    
    self.view_other_info_line_left.backgroundColor = [UIColor grayColor];
 
    [self.stackview_other_info addArrangedSubview:self.view_other_info_line_left];
    
#pragma label_social UILabel
    [self.stackview_other_info addArrangedSubview:self.label_other_info];
    
#pragma other info lines
    self.view_other_info_line_right = [self.view_other_info_line_right initWithFrame:CGRectMake(0, 0, self.view_other_info_line_right.bounds.size.width, 1)];
    
    self.view_other_info_line_right.backgroundColor = [UIColor grayColor];
    
    [self.stackview_other_info addArrangedSubview:self.view_other_info_line_right];

#pragma image photo
    [self setStyleForImageCirle:self.image_photo];
    
    //Use it for image without aspect ratio 1:1 (height=width)
    //[self performSelector:@selector(setStyleForImageCirle:) withObject:self.image_photo afterDelay:0];
    
    //Add icon to each textfield
    [self textfieldWithIcon:@"email.png" withTextField:self.txtfield_email];
    [self textfieldWithIcon:@"lock.png" withTextField:self.txtfield_password];
   
    [self textfieldWithIcon:@"face.png" withTextField:self.txtfield_name];
    [self textfieldWithIcon:@"phone.png" withTextField:self.txtfield_phone];
    [self textfieldWithIcon:@"account-box-outline.png" withTextField:self.txtfield_dateOfBirth];
    [self textfieldWithIcon:@"gender.png" withTextField:self.txtfield_gender];
    
    [self textfieldWithIcon:@"star_grey.png" withTextField:self.txtfield_rating];

    //sets all the textfield delegate to the current class
    self.txtfield_email.delegate = self;
    self.txtfield_password.delegate = self;
    self.txtfield_name.delegate = self;
    self.txtfield_phone.delegate = self;
    self.txtfield_dateOfBirth.delegate = self;
    self.txtfield_gender.delegate = self;
    self.txtfield_rating.delegate = self;
    
    self.txtfield_email.text = sharedProfile.email;
    self.txtfield_password.text = sharedProfile.password;
    self.txtfield_name.text = sharedProfile.user_name;
    self.txtfield_phone.text = sharedProfile.phone;
    self.txtfield_dateOfBirth.text = sharedProfile.dateofBirth;
    self.txtfield_gender.text = sharedProfile.gender;
    
    if (sharedProfile.user_image)
    {
        self.label_add_photo.text = @"";
        self.image_photo.image = sharedProfile.user_image;
        [self setStyleForImageCirle:self.image_photo];
        
        tmp_user_image = sharedProfile.user_image;
    }
    

    self.txtfield_rating.text = sharedProfile.rating;
    
#pragma mark new code
#pragma travel prefernces info lines
    self.view_travel_info_line_left = [self.view_travel_info_line_left initWithFrame:CGRectMake(0, 0, self.view_travel_info_line_left.bounds.size.width, 1)];
    
    self.view_travel_info_line_left.backgroundColor = [UIColor grayColor];
    
    [self.stackview_travel_info addArrangedSubview:self.view_travel_info_line_left];
    
#pragma label_social UILabel
    [self.stackview_travel_info addArrangedSubview:self.label_travel_info];
    
#pragma other info lines
    self.view_travel_info_line_right = [self.view_travel_info_line_right initWithFrame:CGRectMake(0, 0, self.view_travel_info_line_right.bounds.size.width, 1)];
    
    self.view_travel_info_line_right.backgroundColor = [UIColor grayColor];
    
    [self.stackview_travel_info addArrangedSubview:self.view_travel_info_line_right];
    
    [self textfieldWithIcon:@"ic_transfer_within_a_station" withTextField:self.txtfield_max_no_transfers];
    [self textfieldWithIcon:@"ic_euro_circle" withTextField:self.txtfield_max_cost];
    [self textfieldWithIcon:@"ic_directions_walk" withTextField:self.txtfield_max_distance];
    [self textfieldWithIcon:@"ic_gps_fixed" withTextField:self.txtfield_gps_tracking];
    [self textfieldWithIcon:@"ic_multi_transport" withTextField:self.txtfield_travel_modes];
    [self textfieldWithIcon:@"ic_format_list_numbered" withTextField:self.txtfield_optimise_travel];
    [self textfieldWithIcon:@"account-star" withTextField:self.txtfield_carpooler_gender];
    [self textfieldWithIcon:@"format-list-checks" withTextField:self.txtfield_carpooler_age];
    [self textfieldWithIcon:@"ic_wheelchair" withTextField:self.txtfield_special_needs];
    [self textfieldWithIcon:@"ic_cat" withTextField:self.txtfield_pets];
    
    [self textfieldWithIcon:@"ic_music_note" withTextField:self.txtfield_music];
    [self textfieldWithIcon:@"ic_smoking_rooms" withTextField:self.txtfield_smoking];
    [self textfieldWithIcon:@"ic_food_austin" withTextField:self.txtfield_food];
    [self textfieldWithIcon:@"ic_suitcase" withTextField:self.txtfield_luggage];
    
    self.txtfield_max_no_transfers.delegate = self;
    self.txtfield_max_cost.delegate = self;
    self.txtfield_max_distance.delegate = self;
    self.txtfield_gps_tracking.delegate = self;
    self.txtfield_travel_modes.delegate = self;
    self.txtfield_optimise_travel.delegate = self;
    self.txtfield_carpooler_gender.delegate = self;
    self.txtfield_carpooler_age.delegate = self;
    self.txtfield_special_needs.delegate = self;
    self.txtfield_pets.delegate = self;
    self.txtfield_music.delegate = self;
    self.txtfield_smoking.delegate = self;
    self.txtfield_food.delegate = self;
    self.txtfield_luggage.delegate = self;
    
    
    self.txtfield_travel_modes.text = [self TableDataArrayToString:commonData.tableTravelModes takenIntoAccount:sharedProfile.tableTravelModesValues];
    [self.txtfield_travel_modes setFont:[UIFont systemFontOfSize:12]];
    
    self.txtfield_optimise_travel.text = [self TableDataArrayToString:commonData.tableOptimiseTravelSolutions takenIntoAccount:sharedProfile.tableOptimiseTravelSolutions];
    [self.txtfield_optimise_travel setFont:[UIFont systemFontOfSize:12]];
    
    self.txtfield_special_needs.text = [self TableDataArrayToString:commonData.tableSpecialNeeds takenIntoAccount:sharedProfile.tableSpecialNeeds];
    [self.txtfield_special_needs setFont:[UIFont systemFontOfSize:12]];
    
    
    self.txtfield_max_no_transfers.text = sharedProfile.max_no_transfers;
    self.txtfield_max_cost.text = sharedProfile.max_cost;
    self.txtfield_max_distance.text = sharedProfile.max_distance;
    
    self.txtfield_carpooler_age.text = sharedProfile.carpooler_age;
    self.txtfield_carpooler_gender.text = sharedProfile.carpooler_gender;
    
    self.txtfield_gps_tracking.text = sharedProfile.gps_tracking;
    self.txtfield_smoking.text = sharedProfile.smoking;
    self.txtfield_food.text = sharedProfile.food;
    self.txtfield_music.text = sharedProfile.music;
    self.txtfield_pets.text = sharedProfile.pets;
    self.txtfield_luggage.text = sharedProfile.luggage;
    
#pragma mark End new code
    
    
    self.areTextFieldsEditable = NO;
    
    
   //self.title = @"@Title";
    //self.navigationItem.title =@"Profile_2";
    //Add selectors for text field events
    //self.txtfield_password.addTarget(self, action:Selector("txtfield_password_OnTouch"), forControlEvents: UIControlEvents.UITextFieldDidEndEditingReason);
    
    //Create bar button item for driver profile
    UIImage* image = [UIImage imageNamed:@"ic_directions_car"];
    
   // UIBarButtonItem *carButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(showDriverScreen)];
    UIBarButtonItem *carButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(showDriverScreen)];
    UIColor *color =[UIColor blackColor];
    [carButton setTintColor:color];
    
    self.navigationItem.rightBarButtonItem = carButton;
    
    
}

#pragma mark -show Driver Screen
- (void) showDriverScreen
{
    NSLog(@"Next pressed!");
    //[self.navigationController 	performSegueWithIdentifier:@"SegueToProfileViewControllerRegister" sender:self];
    
    if (sharedProfile.hasCar)
    {
        //storyboardDriverProfile
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardDriverProfile"];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        //storyboardDriverProfile
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardCreateDriverProfile"];
        
        //[vc performSegueWithIdentifier:@"storyboardCreateDriverProfile" sender:self];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}





#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //Keep current textfield
    txtfield_current = textField;
    
    if (self.areTextFieldsEditable)
    {
        BOOL startEditing = YES;
        
        if (textField == self.txtfield_password)
        {
            [self txtfield_password_OnTouch];
        }
        else if (textField == self.txtfield_dateOfBirth)
        {
            
            textField.backgroundColor = [UIColor yellowColor];
            
            datepicker =[[UIDatePicker alloc] init];
            datepicker.datePickerMode = UIDatePickerModeDate;
            datepicker.backgroundColor = [UIColor whiteColor];
            [myTools datePickerMinAndMaxDates:datepicker];
            
            //Format date form datepciker and display it to the textfield
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"dd/MM/YYYY"];
            textField.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:datepicker.date]];
            
            [textField  setInputView:datepicker];
            
            //Create toolbar with "Done"button
            UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
            [toolbar setTintColor:[UIColor grayColor]];
            
            //Custom Done BarButtonItem
            //UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(datePickerChanged)];
            
            //System BarButtonItme;better for localization
            UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(datePickerChanged)];
            
            UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            
            
            [toolbar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
            [textField setInputAccessoryView:toolbar];
            
            
            //      [datepicker addTarget:self action:@selector(datePickerChanged ) forControlEvents:UIControlEventValueChanged];
        }
        else if ( (textField == self.txtfield_gender) || (textField == self.txtfield_carpooler_gender) )
        {
            [textField resignFirstResponder];
            
            textField.backgroundColor = [UIColor yellowColor];
            
            NSString *gender;
            if (textField == self.txtfield_gender)
            {
                gender = NSLocalizedString(@"Gender", @"Gender");
            }
            else
            {
                gender = NSLocalizedString(@"Carpooler Gender", @"Carpooler Gender");
            }
                
            NSString *male = NSLocalizedString(@"MALE", @"MALE");
            NSString *female = NSLocalizedString(@"FEMALE", @"FEMALE");


           // [self selectGenderDialog];
            [self selectDialog:gender withChoice1:male andChoice2:female showAt:textField];
            
            //Do not enter in text field
            if (self.areTextFieldsEditable)
            {
                startEditing = NO;
                return startEditing;
            }
        }
        else if ( (textField == self.txtfield_gps_tracking) || (textField == self.txtfield_smoking) || (textField == self.txtfield_food) || (textField == self.txtfield_music) || (textField == self.txtfield_pets) || (textField == self.txtfield_luggage))
        {
            [textField resignFirstResponder];
            
            textField.backgroundColor = [UIColor yellowColor];
            
            NSString *title;
            if (textField == self.txtfield_gps_tracking)
            {
                title = NSLocalizedString(@"GPS Tracking", @"GPS Tracking");
            }
            else if (textField == self.txtfield_smoking)
            {
                title = NSLocalizedString(@"Smoking", @"Smoking");
            }
            else if (textField == self.txtfield_food)
            {
                title = NSLocalizedString(@"Food", @"Food");
            }
            else if (textField == self.txtfield_music)
            {
                title = NSLocalizedString(@"Music", @"Music");
            }
            else if (textField == self.txtfield_pets)
            {
                title = NSLocalizedString(@"Pets", @"Pets");
            }
            else if (textField == self.txtfield_luggage)
            {
                title = NSLocalizedString(@"Luggage", @"Luggage");
            }
            
            NSString *yes = NSLocalizedString(@"Yes", @"Yes");
            NSString *no = NSLocalizedString(@"No", @"No");
            
            
            [self selectDialog:title withChoice1:yes andChoice2:no showAt:textField];
            
            //Do not enter in text field
            if (self.areTextFieldsEditable)
            {
                startEditing = NO;
                return startEditing;
            }
        }
        else if ( (textField == self.txtfield_phone) || (textField == self.txtfield_max_no_transfers) || (textField == self.txtfield_max_cost) || (textField == self.txtfield_max_distance))
        {
            textField.backgroundColor = [UIColor yellowColor];
            [self customPhonePad:txtfield_current];
        }
        else if (textField == self.txtfield_rating)
        {
            //Do not enter in text field
            startEditing = NO;
            return startEditing;
        }
        else if (textField == self.txtfield_carpooler_age)
        {
            [textField resignFirstResponder];
            textField.backgroundColor = [UIColor yellowColor];
            
            NSString *title = NSLocalizedString(@"Carpooler Age", @"Carpooler Age");
            
            NSArray *arrayChoices = [NSArray arrayWithObjects:@"18-30",@"30-40",@"40-50",@"50-60", nil];
            
            [self selectDialogMultipleChoices:title withChoices:arrayChoices choicesShowAt:textField];
        
            //Do not enter in text field
            if (self.areTextFieldsEditable)
            {
                startEditing = NO;
                return startEditing;
            }
        }
        else if ( (textField == self.txtfield_travel_modes) || (textField == self.txtfield_optimise_travel) || (textField == self.txtfield_special_needs) )
        {
            if (textField == self.txtfield_travel_modes)
            {
                txtfield_current_str = TRAVEL_MODES;
            }
            else if (textField == self.txtfield_optimise_travel)
            {
                txtfield_current_str = OPTIMISE_TRAVEL_SOLUTIONS;
            }
            else if (textField == self.txtfield_special_needs)
            {
                txtfield_current_str = SPECIAL_NEEDS;
            }
            
            [self performSegueWithIdentifier:@"showSegueMultipleSelection" sender:self];
           
            //Do not enter in text field
            if (self.areTextFieldsEditable)
            {
                startEditing = NO;
                return startEditing;
            }
        }
        else
        {
            textField.backgroundColor = [UIColor yellowColor];
        }
        
    }
    
    return self.areTextFieldsEditable;//startEditing;//YES;
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    textField.backgroundColor = [UIColor clearColor];

    if (self.areTextFieldsEditable)
    {
        if (textField == self.txtfield_email)
        {
            sharedProfile.email = self.txtfield_email.text;
        }
        else if (textField == self.txtfield_password)
        {
            sharedProfile.password = self.txtfield_password.text;
        }
        else if (textField == self.txtfield_name)
        {
            sharedProfile.user_name = self.txtfield_name.text;
            
            NSLog(@"[textFieldShouldEndEditing] sharedProfileData.user_name =%@",sharedProfile.user_name);
        }
        else if (textField == self.txtfield_phone)
        {
            sharedProfile.phone = self.txtfield_phone.text;
        }
        else if (textField == self.txtfield_dateOfBirth)
        {
            sharedProfile.dateofBirth = self.txtfield_dateOfBirth.text;
        }
        else if (textField == self.txtfield_gender)
        {
            sharedProfile.gender = self.txtfield_gender.text;
        }
        //Add code
        else if (textField == self.txtfield_rating)
        {
            sharedProfile.rating = self.txtfield_rating.text;
        }
        else if (textField == self.txtfield_max_no_transfers)
        {
            sharedProfile.max_no_transfers = self.txtfield_max_no_transfers.text;
        }
        else if (textField == self.txtfield_max_cost)
        {
            sharedProfile.max_cost = self.txtfield_max_cost.text;
        }
        else if (textField == self.txtfield_max_distance)
        {
            sharedProfile.max_distance = self.txtfield_max_distance.text;
        }
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    //Add code
    //To not be edited by the user after selection from Alert Dialog
    if ( (textField == self.txtfield_gender) || (textField == self.txtfield_carpooler_gender) )
    {
        return NO;
    }
    //End of add code
    return YES;
}


//hide the keyboard when you press the return or done button of the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (textField == self.txtfield_email)
    {
        BOOL check = [myTools NSStringIsValidEmail:textField.text];
        NSLog(@"check=%d",check);
        
        if (!check)
        {
            textField.backgroundColor = [UIColor redColor];
            [self messageEmailNotValid];
            [self.txtfield_email becomeFirstResponder];
            textField.backgroundColor = [UIColor yellowColor];
            
        }
        else
        {
            /// [textField resignFirstResponder];
            NSInteger nextTag = textField.tag + 1;
            // Try to find next responder
            UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
            if (nextResponder) {
                // Found next responder, so set it.
                [nextResponder becomeFirstResponder];
            } else {
                // Not found, so remove keyboard.
                [textField resignFirstResponder];
            }
        }
    }
    else
    {
        /// [textField resignFirstResponder];
        NSInteger nextTag = textField.tag + 1;
        // Try to find next responder
        UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
        if (nextResponder) {
            // Found next responder, so set it.
            [nextResponder becomeFirstResponder];
        } else {
            // Not found, so remove keyboard.
            [textField resignFirstResponder];
        }
    }
    
    return NO;
}

-(void) messageEmailNotValid
{
    //NSString *email = NSLocalizedString(@"Email", @"Email");
    NSString *emailNotValid = NSLocalizedString(@"Email not valid!", @"Email not valid!");
    NSString *ok = NSLocalizedString(@"OK", @"OK");
    
    UIAlertController *alertOK   =   [UIAlertController
                                      alertControllerWithTitle:emailNotValid
                                      message:@""
                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                          actionWithTitle:ok
                          style:UIAlertActionStyleDefault
                          handler:^(UIAlertAction * action)
                          {
                              [alertOK dismissViewControllerAnimated:YES completion:nil];
                              
                          }];
    
    [alertOK addAction:okAction];
    
    [self presentViewController:alertOK animated:NO completion:nil];
}

#pragma mark - custom phone pad
-(void) customPhonePad : (UITextField *)textField
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    numberToolbar.barStyle = UIBarStyleDefault;//UIBarStyleBlackTranslucent;
    
    NSString *clear= NSLocalizedString(@"Clear", @"Clear");
    NSString *done = NSLocalizedString(@"Done", @"Done");
    
 ////////// Add code   /////////
    if ( (textField == self.txtfield_phone) || (textField == self.txtfield_rating) || (textField == self.txtfield_max_no_transfers) || (textField == self.txtfield_max_cost) || (textField == self.txtfield_max_distance) )
    {
        numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:clear style:UIBarButtonItemStyleDone target:self action:@selector(clearNumberPad)],
                                [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                [[UIBarButtonItem alloc]initWithTitle:done style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    }
    
////////// End of adding code ///////
    [numberToolbar sizeToFit];
    textField.inputAccessoryView = numberToolbar;
    
}


//////Add code //////////
#pragma mark Selectors for any number pad
-(void)clearNumberPad
{
   // [txtfield_current resignFirstResponder];
    txtfield_current.text = @"";
}

-(void)doneWithNumberPad
{
    if (txtfield_current == self.txtfield_phone)
    {
        NSString *stringValue = txtfield_current.text;
        NSInteger digits = [stringValue length];
        
        if (digits < 10)
        {
            NSString *message = NSLocalizedString(@"Phone number is not valid!", @"Phone number is not valid!");
            [self alertCustom:message];
        }
        else
        {
            [txtfield_current resignFirstResponder];
        }
    }
    else
    {
        [txtfield_current resignFirstResponder];
    }
}

///// End of adding code ///////

#pragma mark end custom phone pad
- (void) datePickerChanged //:(UIDatePicker *)datepicker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];//dd-MM-YYYY"];//yyyy-mm-dd
    self.txtfield_dateOfBirth.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:datepicker.date]];
    
    [self.txtfield_dateOfBirth resignFirstResponder];
}


/*
 Set circle style for image photo; width has to be equal with height
 */
- (IBAction)cameraTouched:(id)sender {
    
   // self.label_add_photo.text = @"1821";//clear text
    
    //Add dummy image on touch; image should have size 120x120(@1x), 160x160(@2x) and 240x240 (@3x)
  /*  UIImage *image = [UIImage imageNamed:@"Makrygiannis"];
    self.image_photo.image = image;
   */
    //OR [self.image_photo setImage:image];
    
    if (self.areTextFieldsEditable)
    {
        NSString *takePhoto= NSLocalizedString(@"Take photo", @"Take photo");
        NSString *selectPhoto= NSLocalizedString(@"Select photo", @"Select photo");
        
        //Check if camera is available
        //? [self isCameraAvailable];
        
        UIAlertController* alertCamera = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:takePhoto style:UIAlertActionStyleDefault
                                                                handler:^(UIAlertAction * action) {
                                                                    
                //Add key "Privacy - Camera Usage Description"  to info.pist
                                                                [self takePhoto];
                                            }];
        
        UIAlertAction *selectPhotoAction = [UIAlertAction actionWithTitle:selectPhoto style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      
                                                                      [self selectPhoto];}];
        
        [alertCamera addAction:takePhotoAction];
        [alertCamera addAction:selectPhotoAction];
        
        [self presentViewController:alertCamera animated:YES completion:nil];
    }
}

- (IBAction)viewTouched:(id)sender
{
    
    NSLog(@"current text field =%@", txtfield_current);
    [txtfield_current resignFirstResponder];
}


- (BOOL)txtfield_password_OnTouch {
    self.txtfield_password.placeholder = @"minimum 6 characters";
    //self.txtfield_password.highlighted = YES;
    self.txtfield_password.backgroundColor = [UIColor yellowColor];
   // self.txtfield_password.borderStyle = UITextBorderStyleNone;
    
    NSLog(@"txt_field_password touched");
    
    return YES;
    
}


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

- (IBAction)btn_Edit_pressed:(id)sender
{
    
    NSString *save = NSLocalizedString(@"Save", @"Save");
    NSString *edit = NSLocalizedString(@"Edit", @"Edit");
    
    if ([self.btn_edit.currentTitle isEqualToString:edit])
    {
        self.areTextFieldsEditable = YES;
        [self.btn_edit setTitle:save forState:UIControlStateNormal];
        
        UIImage *img = [UIImage imageNamed:@"check-circle-outline"];
        self.image_edit.image = img;
    }
    else if ([self.btn_edit.currentTitle isEqualToString:save])
    {
        self.areTextFieldsEditable = NO;
        [self.btn_edit setTitle:edit forState:UIControlStateNormal];
        
        UIImage *img = [UIImage imageNamed:@"pencil-circle"];
        self.image_edit.image = img;
    
        sharedProfile.email = self.txtfield_email.text;
        sharedProfile.password = self.txtfield_password.text;
        sharedProfile.user_name = self.txtfield_name.text;
        sharedProfile.phone = self.txtfield_phone.text;
        sharedProfile.dateofBirth = self.txtfield_dateOfBirth.text;
        sharedProfile.gender = self.txtfield_gender.text;
        
        sharedProfile.tableTravelModesValues = [self fill_MutuableArray:self.txtfield_travel_modes.text compareItWith:commonData.tableTravelModes];
        
        sharedProfile.tableOptimiseTravelSolutions = [self fill_MutuableArray:self.txtfield_optimise_travel.text compareItWith:commonData.tableOptimiseTravelSolutions];
        
        sharedProfile.tableSpecialNeeds = [self fill_MutuableArray:self.txtfield_special_needs.text compareItWith:commonData.tableSpecialNeeds];
        
        sharedProfile.max_distance = self.txtfield_max_distance.text;
        sharedProfile.max_cost = self.txtfield_max_cost.text;
        sharedProfile.max_no_transfers = self.txtfield_max_no_transfers.text;
        
        sharedProfile.carpooler_age = self.txtfield_carpooler_age.text;
        sharedProfile.carpooler_gender = self.txtfield_carpooler_gender.text;
        sharedProfile.gps_tracking = self.txtfield_gps_tracking.text;
        sharedProfile.smoking = self.txtfield_smoking.text;
        sharedProfile.food = self.txtfield_food.text;
        sharedProfile.music = self.txtfield_music.text;
        sharedProfile.pets= self.txtfield_pets.text;
        sharedProfile.luggage = self.txtfield_luggage.text;
        
        indicatorView = [myTools setActivityIndicator:self];
        [indicatorView startAnimating];

        [self updateUser];
        
//        if (tmp_user_image != sharedProfile.user_image)
//        {
//            [self uploadPicture];
//        }
//        
//        [self updateTravelPrefs];
        
    }
   
}

-(NSMutableArray *) fill_MutuableArray:(NSString*) textFieldText compareItWith:(NSArray *)compareArray
{
 
//    NSString *yes = NSLocalizedString(@"Yes", @"Yes");
//    NSString *no = NSLocalizedString(@"No", @"No");
    NSString *yes = @"Yes";
    NSString *no = @"No";

    
    //Split string from textfield text
    NSArray *strings = [textFieldText componentsSeparatedByString:@","];
    
    NSMutableArray *mArray;

    //Fill it with no value for all elements
    mArray = [[NSMutableArray alloc]init];
        
    for (int i=0;i<compareArray.count;i++)
    {
        [mArray addObject:no];
    }
    
    if (strings.count >0)
    {
        for (int i=0;i<compareArray.count;i++)
        {
            for (int j=0;j<strings.count;j++)
            {
                if ([compareArray[i] isEqualToString:strings[j]])
                {
                    [mArray replaceObjectAtIndex:i withObject:yes];
                }
            }
        }
    }
    
    return mArray;
}

-(NSString *)TableDataArrayToString:(NSArray *)mArray takenIntoAccount:(NSArray *)values
{
    //NSString *yes = NSLocalizedString(@"Yes", @"Yes");
    NSString *yes = @"Yes";
    NSString *stringValue=@"";
    
    for (int i=0;i<values.count;i++)
    {
        if ([values[i] isEqualToString:yes])
        {
            stringValue = [stringValue stringByAppendingString:mArray[i]];
            
            stringValue = [stringValue stringByAppendingString:@","];
                        
        }
    }
    
    //Remove last comma
    if (stringValue.length !=0)
    {
        stringValue = [stringValue substringToIndex:[stringValue length]-1];
    }

    
    return stringValue;
}

/*
 The selection dialog as AlertViewController
 */
- (void) selectDialog : (NSString *)title withChoice1:(NSString *)choiceStr1 andChoice2:(NSString *)choiceStr2 showAt: (UITextField *)txtfield
{
   
    
    UIAlertController *view=   [UIAlertController
                                alertControllerWithTitle:title //nil
                                message:nil//"Select gender"
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *choice1 = [UIAlertAction
                              actionWithTitle:choiceStr1
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  txtfield.text = choiceStr1;
                                  //sharedProfile.gender = choiceStr1;
                                  //storeStr = choiceStr1;
                                  
                                  [view dismissViewControllerAnimated:YES completion:nil];
                                  
                                  txtfield.backgroundColor = [UIColor clearColor];
                              }];
    
    UIAlertAction *choice2 = [UIAlertAction
                              actionWithTitle:choiceStr2
                              style:UIAlertActionStyleDefault
                              handler:^(UIAlertAction * action)
                              {
                                  txtfield.text = choiceStr2;
                                 // sharedProfile.gender = choiceStr2;
                                  
                                  [view dismissViewControllerAnimated:YES completion:nil];
                                  txtfield.backgroundColor = [UIColor clearColor];
                              }];
    
    [view addAction:choice1];
    [view addAction:choice2];
    
    
    
    [self presentViewController:view animated:YES completion:nil];
}


/*
 The selection dialog as AlertViewController
 */
- (void) selectDialogMultipleChoices : (NSString *)title withChoices:(NSArray *) multipleChoices choicesShowAt: (UITextField *)txtfield
{
    
    
    UIAlertController *view=   [UIAlertController
                                alertControllerWithTitle:title //nil
                                message:nil//"Select gender"
                                preferredStyle:UIAlertControllerStyleActionSheet];
    
   
    
    for (int i=0;i< multipleChoices.count;i++)
    {
        //UIAlertAction *choice[i] = [[UIAlertAction alloc] init];
        
        UIAlertAction *choice = [UIAlertAction
                                  actionWithTitle:multipleChoices[i]
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction * action)
                                  {
                                      txtfield.text = multipleChoices[i];
                                      
                                      //?sharedProfile.gender = choiceStr1;
                                      //?storeStr = choiceStr1;
                                      
                                      
                                      [view dismissViewControllerAnimated:YES completion:nil];
                                      
                                      txtfield.backgroundColor = [UIColor clearColor];
                                  }];
        
        [view addAction:choice];
    }
    
    
    
    [self presentViewController:view animated:YES completion:nil];
}

#pragma mark - UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //info = A dictionary containing the original image and the edited image, if an image was picked
    UIImage *chosenImage = info [UIImagePickerControllerOriginalImage];//[UIImagePickerControllerEditedImage]; //Specifies an image edited by the user.
    
    /*self.image_photo.contentMode =
    //UIViewContentModeScaleToFill;
    //UIViewContentModeScaleAspectFit;
    //UIViewContentModeScaleAspectFill;
    UIViewContentModeCenter;*/
    
    NSLog(@"Before width = %.1f height = %.1f",chosenImage.size.width,chosenImage.size.height);
    CGSize size = CGSizeMake(80, 80);
    
    self.label_add_photo.text = @"";
    self.image_photo.image= [self imageWithImage:chosenImage convertToSize:size];
    
    sharedProfile.user_image = self.image_photo.image;
   
    
    NSLog(@"Resized ßwidth = %.1f height = %.1f",self.image_photo.image.size.width,self.image_photo.image.size.height);
   
    [self setStyleForImageCirle:self.image_photo];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

//Convert image to scale it into imageView
//http://stackoverflow.com/questions/4712329/how-to-resize-the-image-programatically-in-objective-c-in-iphone
- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return destImage;
}
#pragma mark - End of UIImagePickerDelegate

//Styling picture as as circle
-(void) setStyleForImageCirle: (UIImageView *) imageView
{
    self.image_photo.backgroundColor = [UIColor clearColor];
    
    self.image_photo.layer.cornerRadius = self.image_photo.frame.size.width /2;
    
    //Core Animation creates an implicit clipping mask that matches the bounds of the layer and includes any corner radius effects
    self.image_photo.layer.masksToBounds =  YES;
    
    //self.image_photo.clipsToBounds = YES;
    
    //[self.image_photo.layer setBorderColor:[[UIColor colorWithPatternImage:[UIImage imageNamed:@"img_circle_dots"]] CGColor]];
    //self.image_photo.layer.borderWidth = 0.5f;
    
}



//Check if camera is availabe;avoid crashing
- (void) isCameraAvailable
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        NSString *error = NSLocalizedString(@"Error", @"Error");
        NSString *device_no_camera = NSLocalizedString(@"Device has no camera!", @"Device has no camera!");
        NSString *ok= NSLocalizedString(@"OK", @"OK");
        
        UIAlertController *alertOK   =   [UIAlertController
                                          alertControllerWithTitle:error
                                          message:device_no_camera
                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:ok
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       [alertOK dismissViewControllerAnimated:YES completion:nil];
                                       
                                   }];
        
        [alertOK addAction:okAction];
        [self presentViewController:alertOK animated:NO completion:nil];
        
    }
}

- (void)takePhoto
{
    //#if !(TARGET_IPHONE_SIMULATOR)
    //#endif
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    /* Delegate has to conform to both protocols
    UIImagePickerControllerDelegate and UINavigationControllerDelegate */
    picker.delegate = self;
    
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
   [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)selectPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;//YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self presentViewController:picker animated:YES completion:NULL];
}


#pragma NOT USED!!!!
//Draw text inside an image and return the resulting image:
//from http://stackoverflow.com/questions/6992830/how-to-write-text-on-image-in-objective-c-ios
/*- (UIImage*) drawText:(NSString*) text
              inImage:(UIImage*)  image
              atPoint:(CGPoint)   point
{
    UIFont *font = [UIFont boldSystemFontOfSize:12];
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    
    [[UIColor whiteColor] set];
    [text drawInRect:CGRectIntegral(rect) withFont:font];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
*/

#pragma mark - Convert Yes/No to True/False As String
- (NSString *) from_Yes_No_to_TrueFalse : (NSString *)valueStr
{
    NSString *true_false = @"false";
    
    if ( [valueStr isEqualToString:@"Yes"] )
    {
        true_false = @"true";
    }
    
    return true_false;
}

#pragma mark - Convert Yes/No to true/false as BOOL
- (NSNumber *) from_Yes_No_to_TrueFalse_Boolean : (NSString *)valueStr
{
   // NSString *true_false = @"false";
    NSNumber *true_false = [NSNumber numberWithBool:NO];
   // BOOL true_false = false;
    
    if ( [valueStr isEqualToString:@"Yes"] )
    {
       // true_false = @"true";
        true_false = [NSNumber numberWithBool:YES];
    }
    
    return true_false;
}


#pragma mark - REST calls
- (void)updateUser
{
    case_call_API = 1;
    
    //1. Create URL  : http://BASEURL/users/57d66eb3a377f26c67fd6ac3
    NSString *ulrStr = commonData.BASEURL;
    ulrStr = [ulrStr stringByAppendingString:commonData.URL_users];
    ulrStr = [ulrStr stringByAppendingString:sharedProfile.userID];
    
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    
    NSLog(@"urlWitString=%@",urlWithString);
    
    //2. Get credentials from GUI
    /*NSURLCredential *newCredential = [NSURLCredential credentialWithUser:self.txtfield_email.text
     password:self.txtfield_password.text
     persistence:NSURLCredentialPersistenceNone]; */
    
    
    NSURLCredential *newCredential = [NSURLCredential credentialWithUser:sharedProfile.email
                                                                password:sharedProfile.password
                                                             persistence:NSURLCredentialPersistenceNone];
    
    NSString *authStr = [newCredential user];
    authStr = [authStr stringByAppendingString:@":"];
    authStr  = [authStr stringByAppendingString:[newCredential password] ];
    NSLog(@"authStr=%@",authStr);
    
    NSLog(@"username=%@",[newCredential user]);
    NSLog(@"hasPassword=%i",[newCredential hasPassword]);
    NSLog(@"password=%@",[newCredential password]);
    
    //2.1 Create string authValue for sessionConfiguration (3) => "Basic xxxxxxxxx"
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
    
    //3. Create Session Configuration
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //3.1 Configure Session Configuration with HTTP Additional Headers
    [sessionConfiguration setAllowsCellularAccess:YES];
    [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Accept" : @"application/json", @"Content-Type" : @"application/json", @"Authorization" : authValue  }];
    
    //4. Create Session delegate
    sessionRequest= [NSURLSession sessionWithConfiguration:sessionConfiguration delegate: self delegateQueue: [NSOperationQueue mainQueue]]; /*An operation queue for scheduling the delegate calls and completion handlers. The queue should be a serial queue, in order to ensure the correct ordering of callbacks. If nil, the session creates a serial operation queue for performing all delegate method calls and completion handler calls.*/
    
    //5. Create and send Request
    //NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://46.101.238.243:5000/rest/v2/users?email="]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //6. Set HTTP Method
    [urlRequest setHTTPMethod:HTTP_METHOD_PATCH];//]@"PATCH"];
    
    //Put parameters as JSON
    //7. Set parameters as JSON
    NSMutableDictionary *dictionary_ALL = [[NSMutableDictionary alloc]init];
    
   // NSString *genderConvert= [myTools localized_male_femal_to_male_female:self.txtfield_gender.text];
    
    NSDictionary *dictionary = @{
                                 EMAIL_     : self.txtfield_email.text,
                                 PASSWORD_  :self.txtfield_password.text,
                                 USER_NAME_ : self.txtfield_name.text,
                                 PHONE_     : self.txtfield_phone.text,
                               //  DATE_OF_BIRTH_     : self.txtfield_dateOfBirth.text,
                                // GENDER_     : genderConvert,
                                 FCM_TOKEN_ : sharedProfile.fcm_token,
                                 
                                  @"platform": @"IOS"
                                 };
    
    [dictionary_ALL addEntriesFromDictionary:dictionary];
    
    if (![self.txtfield_dateOfBirth.text isEqualToString:@""])
    {
        NSDictionary *date_of_birth_dictionary = @{
                                                   DATE_OF_BIRTH_     : self.txtfield_dateOfBirth.text
                                                   };
        
        [dictionary_ALL addEntriesFromDictionary:date_of_birth_dictionary];
    }
    
    if (![self.txtfield_gender.text isEqualToString:@""])
    {
        NSString *genderConvert= [myTools localized_male_femal_to_male_female:self.txtfield_gender.text];
        
        NSDictionary *gender_dictionary = @{
                                            GENDER_     : genderConvert
                                            };
   
        [dictionary_ALL addEntriesFromDictionary:gender_dictionary];
        
    }

    
    //Convert NSDictionary to (JSON)String
    NSString *strRes = [myTools dictionaryToJSONString:dictionary_ALL];//]dictionary];
    
    NSLog(@"strRes=%@",strRes);
    
    [urlRequest setHTTPBody:[strRes dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //8. Send Request to Server
    NSURLSessionDataTask *dataTask = [sessionRequest dataTaskWithRequest:urlRequest];
    [dataTask resume];
    
    //9. Start UIActivityIndicatorView for GUI purposes
   // indicatorView = [myTools setActivityIndicator:self];
   // [indicatorView startAnimating];
    
}

- (void)updateTravelPrefs
{
    case_call_API = 2;
    
    //1. Create URL
    NSString *ulrStr = commonData.BASEURL;
    ulrStr = [ulrStr stringByAppendingString:commonData.URL_users];
    ulrStr = [ulrStr stringByAppendingString:sharedProfile.userID];
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    
    NSLog(@"urlWitString=%@",urlWithString);
    
    //2. Get credentials from GUI
    NSURLCredential *newCredential = [NSURLCredential credentialWithUser:sharedProfile.email password:sharedProfile.password persistence:NSURLCredentialPersistenceNone];
    
    NSString *authStr = [newCredential user];
    authStr = [authStr stringByAppendingString:@":"];
    authStr  = [authStr stringByAppendingString:[newCredential password] ];
    NSLog(@"authStr=%@",authStr);
    
    NSLog(@"username=%@",[newCredential user]);
    NSLog(@"hasPassword=%i",[newCredential hasPassword]);
    NSLog(@"password=%@",[newCredential password]);
    
    //2.1 Create string authValue for sessionConfiguration (3) => "Basic xxxxxxxxx"
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
    
    //3. Create Session Configuration
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //3.1 Configure Session Configuration with HTTP Additional Headers
    [sessionConfiguration setAllowsCellularAccess:YES];
    [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Accept" : @"application/json", @"Content-Type" : @"application/json", @"Authorization" : authValue  }];
    
    //4. Create Session delegate
    sessionRequest = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate: self delegateQueue: [NSOperationQueue mainQueue]]; /*An operation queue for scheduling the delegate calls and completion handlers. The queue should be a serial queue, in order to ensure the correct ordering of callbacks. If nil, the session creates a serial operation queue for performing all delegate method calls and completion handler calls.*/
    
    //5. Create and send Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //6. Set HTTP Method
    [urlRequest setHTTPMethod:HTTP_METHOD_PATCH];//]@"PATCH"];
    
    //Put parameters as JSON
    //7. Set parameters as JSON
   
    //NSMutableDictionary *dictionary_ALL = [[NSMutableDictionary alloc]init];
//    NSString *genderConvert= [myTools localized_male_femal_to_male_female:self.txtfield_carpooler_gender.text];
    
    
    NSDictionary *travel_preferences = @{
                                         @"carpooler_preferred_age_group" : self.txtfield_carpooler_age.text ,
                                         
                                         @"gps_tracking" : [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_gps_tracking.text],
                                         
                                         @"smoking": [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_smoking.text],
                                         
                                        // @"carpooler_preferred_gender": genderConvert,
                                         
                                         @"pets": [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_pets.text],
                                         
                                         @"music": [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_music.text],
                                         
                                         @"luggage": [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_luggage.text],
                                         
                                         @"food": [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_food.text]
                                         
                                         };

     NSMutableDictionary *travel_preferences_ALL = [[NSMutableDictionary alloc]init];

    if (![self.txtfield_carpooler_gender.text isEqualToString:@""])
    {
        NSString *genderConvert= [myTools localized_male_femal_to_male_female:self.txtfield_carpooler_gender.text];
        
        
        NSDictionary *gender_dictionary = @{
                                            @"carpooler_preferred_gender": genderConvert
                                            };
        
        [travel_preferences_ALL addEntriesFromDictionary:gender_dictionary];
        
    }
    
    
    if (![self.txtfield_max_cost.text isEqualToString:@""])
    {
        [travel_preferences_ALL setObject:self.txtfield_max_cost.text forKey:MAX_COST_ ];
    }
    
    if (![self.txtfield_max_no_transfers.text isEqualToString:@""])
    {
        [travel_preferences_ALL setObject:self.txtfield_max_no_transfers.text forKey:MAX_TRANSFERS_ ];
    }
    
    if (![self.txtfield_max_distance.text isEqualToString:@""])
    {
        [travel_preferences_ALL setObject:self.txtfield_max_distance.text forKey:MAX_WALKING_DISTANCE_ ];
    }
    
   // [travel_preferences_ALL setDictionary:travel_preferences];
    [travel_preferences_ALL addEntriesFromDictionary:travel_preferences];
    
    NSString *none = NSLocalizedString(@"None", @"None");
    
    NSArray *optimisationStringArray = [[NSArray alloc]init];
    //NSMutableArray *array = [[NSMutableArray alloc]init];
    NSArray *travelModesStringArray = [[NSArray alloc]init];
    NSArray *specialNeedsStringArray = [[NSArray alloc]init];
    
    //****** optimisationStringArray
    if  ( ([self.txtfield_optimise_travel.text isEqualToString:none] ) || ([self.txtfield_optimise_travel.text isEqualToString:@""]) )
    {
        [travel_preferences_ALL setObject:optimisationStringArray forKey:@"optimisation" ];
    }
    else
    {
        optimisationStringArray = [self.txtfield_optimise_travel.text componentsSeparatedByString: @","];
        
        //Change them to English values for backened
        NSArray *optimisationStringArrayEnglish = [[NSArray alloc]init];
        
        optimisationStringArrayEnglish = [myTools localized_optimisedSolutions_to_optimisedSolutions:optimisationStringArray];
        
        
        [travel_preferences_ALL setObject:optimisationStringArrayEnglish forKey:@"optimisation" ];
    }
    
    //****** travelModesStringArray
    if  ( ([self.txtfield_travel_modes.text isEqualToString:none] ) || ([self.txtfield_travel_modes.text isEqualToString:@""]) )
    {
        [travel_preferences_ALL setObject:travelModesStringArray forKey:@"preferred_transport" ];
    }
    else
    {
        travelModesStringArray = [self.txtfield_travel_modes.text componentsSeparatedByString: @","];
        
        //Change them to English values for backened
        NSArray *travelModesStringArrayEnglish = [[NSArray alloc]init];
        
        travelModesStringArrayEnglish = [myTools localized_travelModes_to_travelModes:travelModesStringArray];
        
        [travel_preferences_ALL setObject:travelModesStringArrayEnglish forKey:@"preferred_transport" ];
    }
    
    //*** specialNeedsStringArray
    if  ( ([self.txtfield_special_needs.text isEqualToString:none] ) || ([self.txtfield_special_needs.text isEqualToString:@""]) )
    {
        [travel_preferences_ALL setObject:specialNeedsStringArray forKey:@"special_request" ];
    }
    else
    {
        specialNeedsStringArray = [self.txtfield_special_needs.text componentsSeparatedByString: @","];
        
        
        //Change them to English values for backened
        NSArray *specialNeedsStringArrayEnglish = [[NSArray alloc]init];
        
        specialNeedsStringArrayEnglish = [myTools localized_specialNeeds_to_specialNeeds:specialNeedsStringArray];
        
        [travel_preferences_ALL setObject:specialNeedsStringArrayEnglish forKey:@"special_request" ];
    }
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:travel_preferences_ALL, TRAVEL_PREFERENCES_, nil];
    
    //Convert NSDictionary to (JSON)String
    NSString *strRes = [myTools dictionaryToJSONString:dictionary];
    NSLog(@"strRes=%@",strRes);
    
    [urlRequest setHTTPBody:[strRes dataUsingEncoding:NSUTF8StringEncoding]];
    
    //8. Send Request to Server
    NSURLSessionDataTask *dataTask = [sessionRequest dataTaskWithRequest:urlRequest];
    [dataTask resume];
    
    //9. Start UIActivityIndicatorView for GUI purposes
    //   indicatorView = [self setActivityIndicator:self];
    //   [indicatorView startAnimating];

}


-(void) uploadPicture
{
    case_call_API = 3;
    
    // Dictionary that holds post parameters. You can set your post parameters that your server accepts or programmed to accept.
    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
    
    [_params setObject:[NSString stringWithFormat:@"%@", sharedProfile.userID] forKey:@"user_id"];
    
//? to be generated
    // the boundary string : a random string, that will not repeat in post data, to separate post data fields.
    NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    
    // string constant for the post parameter 'file'. My server uses this name: `file`. Your's may differ
    NSString* FileParamConstant = @"file";
    
    
    //1. Create URL  : http://BASEURL/user_pictures
    NSString *ulrStr = commonData.BASEURL;
    ulrStr = [ulrStr stringByAppendingString:commonData.URL_user_pictures];
   
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    
    NSLog(@"urlWitString=%@",urlWithString);
    
    //2. Get credentials from GUI
    NSURLCredential *newCredential = [NSURLCredential credentialWithUser:self.txtfield_email.text
                                                                password:self.txtfield_password.text
                                                             persistence:NSURLCredentialPersistenceNone];
    NSString *authStr = [newCredential user];
    authStr = [authStr stringByAppendingString:@":"];
    authStr  = [authStr stringByAppendingString:[newCredential password] ];
    NSLog(@"authStr=%@",authStr);
    
    NSLog(@"username=%@",[newCredential user]);
    NSLog(@"hasPassword=%i",[newCredential hasPassword]);
    NSLog(@"password=%@",[newCredential password]);
    
    //2.1 Create string authValue for sessionConfiguration (3) => "Basic xxxxxxxxx"
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
    
    //3. Create Session Configuration
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //3.1 Configure Session Configuration with HTTP Additional Headers
    [sessionConfiguration setAllowsCellularAccess:YES];
    [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Accept" : @"application/json", @"Content-Type" : @"application/json", @"Authorization" : authValue  }];
    
    //4. Create Session delegate
    sessionRequest = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate: self delegateQueue: [NSOperationQueue mainQueue]]; /*An operation queue for scheduling the delegate calls and completion handlers. The queue should be a serial queue, in order to ensure the correct ordering of callbacks. If nil, the session creates a serial operation queue for performing all delegate method calls and completion handler calls.*/
    
    //5. Create and send Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //6. Set HTTP Method
    [urlRequest setHTTPMethod:@"POST"];
    //***
    [urlRequest setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [urlRequest setHTTPShouldHandleCookies:NO];
   // [urlRequest setTimeoutInterval:30]; //default =60 seconds
    //***
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [urlRequest setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in _params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
  //  UIImage *image = [UIImage imageNamed:@"image2"]; //jpg
   // NSData *imageData = UIImageJPEGRepresentation(self.image_photo.image, 1.0);
    
    NSData *imageData = UIImagePNGRepresentation(self.image_photo.image);
    
    if (imageData)
    {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        
        //Set filename to transefer as
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"imagePosted.png\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        
//Set it as png or jpeg
        [body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:imageData];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [urlRequest setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", [body length]];
    [urlRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    
    //7. Send Request to Server
    NSURLSessionDataTask *dataTask = [sessionRequest dataTaskWithRequest:urlRequest];
    [dataTask resume];
    
    //8. Start UIActivityIndicatorView for GUI purposes
   // indicatorView = [self setActivityIndicator:self];
   // [indicatorView startAnimating];
    
    

}
#pragma mark - NSURLSessionDataDelegate methods
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    NSLog(@"### handler ");
    
    completionHandler(NSURLSessionResponseAllow);
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    NSError *jsonError;
    
    NSDictionary *parseJSON = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:&jsonError];
    NSLog(@"parseJSON = %@", parseJSON);
    
    if ( [parseJSON objectForKey:@"_error"])
    {
        NSString *str = [parseJSON objectForKey:@"message"];
        NSString *strFormatted = [NSString stringWithFormat: @"%@",str];
        
        NSLog(@"_issues(strFormatted)=%@",strFormatted);
        NSString *error_message = NSLocalizedString(@"Credentials required!", @"Credentials required!");
        
        [self alertCustom:error_message];
    }
    else
    {
        if (case_call_API == 1) //End of successful "UPDATE USER" porcess
        {
           
            [self updateTravelPrefs];
        }
        else if (case_call_API == 2)
        {
            if (tmp_user_image != sharedProfile.user_image)
            {
                [self uploadPicture];
            }
            else
            {
                 [self alertCustom:NSLocalizedString(@"Data updated successfully!", "Data updated successfully!")];
            }
            
        }
        else if (case_call_API == 3)
        {
            [self alertCustom:NSLocalizedString(@"Data updated successfully!", "Data updated successfully!")];
        }
    }
    
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    //Stop indicator
    [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    [indicatorView stopAnimating];

    
    if(error == nil)
    {
        NSLog(@"Task finished succesfully!");
    }
    else
        NSLog(@"Error %@",[error userInfo]);
}

/*
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
*/

#pragma mark - alertCustom
//-(void) alertCustom
-(void) alertCustom : (NSString *)error_message
{
    NSString *ok = NSLocalizedString(@"OK", @"OK");
    //  NSString *message_title = NSLocalizedString(@"Credentials", @"Credentials");
    //NSString *error_message = NSLocalizedString(@"Credentials required!", @"Credentials required!");
    
    UIAlertController *alertAuthenticationError = [UIAlertController
                                                   alertControllerWithTitle:error_message
                                                   message:@""
                                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:ok
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [alertAuthenticationError dismissViewControllerAnimated:YES completion:nil];
                               }];
    [alertAuthenticationError addAction:okAction];
    [self presentViewController:alertAuthenticationError animated:NO completion:nil];
    
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
 //Example:
    if ([segue.identifier isEqualToString:@"showSegueMultipleSelection"])
    {
        MultipleSelectionTableViewController *multipleSelectionTableVC = (MultipleSelectionTableViewController *)segue.destinationViewController;
        
        multipleSelectionTableVC.txtfieldEnteredTitle = txtfield_current_str;
    
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
