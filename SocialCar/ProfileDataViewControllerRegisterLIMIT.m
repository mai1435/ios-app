//
//  ProfileDataViewControllerTabItem.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 13/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "ProfileDataViewControllerRegisterLIMIT.h"


@interface ProfileDataViewControllerRegisterLIMIT ()
//{
//    SharedProfileData *sharedProfile;
//}

@end

@implementation ProfileDataViewControllerRegisterLIMIT



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //Do not allow edit textfields
    //self.areTextFieldsEditable = NO;
    //??Why??
    //sharedProfile = [[SharedProfileData alloc]init];
    sharedProfile = [SharedProfileData sharedObject];
    myTools = [[MyTools alloc]init];
    
    commonData = [[CommonData alloc]init];
    [commonData initWithValues];
    
       
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
    [self textfieldWithIcon:@"lock.png" withTextField:self.txtfield_confirm_password];
    
    [self textfieldWithIcon:@"face.png" withTextField:self.txtfield_name];
    [self textfieldWithIcon:@"phone.png" withTextField:self.txtfield_phone];
   
    
    //    [self textfieldWithIcon:@"star_grey.png" withTextField:self.txtfield_rating];
    
    //sets all the textfield delegate to the current class
    self.txtfield_email.delegate = self;
    self.txtfield_password.delegate = self;
    self.txtfield_confirm_password.delegate = self;
    self.txtfield_name.delegate = self;
    self.txtfield_phone.delegate = self;
   
    
    if (sharedProfile.useFacebook)
    {
        self.txtfield_email.text = sharedProfile.email;
        //    self.txtfield_password.text = sharedProfile.password;
        self.txtfield_name.text = sharedProfile.user_name;
        //    self.txtfield_phone.text = sharedProfile.phone;
        //    self.txtfield_dateOfBirth.text = sharedProfile.dateofBirth;
        //self.txtfield_gender.text = sharedProfile.gender;
        
        if (sharedProfile.user_image)
        {
            
            self.image_photo.image = sharedProfile.user_image;
            [self setStyleForImageCirle:self.image_photo];
        }
        
        [self.btn_register setTitle:NSLocalizedString(@"Complete Registration",@"Complete Registration") forState:UIControlStateNormal];
        
    }
    else if (sharedProfile.useGoogle)
    {
        self.txtfield_email.text = sharedProfile.email;
        self.txtfield_name.text = sharedProfile.user_name;
        if (sharedProfile.user_image)
        {
            self.image_photo.image = sharedProfile.user_image;
            [self setStyleForImageCirle:self.image_photo];
        }
        
        [self.btn_register setTitle:NSLocalizedString(@"Complete Registration",@"Complete Registration") forState:UIControlStateNormal];
    }
    else
    {
        [self.btn_register setTitle:NSLocalizedString(@"Register",@"Register") forState:UIControlStateNormal];
    }
    //
    //
    //    self.txtfield_rating.text = sharedProfile.rating;
    

    
//#pragma other info lines
//    self.view_travel_info_line_right = [self.view_travel_info_line_right initWithFrame:CGRectMake(0, 0, self.view_travel_info_line_right.bounds.size.width, 1)];
//    
//    self.view_travel_info_line_right.backgroundColor = [UIColor grayColor];
//    
//    [self.stackview_travel_info addArrangedSubview:self.view_travel_info_line_right];
//    
//    [self textfieldWithIcon:@"ic_transfer_within_a_station" withTextField:self.txtfield_max_no_transfers];
//    [self textfieldWithIcon:@"ic_euro_circle" withTextField:self.txtfield_max_cost];
//    [self textfieldWithIcon:@"ic_directions_walk" withTextField:self.txtfield_max_distance];
//    [self textfieldWithIcon:@"ic_gps_fixed" withTextField:self.txtfield_gps_tracking];
//    [self textfieldWithIcon:@"ic_multi_transport" withTextField:self.txtfield_travel_modes];
//    [self textfieldWithIcon:@"ic_format_list_numbered" withTextField:self.txtfield_optimise_travel];
//    [self textfieldWithIcon:@"account-star" withTextField:self.txtfield_carpooler_gender];
//    [self textfieldWithIcon:@"format-list-checks" withTextField:self.txtfield_carpooler_age];
//    [self textfieldWithIcon:@"ic_wheelchair" withTextField:self.txtfield_special_needs];
//    [self textfieldWithIcon:@"ic_cat" withTextField:self.txtfield_pets];
//    
//    [self textfieldWithIcon:@"ic_music_note" withTextField:self.txtfield_music];
//    [self textfieldWithIcon:@"ic_smoking_rooms" withTextField:self.txtfield_smoking];
//    [self textfieldWithIcon:@"ic_food_austin" withTextField:self.txtfield_food];
//    [self textfieldWithIcon:@"ic_suitcase" withTextField:self.txtfield_luggage];
//    
//    self.txtfield_max_no_transfers.delegate = self;
//    self.txtfield_max_cost.delegate = self;
//    self.txtfield_max_distance.delegate = self;
//    self.txtfield_gps_tracking.delegate = self;
//    self.txtfield_travel_modes.delegate = self;
//    self.txtfield_optimise_travel.delegate = self;
//    self.txtfield_carpooler_gender.delegate = self;
//    self.txtfield_carpooler_age.delegate = self;
//    self.txtfield_special_needs.delegate = self;
//    self.txtfield_pets.delegate = self;
//    self.txtfield_music.delegate = self;
//    self.txtfield_smoking.delegate = self;
//    self.txtfield_food.delegate = self;
//    self.txtfield_luggage.delegate = self;
    
    
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //Keep current textfield
    txtfield_current = textField;
    
    //    if (self.areTextFieldsEditable)
    //    {
    BOOL startEditing = YES;
    
    if ( (textField == self.txtfield_password) || (textField == self.txtfield_confirm_password))
    {
        textField.secureTextEntry = YES;
        
        [self txtfield_password_OnTouch];
    }
    else if (textField == self.txtfield_phone)
    {
        textField.backgroundColor = [UIColor yellowColor];
        [self customPhonePad:txtfield_current];
    }
    else
    {
        textField.backgroundColor = [UIColor yellowColor];
    }
   
    return startEditing;
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    textField.backgroundColor = [UIColor clearColor];
    
    // if (self.areTextFieldsEditable)
    // {
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
    
    return YES;
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
//replacementString:(NSString *)string
//{
//    //Add code
//    //To not be edited by the user after selection from Alert Dialog
//    if ( (textField == self.txtfield_gender) || (textField == self.txtfield_carpooler_gender) )
//    {
//        return NO;
//    }
//    //End of add code
//    return YES;
//}


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
            
            NSString *emailNotValid = NSLocalizedString(@"Email not valid!", @"Email not valid!");
            [self alertErrorCustom:emailNotValid];
            
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
    else if (textField == self.txtfield_confirm_password)
    {
       // BOOL check = [myTools NSStringIsValidEmail:textField.text];
        //NSLog(@"check=%d",check);
        
        if (![self.txtfield_confirm_password.text isEqualToString:self.txtfield_password.text])
        {
            textField.backgroundColor = [UIColor redColor];
            
            self.txtfield_password.secureTextEntry = NO;
            self.txtfield_confirm_password.secureTextEntry = NO;
            
            NSString *paswordNotValid = NSLocalizedString(@"Password did not match!", @"Password did not match!");
            [self alertErrorCustom:paswordNotValid];
            
            [self.txtfield_confirm_password becomeFirstResponder];
            textField.backgroundColor = [UIColor yellowColor];
        }
        else
        {
            self.txtfield_password.secureTextEntry = YES;
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
/*
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
 */
#pragma mark - custom phone pad
-(void) customPhonePad : (UITextField *)textField
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    numberToolbar.barStyle = UIBarStyleDefault;//UIBarStyleBlackTranslucent;
    
    NSString *clear= NSLocalizedString(@"Clear", @"Clear");
    NSString *done = NSLocalizedString(@"Done", @"Done");
    
    ////////// Add code   /////////
    if  (textField == self.txtfield_phone)
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
            [self alertErrorCustom:message];
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

//#pragma mark end custom phone pad
//- (void) datePickerChanged //:(UIDatePicker *)datepicker
//{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"YYYY-MM-dd"];//dd-MM-YYYY"];
//    self.txtfield_dateOfBirth.text = [NSString stringWithFormat:@"%@", [formatter stringFromDate:datepicker.date]];
//    
//    [self.txtfield_dateOfBirth resignFirstResponder];
//}


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
    
    // if (self.areTextFieldsEditable)
    // {
    NSString *takePhoto= NSLocalizedString(@"Take photo", @"Take photo");
    NSString *selectPhoto= NSLocalizedString(@"Select photo", @"Select photo");
    
    //Check if camera is available
    //? [self isCameraAvailable];
    
    UIAlertController* alertCamera = [UIAlertController alertControllerWithTitle:nil
                                                                         message:nil
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:takePhoto style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                                                //Add key in info.plist "Privacy - Camera Usage Description"
                                                                [self takePhoto];
                                                            }];
    
    UIAlertAction *selectPhotoAction = [UIAlertAction actionWithTitle:selectPhoto style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                                  [self selectPhoto];}];
    
    [alertCamera addAction:takePhotoAction];
    [alertCamera addAction:selectPhotoAction];
    
    [self presentViewController:alertCamera animated:YES completion:nil];
    // }
}

- (IBAction)viewTouched:(id)sender
{
    
    NSLog(@"current text field =%@", txtfield_current);
    [txtfield_current resignFirstResponder];
}


- (BOOL)txtfield_password_OnTouch
{
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
    // [txtfield_current resignFirstResponder];
    
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
    
    
    /* UIAlertAction *choice2 = [UIAlertAction
     actionWithTitle:choiceStr2
     style:UIAlertActionStyleDefault
     handler:^(UIAlertAction * action)
     {
     txtfield.text = choiceStr2;
     sharedProfile.gender = choiceStr2;
     
     [view dismissViewControllerAnimated:YES completion:nil];
     self.txtfield_gender.backgroundColor = [UIColor clearColor];
     }];
     
     [view addAction:choice1];
     [view addAction:choice2];
     
     */
    
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
    
    self.image_photo.image= [self imageWithImage:chosenImage convertToSize:size];
    
    //?  sharedProfile.user_image = self.image_photo.image;
    
    
    NSLog(@"Resized ßwidth = %.1f height = %.1f",self.image_photo.image.size.width,self.image_photo.image.size.height);
    
    [self setStyleForImageCirle:self.image_photo];
    
    pickedImage = YES;
    
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    else if ([segue.identifier isEqualToString:@"showSegueMultipleSelectionFromProfileRegister"])
    {
        MultipleSelectionTableViewController *multipleSelectionTableVC = (MultipleSelectionTableViewController *)segue.destinationViewController;
        
        multipleSelectionTableVC.txtfieldEnteredTitle = txtfield_current_str;
    }
}

- (IBAction)btn_Register_pressed:(id)sender
{
    
    sharedProfile.email = self.txtfield_email.text;
    sharedProfile.password = self.txtfield_password.text;
    sharedProfile.user_name = self.txtfield_name.text;
    sharedProfile.phone = self.txtfield_phone.text;
//    sharedProfile.dateofBirth = self.txtfield_dateOfBirth.text;
//    sharedProfile.gender = self.txtfield_gender.text;
//    
//    sharedProfile.tableTravelModesValues = [self fill_MutuableArray:self.txtfield_travel_modes.text compareItWith:commonData.tableTravelModes];
//    
//    sharedProfile.tableOptimiseTravelSolutions = [self fill_MutuableArray:self.txtfield_optimise_travel.text compareItWith:commonData.tableOptimiseTravelSolutions];
//    
//    sharedProfile.tableSpecialNeeds = [self fill_MutuableArray:self.txtfield_special_needs.text compareItWith:commonData.tableSpecialNeeds];
//    
//    sharedProfile.max_distance = self.txtfield_max_distance.text;
//    sharedProfile.max_cost = self.txtfield_max_cost.text;
//    sharedProfile.max_no_transfers = self.txtfield_max_no_transfers.text;
//    
//    sharedProfile.carpooler_age = self.txtfield_carpooler_age.text;
//    sharedProfile.carpooler_gender = self.txtfield_carpooler_gender.text;
//    sharedProfile.gps_tracking = self.txtfield_gps_tracking.text;
//    sharedProfile.smoking = self.txtfield_smoking.text;
//    sharedProfile.food = self.txtfield_food.text;
//    sharedProfile.music = self.txtfield_music.text;
//    sharedProfile.pets= self.txtfield_pets.text;
//    sharedProfile.luggage = self.txtfield_luggage.text;
    
   
    //Now give REST calls
    if ([self.txtfield_confirm_password.text isEqualToString:self.txtfield_password.text])
    {
        [self createUser];
    }
    else
    {
        self.txtfield_password.secureTextEntry = NO;
        self.txtfield_confirm_password.secureTextEntry = NO;
        
        NSString *paswordNotValid = NSLocalizedString(@"Password did not match!", @"Password did not match!");
        [self alertErrorCustom:paswordNotValid];
    }
    
}


#pragma mark - REST calls
-(void) createUser
{
    if  ( (![self.txtfield_email.text isEqualToString:@""]) &&
         (![self.txtfield_password.text isEqualToString:@""])  &&
         (![self.txtfield_name.text isEqualToString:@""])
         && (![self.txtfield_phone.text isEqualToString:@""])  )
        //        && (![self.txtfield_dateOfBirth.text isEqualToString:@""])  &&
        //          (![self.txtfield_gender.text isEqualToString:@""]) )
    {
        case_call_API = 1;
        
        //1. Create URL
        NSString *ulrStr = commonData.BASEURL;
        ulrStr = [ulrStr stringByAppendingString: commonData.URL_users];
        
        NSURL *urlWithString = [NSURL URLWithString:ulrStr];
        
        NSLog(@"urlWitString=%@",urlWithString);
        
        //No need authorization
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
        //?    [sessionConfiguration setAllowsCellularAccess:YES];
        [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Content-Type" : @"application/json" , @"Accept" : @"application/json", @"Authorization" : authValue  }];
        //[sessionConfiguration setHTTPAdditionalHeaders:@{ @"Content-Type" : @"application/json" }];
        
        //Assign the authValue
        sharedProfile.authCredentials = authValue;
        
        //4. Create Session delegate
        sessionRequest = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate: self delegateQueue: [NSOperationQueue mainQueue]]; /*An operation queue for scheduling the delegate calls and completion handlers. The queue should be a serial queue, in order to ensure the correct ordering of callbacks. If nil, the session creates a serial operation queue for performing all delegate method calls and completion handler calls.*/
        
        //5. Create and send Request
        //NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://46.101.238.243:5000/rest/v2/users/"]];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
        //6. Set HTTP Method
        [urlRequest setHTTPMethod:HTTP_METHOD_POST];
        
        //7. Set parameters as JSON
        NSMutableDictionary *dictionary_ALL = [[NSMutableDictionary alloc]init];
        
        NSString *fcm_token_value = sharedProfile.fcm_token;
        
#if (TARGET_IPHONE_SIMULATOR)
        {
            fcm_token_value = FCM_TOKEN_IOS_EMULATOR;//FCM_TOKEN_NOT_INITIALISED;
        }
#endif
        
        
        NSDictionary *dictionary = @{
                                     EMAIL_     : self.txtfield_email.text,
                                     PASSWORD_  :self.txtfield_password.text,
                                     USER_NAME_ : self.txtfield_name.text,
                                     PHONE_     : self.txtfield_phone.text,
                                     //  DATE_OF_BIRTH_     : self.txtfield_dateOfBirth.text,
                                     //GENDER_     : genderConvert,//self.txtfield_gender.text,
                                     FCM_TOKEN_ : fcm_token_value,
                                     
                                     @"platform": @"IOS"
                                     };
        
//        if (![self.txtfield_dateOfBirth.text isEqualToString:@""])
//        {
//            NSDictionary *date_of_birth_dictionary = @{
//                                                       DATE_OF_BIRTH_     : self.txtfield_dateOfBirth.text
//                                                       };
//            
//            [dictionary_ALL addEntriesFromDictionary:dictionary];
//            [dictionary_ALL addEntriesFromDictionary:date_of_birth_dictionary];
//            
//        }
//        
//        if (![self.txtfield_gender.text isEqualToString:@""])
//        {
//            NSString *genderConvert= [myTools localized_male_femal_to_male_female:self.txtfield_gender.text];
//            
//            NSDictionary *gender_dictionary = @{
//                                                GENDER_     : genderConvert
//                                                };
//            
//            [dictionary_ALL addEntriesFromDictionary:dictionary];
//            [dictionary_ALL addEntriesFromDictionary:gender_dictionary];
//            
//        }
        
        
        if (sharedProfile.useGoogle)
        {
            NSMutableDictionary *social_provider = [[NSMutableDictionary alloc]init];
            
            NSDictionary *social_dictionary = @{
                                                SOCIAL_NETWORK : SOCIAL_NETWORK_GOOGLE,
                                                //SOCIAL_ID : sharedProfile.google_idToken
                                                SOCIAL_ID : sharedProfile.google_userID
                                                };
            
            social_provider = [NSMutableDictionary dictionaryWithObject:social_dictionary forKey:SOCIAL_PROVIDER];
            
            [dictionary_ALL addEntriesFromDictionary:dictionary];
            [dictionary_ALL addEntriesFromDictionary:social_provider];
            
        }
        else if (sharedProfile.useFacebook)
        {
            NSMutableDictionary *social_provider = [[NSMutableDictionary alloc]init];
            
            NSDictionary *social_dictionary = @{
                                                SOCIAL_NETWORK : SOCIAL_NETWORK_FACEBOOK,
                                                //SOCIAL_ID : sharedProfile.google_idToken
                                                SOCIAL_ID : sharedProfile.facebook_userID
                                                };
            
            social_provider = [NSMutableDictionary dictionaryWithObject:social_dictionary forKey:SOCIAL_PROVIDER];
            
            [dictionary_ALL addEntriesFromDictionary:dictionary];
            [dictionary_ALL addEntriesFromDictionary:social_provider];
            
        }
        else
        {
            [dictionary_ALL addEntriesFromDictionary:dictionary];
        }
        
        //Convert NSDictionary to (JSON)String
        // NSString *strRes = [myTools dictionaryToJSONString:dictionary];
        NSString *strRes = [myTools dictionaryToJSONString:dictionary_ALL];
        NSLog(@"strRes=%@",strRes);
        
        
        [urlRequest setHTTPBody:[strRes dataUsingEncoding:NSUTF8StringEncoding]];
        
        //8. Send Request to Server
        NSURLSessionDataTask *dataTask = [sessionRequest dataTaskWithRequest:urlRequest];
        
        [dataTask resume];
        
        //9. Start UIActivityIndicatorView for GUI purposes
        indicatorView = [myTools setActivityIndicator:self];
        [indicatorView startAnimating];
    }
    else
    {
        NSString *error = NSLocalizedString(@"You have to fill in login and other info!", @"You have to fill in login and other info!");
        [self alertErrorCustom:error];
    }
}



//- (void)updateTravelPrefs
//{
//    case_call_API = 2;
//    
//    //1. Create URL  : http://BASEURL/users/57d66eb3a377f26c67fd6ac3
//    NSString *ulrStr = commonData.BASEURL;
//    ulrStr = [ulrStr stringByAppendingString:commonData.URL_users];
//    ulrStr = [ulrStr stringByAppendingString:sharedProfile.userID];
//    
//    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
//    
//    NSLog(@"urlWitString=%@",urlWithString);
//    
//    //2. Get credentials from GUI
//    NSURLCredential *newCredential = [NSURLCredential credentialWithUser:sharedProfile.email password:sharedProfile.password persistence:NSURLCredentialPersistenceNone];
//    
//    NSString *authStr = [newCredential user];
//    authStr = [authStr stringByAppendingString:@":"];
//    authStr  = [authStr stringByAppendingString:[newCredential password] ];
//    NSLog(@"authStr=%@",authStr);
//    
//    NSLog(@"username=%@",[newCredential user]);
//    NSLog(@"hasPassword=%i",[newCredential hasPassword]);
//    NSLog(@"password=%@",[newCredential password]);
//    
//    //2.1 Create string authValue for sessionConfiguration (3) => "Basic xxxxxxxxx"
//    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
//    
//    //3. Create Session Configuration
//    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    
//    //3.1 Configure Session Configuration with HTTP Additional Headers
//    //[sessionConfiguration setAllowsCellularAccess:YES];
//    [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Accept" : @"application/json", @"Content-Type" : @"application/json", @"Authorization" : authValue  }];
//    
//    //4. Create Session delegate
//    sessionRequest = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate: self delegateQueue: [NSOperationQueue mainQueue]]; /*An operation queue for scheduling the delegate calls and completion handlers. The queue should be a serial queue, in order to ensure the correct ordering of callbacks. If nil, the session creates a serial operation queue for performing all delegate method calls and completion handler calls.*/
//    
//    //5. Create and send Request
//    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
//    //6. Set HTTP Method
//    [urlRequest setHTTPMethod:HTTP_METHOD_PATCH];//]@"PATCH"];
//    
//    //Put parameters as JSON
//    //7. Set parameters as JSON
//    //Check if contains "None"
//    
//    //BOOL s = [self from_Yes_No_to_TrueFalse:sharedProfile.gps_tracking];
//    //NSLog(@"S=%d",s);
//    
//    NSString *genderConvert= [myTools localized_male_femal_to_male_female:self.txtfield_carpooler_age.text];
//    
//    NSDictionary *travel_preferences = @{
//                                         @"carpooler_preferred_age_group" : genderConvert ,
//                                         
//                                         @"gps_tracking" : [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_gps_tracking.text],
//                                         
//                                         @"smoking": [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_smoking.text],
//                                         
//                                         @"carpooler_preferred_gender": genderConvert,
//                                         
//                                         @"pets": [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_pets.text],
//                                         
//                                         @"music": [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_music.text],
//                                         
//                                         @"luggage": [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_luggage.text],
//                                         
//                                         @"food": [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_food.text]
//                                         /*
//                                          @"max_cost" : self.txtfield_max_cost.text,
//                                          @"max_transfers" : self.txtfield_max_no_transfers.text,
//                                          @"max_walk_distance" : self.txtfield_max_distance.text
//                                          */
//                                         };
//    
//    NSMutableDictionary *travel_preferences_ALL = [[NSMutableDictionary alloc]init];
//    
//    if (![self.txtfield_max_cost.text isEqualToString:@""])
//    {
//        [travel_preferences_ALL setObject:self.txtfield_max_cost.text forKey:MAX_COST_ ];
//    }
//    
//    if (![self.txtfield_max_no_transfers.text isEqualToString:@""])
//    {
//        [travel_preferences_ALL setObject:self.txtfield_max_no_transfers.text forKey:MAX_TRANSFERS_ ];
//    }
//    
//    if (![self.txtfield_max_distance.text isEqualToString:@""])
//    {
//        [travel_preferences_ALL setObject:self.txtfield_max_distance.text forKey:MAX_WALKING_DISTANCE_ ];
//    }
//    
//    [travel_preferences_ALL addEntriesFromDictionary:travel_preferences];
//    
//    NSString *none = NSLocalizedString(@"None", @"None");
//    
//    NSArray *optimisationStringArray = [[NSArray alloc]init];;
//    //NSMutableArray *array = [[NSMutableArray alloc]init];
//    NSArray *travelModesStringArray = [[NSArray alloc]init];
//    NSArray *specialNeedsStringArray = [[NSArray alloc]init];
//    
//    //****** optimisationStringArray
//    if  ( ([self.txtfield_optimise_travel.text isEqualToString:none] ) || ([self.txtfield_optimise_travel.text isEqualToString:@""]) )
//    {
//        [travel_preferences_ALL setObject:optimisationStringArray forKey:@"optimisation" ];
//    }
//    else
//    {
//        optimisationStringArray = [self.txtfield_optimise_travel.text componentsSeparatedByString: @","];
//        
//        //Change them to English values for backened
//        NSArray *optimisationStringArrayEnglish = [[NSArray alloc]init];
//        
//        optimisationStringArrayEnglish = [myTools localized_optimisedSolutions_to_optimisedSolutions:optimisationStringArray];
//        
//        
//        [travel_preferences_ALL setObject:optimisationStringArrayEnglish forKey:@"optimisation" ];
//    }
//    
//    //****** travelModesStringArray
//    if  ( ([self.txtfield_travel_modes.text isEqualToString:none] ) || ([self.txtfield_travel_modes.text isEqualToString:@""]) )
//    {
//        [travel_preferences_ALL setObject:travelModesStringArray forKey:@"preferred_transport" ];
//    }
//    else
//    {
//        travelModesStringArray = [self.txtfield_travel_modes.text componentsSeparatedByString: @","];
//        
//        //Change them to English values for backened
//        NSArray *travelModesStringArrayEnglish = [[NSArray alloc]init];
//        
//        travelModesStringArrayEnglish = [myTools localized_travelModes_to_travelModes:travelModesStringArray];
//        
//        [travel_preferences_ALL setObject:travelModesStringArrayEnglish forKey:@"preferred_transport" ];
//    }
//    
//    //*** specialNeedsStringArray
//    if  ( ([self.txtfield_special_needs.text isEqualToString:none] ) || ([self.txtfield_special_needs.text isEqualToString:@""]) )
//    {
//        [travel_preferences_ALL setObject:specialNeedsStringArray forKey:@"special_request" ];
//    }
//    else
//    {
//        specialNeedsStringArray = [self.txtfield_special_needs.text componentsSeparatedByString: @","];
//        
//        //Change them to English values for backened
//        NSArray *specialNeedsStringArrayEnglish = [[NSArray alloc]init];
//        
//        specialNeedsStringArrayEnglish = [myTools localized_specialNeeds_to_specialNeeds:specialNeedsStringArray];
//        
//        [travel_preferences_ALL setObject:specialNeedsStringArrayEnglish forKey:@"special_request" ];
//    }
//    
//    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:travel_preferences_ALL, TRAVEL_PREFERENCES_, nil];
//    
//    //Convert NSDictionary to (JSON)String
//    NSString *strRes = [myTools dictionaryToJSONString:dictionary];
//    NSLog(@"strRes=%@",strRes);
//    
//    [urlRequest setHTTPBody:[strRes dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    //8. Send Request to Server
//    NSURLSessionDataTask *dataTask = [sessionRequest dataTaskWithRequest:urlRequest];
//    [dataTask resume];
//    
//}


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
    //[sessionConfiguration setAllowsCellularAccess:YES];
    [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Accept" : @"application/json", @"Content-Type" : @"application/json", @"Authorization" : authValue  }];
    
    //4. Create Session delegate
    sessionRequest = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate: self delegateQueue: [NSOperationQueue mainQueue]]; /*An operation queue for scheduling the delegate calls and completion handlers. The queue should be a serial queue, in order to ensure the correct ordering of callbacks. If nil, the session creates a serial operation queue for performing all delegate method calls and completion handler calls.*/
    
    //5. Create and send Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //6. Set HTTP Method
    [urlRequest setHTTPMethod:HTTP_METHOD_POST];
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
    
}


#pragma mark - alertCustom
-(void) alertCustom : (NSString *)message
{
    NSString *ok = NSLocalizedString(@"OK", @"OK");
    //  NSString *message_title = NSLocalizedString(@"Credentials", @"Credentials");
    // NSString *error_message = NSLocalizedString(@"Credentials required!", @"Credentials required!");
    
    UIAlertController *alertAuthenticationError = [UIAlertController
                                                   alertControllerWithTitle:message
                                                   message:@""
                                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:ok
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [alertAuthenticationError dismissViewControllerAnimated:YES completion:nil];
                                   
                                   if (goBackToRootViewController)
                                   {
                                       [self.navigationController popToRootViewControllerAnimated:YES];
                                   }
                                   else
                                   {
                                       MenuTabBarController *menuTabBarController = (MenuTabBarController *)[self.storyboard instantiateViewControllerWithIdentifier:@"menuTabStoryboard"];
                                       
                                       self.view.window.rootViewController = menuTabBarController;
                                       [self.view.window makeKeyAndVisible];
                                   }
                               }];
    [alertAuthenticationError addAction:okAction];
    [self presentViewController:alertAuthenticationError animated:NO completion:nil];
    
}

#pragma mark - alertErrorCustom
-(void) alertErrorCustom : (NSString *)error_message
{
    NSString *ok = NSLocalizedString(@"OK", @"OK");
    //  NSString *message_title = NSLocalizedString(@"Credentials", @"Credentials");
    // NSString *error_message = NSLocalizedString(@"Credentials required!", @"Credentials required!");
    
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
        NSDictionary *issues = [parseJSON objectForKey:@"_issues"];
        
        //  if (issues!=nil)
        // {
        NSString *strFormatted = [NSString stringWithFormat: @"%@",issues];
        NSString *emailStr = [issues objectForKey:@"email"];
        
        if ([emailStr containsString:@"not unique"])
        {
            // email = "value 'test20@test20.gr' is not unique";
            if (![strFormatted isEqualToString:@""])
            {
                NSString *EmailNotUnique = NSLocalizedString(@"Email is not unique!", @"Email is not unique!");
                [self alertErrorCustom:EmailNotUnique];
            }
        }
        else if ([emailStr containsString:@"does not match regex"])
        {
            if (![strFormatted isEqualToString:@""])
            {
                //email = "value does not match regex '^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$'";
                NSString *emailNotValid = NSLocalizedString(@"Email not valid!", @"Email not valid!");
                [self alertErrorCustom:emailNotValid];
            }
        }
        
        NSString *passwordStr = [issues objectForKey:@"password"];
        if (passwordStr !=nil)
        {
            NSString *passwordLength = NSLocalizedString(@"Password must be at least 6 characters!", @"Password must be at least 6 characters!");
            [self alertErrorCustom:passwordLength];
        }

        //}
        
        /*   NSString *strMessage = [parseJSON objectForKey:@"message"];
         
         if (strMessage!=nil)
         {
         NSString *strFormatted = [NSString stringWithFormat: @"%@",str];
         
         if (![strFormatted isEqualToString:@""])
         {
         NSString *EmailNotUnique = NSLocalizedString(@"Please provide proper credentials!", @"Please provide proper credentials!");
         [self alertCustom:EmailNotUnique];
         }
         }
         
         
         NSString *strEmail = [parseJSON objectForKey:@"email"];
         
         if (strEmail!=nil)
         {
         NSString *strFormattedEMailReason = [NSString stringWithFormat: @"%@",strEmail];
         
         //See it later
         // "value does not match regex '^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$'";
         if (![strFormattedEMailReason isEqualToString:@""])
         {
         // NSString *EmailNotUnique = NSLocalizedString(@"Email is not unique!", @"Email is not unique!");
         //[self alertCustom:EmailNotUnique];
         [self messageEmailNotValid];
         }
         }
         */
    }
    else
    {
        if (case_call_API == 1)
        {
            sharedProfile.userID = [parseJSON valueForKey:USER_ID_];
            
          //?  [self updateTravelPrefs];
            
//        }
//        else if (case_call_API == 2)
//        {
            if ( (pickedImage) || (sharedProfile.useFacebook) )
            {
                [self uploadPicture];
            }
            else
            {
                //Go to root (first page) or enter to Menu if you are using Google or Facebook
                if (sharedProfile.useGoogle)
                {
                    goBackToRootViewController = NO;
                }
                else if (sharedProfile.useFacebook)
                {
                    goBackToRootViewController = NO;
                }
                else
                {
                    goBackToRootViewController = YES;
                }
                
                [self alertCustom:NSLocalizedString(@"User created successfully!", "User created successfully!")];
                
                [sessionRequest invalidateAndCancel];
            }
            
        }
        else if (case_call_API == 3)
        {
            //Go to root (first page) or enter to Menu if you are using Google or Facebook
            if (sharedProfile.useGoogle)
            {
                goBackToRootViewController = NO;
            }
            else if (sharedProfile.useFacebook)
            {
                goBackToRootViewController = NO;
            }
            else
            {
                goBackToRootViewController = YES;
            }
            
            [self alertCustom:NSLocalizedString(@"User created successfully!", "User created successfully!")];
            
            [sessionRequest invalidateAndCancel];
            
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
 Detect the press of The back button of NavigationItem:
 */
-(void) viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound)
    {
        // Navigation BACK button was pressed.
        //[self.navigationController  popViewControllerAnimated:NO]; => NOt use this because removes the top and move to the top the current active
        
        //Clear values on multiple selection
        sharedProfile.tableTravelModesValues = nil;
        sharedProfile.tableSpecialNeeds = nil;
        sharedProfile.tableOptimiseTravelSolutions = nil;
        
        if ( [ [GIDSignIn sharedInstance] currentUser] )
        {
            [[GIDSignIn sharedInstance] disconnect];
        }
    }
    
    [super viewWillDisappear:animated];
}



@end
