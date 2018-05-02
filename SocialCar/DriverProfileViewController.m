//
//  DriverProfileViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 24/04/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "DriverProfileViewController.h"

@interface DriverProfileViewController ()


@end

@implementation DriverProfileViewController
//TO BE RE-CONSIDERED!!!!! - Only in implementation part canbe declared
/*static NSURLSessionConfiguration *sessionConfiguration;
static NSURLSession *sessionRequest;

static NSData *authData;
static NSString *authValue;
static NSString *authStr;
static NSURLCredential *newCredential;
*/
-(void)coloursCustom
{
    
    arrayChoices = [NSArray arrayWithObjects:@"White",@"Gray",@"Gray Blue",@"Black",@"Yellow",@"Orange",@"Red",@"Brown", @"Pink", @"Purple",@"Blue",@"Green", nil];
    
    //NSArray *arrayChoices = [NSArray arrayWithObjects:@"ic_access_time", nil]
    //UIImage *image = [UIImage imageNamed:@"ic_access_time"];
    
    //Define custom car colours with the same code as in Android app
    
    //car_color_white">#F5F5F5</color>
    // UIColor *car_color_white = [UIColor colorWithRed: 245.0/255.0 green:245.0/255.0 blue: 245.0/255.0 alpha:1];
    //#E1D7D7
    car_color_white_gray = [UIColor colorWithRed: 225.0/255.0 green:215.0/255.0 blue: 215.0/255.0 alpha:1];
    //color name="car_color_grey">#9E9E9E</color>
    car_color_grey = [UIColor colorWithRed: 158.0/255.0 green:158.0/255.0 blue: 158.0/255.0 alpha:1];
    
    //color name="car_color_blue_grey">#607D8B</color>
    car_color_blue_grey = [UIColor colorWithRed: 96.0/255.0 green:125.0/255.0 blue: 141.0/255.0 alpha:1];
    
    //color name="car_color_black">#212121</color>
    car_color_black = [UIColor colorWithRed: 33.0/255.0 green:33.0/255.0 blue: 33.0/255.0 alpha:1];
    
    //color name="car_color_yellow">#FFEB3B</color>
    car_color_yellow = [UIColor colorWithRed: 255.0/255.0 green:235.0/255.0 blue: 59.0/255.0 alpha:1];
    
    //color name="car_color_orange">#FF9800</color>
    car_color_orange = [UIColor colorWithRed: 255.0/255.0 green:152.0/255.0 blue: 0.0/255.0 alpha:1];
    
    //color name="car_color_red">#F44336</color>
    car_color_red = [UIColor colorWithRed: 244.0/255.0 green:67.0/255.0 blue: 54.0/255.0 alpha:1];
    
    //color name="car_color_brown">#795548</color>
    car_color_brown = [UIColor colorWithRed: 121.0/255.0 green:85.0/255.0 blue: 72.0/255.0 alpha:1];
    
    //color name="car_color_pink">#F06292</color>
    car_color_pink = [UIColor colorWithRed: 240.0/255.0 green:98.0/255.0 blue: 146.0/255.0 alpha:1];
    
    //color name="car_color_purple">#9C27B0</color>
    car_color_purple = [UIColor colorWithRed: 156.0/255.0 green:39.0/255.0 blue: 176.0/255.0 alpha:1];
    
    // "car_color_blue">#3F51B5</color>
    car_color_blue = [UIColor colorWithRed: 63.0/255.0 green:81.0/255.0 blue: 181.0/255.0 alpha:1];
    
    //color name="car_color_green">#4CAF50</color>
    car_color_green = [UIColor colorWithRed: 76.0/255.0 green:175.0/255.0 blue: 80.0/255.0 alpha:1];
    
    //  UIColor *pinkColorDark = [UIColor colorWithRed: 255.0/255.0 green:105.0/255.0 blue: 180.0/255.0 alpha:1];
    
    // UIColor *pinkColorLight = [UIColor colorWithRed: 255.0/255.0 green:182.0/255.0 blue: 193.0/255.0 alpha:1];
    
    //UIColor *pinkColor = [UIColor colorWithRed: 255.0/255.0 green:192.0/255.0 blue: 203.0/255.0 alpha:1];
    
    // NSArray *colourArray = [[NSArray alloc] initWithObjects:[UIColor whiteColor],[UIColor lightGrayColor],[UIColor darkGrayColor],[UIColor grayColor], [UIColor blackColor],[UIColor yellowColor], [UIColor orangeColor], [UIColor redColor],[UIColor brownColor],pinkColorDark, [UIColor purpleColor], [UIColor blueColor],[UIColor greenColor],nil];
    
    
    imagesNameArray = [NSArray arrayWithObjects:@"car_white_gray",@"car_gray",@"car_grayblue",@"car_black",@"car_yellow",@"car_orange",@"car_red",@"car_brown", @"car_pink", @"car_purple",@"car_blue",@"car_green", nil];
    
    colourCustomArray = [[NSArray alloc] initWithObjects:car_color_white_gray, car_color_grey,car_color_blue_grey, car_color_black,car_color_yellow, car_color_orange, car_color_red,car_color_brown,car_color_pink, car_color_purple, car_color_blue,car_color_green,nil];
}

//-(void) viewWillAppear:(BOOL)animated
//{
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

   // [self viewWillAppear:animated];
    
    [self coloursCustom];
    
    //tmp_car_image = [[UIImage alloc]init];
    
    sharedDriverProfile = [SharedDriverProfileData sharedObject];
    sharedProfile = [SharedProfileData sharedObject];
    
    myTools = [[MyTools alloc]init];
    commonData = [[CommonData alloc]init];
    [commonData initWithValues];
    
//    NSString *back_str = NSLocalizedString(@"< Back", @"< Back");
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:back_str style:UIBarButtonItemStylePlain
//                                                                  target:self action:@selector(back_btn_nav_pressed:)];
//    self.navigationItem.leftBarButtonItem = backButton;
//    
    
    //Add border outside to white view
    CGFloat borderWidth = 0.3f;
    
    self.view_white.frame = CGRectInset(self.view_white.frame, -borderWidth, -borderWidth);
    self.view_white.layer.borderColor = [UIColor grayColor].CGColor;
    self.view_white.layer.borderWidth = borderWidth;
    
    [self textfieldWithIcon:@"ic_directions_car"
              withTextField:self.txtfield_model];
    
    [self textfieldWithIcon:@"ic_color_lens"
              withTextField:self.txtfield_colour];

    [self textfieldWithIcon:@"ic_car_plate"
              withTextField:self.txtfield_car_plate];

    [self textfieldWithIcon:@"ic_seats"
              withTextField:self.txtfield_seats];

    [self textfieldWithIcon:@"ic_food_austin" withTextField:self.txtfield_food];
    
    [self textfieldWithIcon:@"ic_smoking_rooms" withTextField:self.txtfield_smoking];
    
     [self textfieldWithIcon:@"ic_airconditioning" withTextField:self.txtfield_airconditiong];
    
    [self textfieldWithIcon:@"ic_cat" withTextField:self.txtfield_pets];
    
    [self textfieldWithIcon:@"ic_suitcase" withTextField:self.txtfield_luggage];
  
    [self textfieldWithIcon:@"ic_child_seat" withTextField:self.txtfield_childseat];
    
    [self textfieldWithIcon:@"ic_music_note" withTextField:self.txtfield_music];

    
    self.txtfield_model.delegate = self;
    self.txtfield_car_plate.delegate = self;
    self.txtfield_colour.delegate = self;
    self.txtfield_seats.delegate = self;
    
    self.txtfield_food.delegate = self;
    self.txtfield_smoking.delegate = self;
    self.txtfield_airconditiong.delegate = self;
    self.txtfield_pets.delegate = self;
    self.txtfield_luggage.delegate = self;
    self.txtfield_childseat.delegate = self;
    self.txtfield_music.delegate = self;
    
    
    if (sharedProfile.hasCar)
    {
        //Change title label of button
        [self.btn_register setTitle:NSLocalizedString(@"Update", @"Update") forState:UIControlStateNormal];
        
        //Get car id from sharedProfile -- ONLY the last one
        //sharedDriverProfile.car_id = sharedProfile.cars[3];
       sharedDriverProfile.car_id = [sharedProfile.cars_ids lastObject]; //Get the last object
        
        NSLog(@"sharedDriverProfile.car_id(last object)=%@",sharedDriverProfile.car_id);
        
  //?      [self retrieveCar];
        //Display values in textfields from sharedObject
        [self fillTextFieldsWithSharedObject];
        
        //Add value to text fileds
    }
  
}

- (void) fillTextFieldsWithSharedObject
{
    NSLog(@"********** FILL DATA from sharedObject **********");
    //Get the car id of created car
    //sharedDriverProfile.car_id = [parseJSON valueForKey:ID_];
    NSLog(@"ID of car = %@",sharedDriverProfile.car_id);
    
    self.txtfield_model.text = sharedDriverProfile.model;
    
    self.txtfield_car_plate.text = sharedDriverProfile.plate;
    self.txtfield_colour.text = sharedDriverProfile.colour;
    
    NSString *colourTextRetrieved = sharedDriverProfile.colour;//[parseJSON valueForKey:COLOUR_];
    
    for (int i=0;i<arrayChoices.count;i++)
    {
        //if [colourTextRetrieved
        if ([colourTextRetrieved isEqualToString:arrayChoices[i]])
        {
            sharedDriverProfile.colour_text = colourCustomArray[i];
            
            break;
        }
    }
    self.txtfield_colour.textColor = sharedDriverProfile.colour_text;
    
    self.txtfield_seats.text = sharedDriverProfile.seats;
    
    
    self.txtfield_luggage.text = NSLocalizedString(sharedDriverProfile.luggage,sharedDriverProfile.luggage);
    
    
    self.txtfield_food.text = sharedDriverProfile.food;
    self.self.txtfield_smoking.text = sharedDriverProfile.smoking;
    
    self.txtfield_airconditiong.text = sharedDriverProfile.air_conditioning;
    
    self.txtfield_pets.text = sharedDriverProfile.pets;
    self.txtfield_childseat.text = sharedDriverProfile.child_seat;
    
    self.txtfield_music.text = sharedDriverProfile.music;
    /*
     ==============================================================
     Possible tobe used - Back end should be corrected
     ==============================================================
     */
    /*        self.txtfield_food.text = sharedDriverProfile.food = [[car_usage_preferences     valueForKey:FOOD_ALLOWED] boolValue ] ? @"Yes" : @"No" ;
     
     self.txtfield_smoking.text = sharedDriverProfile.smoking = [[car_usage_preferences valueForKey:SMOKING_ALLOWED] boolValue ] ? @"Yes" : @"No" ;
     
     self.txtfield_airconditiong.text = sharedDriverProfile.air_conditioning = [ [car_usage_preferences valueForKey:AIR_CONDITIONING] boolValue ] ? @"Yes" : @"No";
     
     self.txtfield_pets.text = sharedDriverProfile.pets = [[car_usage_preferences valueForKey:PETS_ALLOWED]boolValue ] ? @"Yes" : @"No";
     
     self.txtfield_childseat.text = sharedDriverProfile.child_seat = [[car_usage_preferences valueForKey:CHILD_SEAT] boolValue ] ? @"Yes" : @"No" ;
     
     self.txtfield_music.text = sharedDriverProfile.music = [[car_usage_preferences valueForKey:MUSIC_ALLOWED] boolValue ] ? @"Yes" : @"No" ;
     */
    
    //Get picture if exists
    //NSArray *pictures = [parseJSON valueForKey:PICTURES_];
    // NSDictionary *pictures = [parseJSON valueForKey:@"pictures"];
    if (sharedDriverProfile.car_image != nil)
    {
        if (sharedDriverProfile.car_image!=sharedDriverProfile.car_image_previous)
        {
            NSLog(@"pictures_id=%@",sharedDriverProfile.car_picture_id );
            
            NSLog(@"pictures_file=%@", sharedDriverProfile.car_picture_file);
            
            ///---------------///
            //Now create URL to download image (URL: BASEURL_FOR_PICTURES/car_picture_file)
            NSString *ulrStr = commonData.BASEURL_FOR_PICTURES;
            ulrStr = [ulrStr stringByAppendingString:sharedDriverProfile.car_picture_file];
            
            NSLog(@"url of image=%@",ulrStr);
            
            NSURL *imageURLString = [NSURL URLWithString:ulrStr];
            
            NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageWithData: [NSData dataWithContentsOfURL:imageURLString]])];
            //Display it in the UIImage
            UIImage *image = [UIImage imageWithData:imageData];
            
            sharedDriverProfile.car_image = image;
            sharedDriverProfile.car_image_previous = image;
            
            self.image_photo.image = sharedDriverProfile.car_image;
            [self setStyleForImageRectangle:self.image_photo];
            
            //?tmp_car_image = sharedDriverProfile.car_image;
            
            ///---------------///
            NSLog(@"********** END OF FILL DATA from sharedObject **********");
        }
        else
        {
            self.image_photo.image = sharedDriverProfile.car_image;
            [self setStyleForImageRectangle:self.image_photo];
            
        }
    }
    else //if picture is null, show defualt-empty
    {
      //  self.image_photo.image = sharedDriverProfile.car_image;
        [self setStyleForImageRectangle:self.image_photo];

    }
 
}

/*
 Used for getting the event of Back Navigarion bar button pressed
 Alternative youc an declare a custom navigation bar item in
 viewDidLoad and create selector (at the end of the code in comments)
 */
-(void) viewWillDisappear:(BOOL)animated
{
   /* if (sharedProfile.sessionGlobal!=nil)
    {
        //Invalidate session
        //?[sessionGlobal invalidateAndCancel];
        [sharedProfile.sessionGlobal finishTasksAndInvalidate];
    }*/
    
  //  [self clearSharedObjectDriverValues];
    
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound)
    {
        // Navigation button was pressed.
        //Pops all the view controllers on the stack except the root view controller
        //[self.navigationController popViewControllerAnimated:NO];
        NSArray *viewControllers = [self.navigationController viewControllers];
        
        if (viewControllers.count == 1)
        {
            UIViewController *viewController = [viewControllers objectAtIndex:0];
            DriverIntroProfileViewController *driverIntroProfileVC;
            
            if ([viewController isKindOfClass:[HomeSegmentsViewController class]] )
            {
                HomeSegmentsViewController *homeViewController = (HomeSegmentsViewController *)viewController;//[viewControllers objectAtIndex:0];
                
                driverIntroProfileVC = homeViewController.driverViewController;
                
            }
            else if ([viewController isKindOfClass:[MyTripsViewController class]] )
            {
                MyTripsViewController *myTripsViewController = [viewControllers objectAtIndex:0];
                
               driverIntroProfileVC = (DriverIntroProfileViewController *)myTripsViewController.offeredTripsViewController;
            }
            
            
           // if ([self checkWhehetMandarotyInfoFilled])
            if (sharedProfile.hasCar)
            {
                NSString *driverProfile= NSLocalizedString(@"EDIT DRIVER PROFILE", @"EDIT DRIVER PROFILE");
                
                NSString *driverProfileLabel= NSLocalizedString(@"You can edit your driver information.", @"You can edit your driver information.");
                
                driverIntroProfileVC.label_intro.text = driverProfileLabel;
                
                [driverIntroProfileVC.btn_driver setTitle: driverProfile forState:UIControlStateNormal];
            }
        }
    }
    
    [super viewWillDisappear:animated];
}

- (IBAction)carPhotoTouched:(id)sender
{
    
    NSLog(@"Add car photo stackview touched!");
    
    NSString *takePhoto= NSLocalizedString(@"Take photo", @"Take photo");
    NSString *selectPhoto= NSLocalizedString(@"Select photo", @"Select photo");
    
    //Check if camera is available
    //? [self isCameraAvailable];
    
    UIAlertController* alertCamera = [UIAlertController alertControllerWithTitle:nil
                                                                         message:nil
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:takePhoto style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                                                
                                                                /*  [self takePhoto];*/}];
    
    UIAlertAction *selectPhotoAction = [UIAlertAction actionWithTitle:selectPhoto style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  
                                                                  [self selectPhoto];}];
    
    [alertCamera addAction:takePhotoAction];
    [alertCamera addAction:selectPhotoAction];
    
    [self presentViewController:alertCamera animated:YES completion:nil];
    
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

- (IBAction)btn_Register_pressed:(id)sender
{
    NSString *registerTitle = NSLocalizedString(@"Register", @"Register");
    NSString *updateTitle = NSLocalizedString(@"Update", @"Update");
    
    if ([self.btn_register.currentTitle isEqualToString:registerTitle])
    {
        sharedDriverProfile.model = self.txtfield_model.text;
        sharedDriverProfile.plate = self.txtfield_car_plate.text;
        sharedDriverProfile.colour = self.txtfield_colour.text;
        sharedDriverProfile.colour_text = self.txtfield_colour.textColor;
        sharedDriverProfile.seats = self.txtfield_seats.text;
        sharedDriverProfile.food = self.txtfield_food.text;
        sharedDriverProfile.smoking = self.txtfield_smoking.text;
        sharedDriverProfile.air_conditioning = self.txtfield_airconditiong.text;
        sharedDriverProfile.pets = self.txtfield_pets.text;
        sharedDriverProfile.child_seat = self.txtfield_childseat.text;
        sharedDriverProfile.music = self.txtfield_music.text;
        sharedDriverProfile.luggage = self.txtfield_luggage.text;
        
        if (self.image_photo.image)
        {
            sharedDriverProfile.car_image = self.image_photo.image;
        }
        
        
        
        [self createCar];
    }
    else  if ([self.btn_register.currentTitle isEqualToString:updateTitle])
    {
        sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        //2. Get credentials from GUI
        newCredential = [NSURLCredential credentialWithUser:sharedProfile.email                                                   password:sharedProfile.password                                                 persistence:NSURLCredentialPersistenceNone];
        
        authStr = [newCredential user];
        authStr = [authStr stringByAppendingString:@":"];
        authStr  = [authStr stringByAppendingString:[newCredential password] ];
        NSLog(@"authStr=%@",authStr);
        
        NSLog(@"username=%@",[newCredential user]);
        NSLog(@"hasPassword=%i",[newCredential hasPassword]);
        NSLog(@"password=%@",[newCredential password]);
        authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
        authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
        
        [self updateCar];
       
        //Due to the fact tha UPDATE is taken place as PUT HTTP mesagges
        //you have always to uplaod a picture.
        
       // if (picturePicked)
        //{
           // if (tmp_car_image != self.image_photo.image)
            //{
//                [self uploadPicture];
            //}
        //}
        
        
    }
    //Go to previous=root Controller in that case
//?    [self.navigationController popViewControllerAnimated:YES];
    
 //?   [self dismissViewControllerAnimated:YES completion:nil];
    
    indicatorView = [myTools setActivityIndicator:self];
    [indicatorView startAnimating];
    
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
   
    CGSize size = CGSizeMake(100,100);//?* 80, 80);
    
    self.image_photo.image= [self imageWithImage:chosenImage convertToSize:size];
    
    
    NSLog(@"Resized ßwidth = %.1f height = %.1f",self.image_photo.image.size.width,self.image_photo.image.size.height);
   
    
    [self setStyleForImageRectangle:self.image_photo];
    
    picturePicked = YES;
    
    sharedDriverProfile.car_image = self.image_photo.image;
    
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
-(void) setStyleForImageRectangle: (UIImageView *) imageView
{
    self.image_photo.backgroundColor = [UIColor clearColor];
    
    //self.image_photo.layer.cornerRadius = self.image_photo.frame.size.width/2;
    
    //Core Animation creates an implicit clipping mask that matches the bounds of the layer and includes any corner radius effects
    self.image_photo.layer.masksToBounds =  YES;
    
    //self.image_photo.clipsToBounds = YES;
    
    //[self.image_photo.layer setBorderColor:[[UIColor colorWithPatternImage:[UIImage imageNamed:@"img_circle_dots"]] CGColor]];
    //self.image_photo.layer.borderWidth = 0.5f;
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    txtfield_current = textField;
    
    if ( (textField == self.txtfield_food) || (textField == self.txtfield_smoking) || (textField == self.txtfield_airconditiong) || (textField == self.txtfield_pets) ||  (textField == self.txtfield_childseat) ||(textField == self.txtfield_music)  )
    {
        [textField resignFirstResponder];
        
        textField.backgroundColor = [UIColor yellowColor];
        
        NSString *title;
        
        if (textField == self.txtfield_food)
        {
            title = NSLocalizedString(@"Food", @"Food");
        }
        else if (textField == self.txtfield_smoking)
        {
            title = NSLocalizedString(@"Smoking", @"Smoking");
        }
        else if (textField == self.txtfield_airconditiong)
        {
            title = NSLocalizedString(@"Air conditioning", @"Air conditioning");
        }
        else if (textField == self.txtfield_pets)
        {
            title = NSLocalizedString(@"Pets", @"Pets");
        }
        else if (textField == self.txtfield_childseat)
        {
            title = NSLocalizedString(@"Child seat", @"Child seat");
        }
        else if (textField == self.txtfield_music)
        {
            title = NSLocalizedString(@"Music", @"Music");
        }
        
        NSString *yes = NSLocalizedString(@"Yes", @"Yes");
        NSString *no = NSLocalizedString(@"No", @"No");
        
        
        [self selectDialog:title withChoice1:yes andChoice2:no showAt:textField];
        
        return NO;
    }
    else if (textField == self.txtfield_colour)
    {
        [textField resignFirstResponder];
        textField.backgroundColor = [UIColor yellowColor];
        
        NSString *title = NSLocalizedString(@"Select colour", @"Select colour");
        
        [self selectDialogMultipleChoicesAndImages:title withChoices:arrayChoices choicesShowAt: textField withImages:imagesNameArray withTitleColours: colourCustomArray];
        
         return NO;
        
    }
    else if (textField == self.txtfield_luggage)
    {
        [textField resignFirstResponder];
        textField.backgroundColor = [UIColor yellowColor];
        
        NSString *title = NSLocalizedString(@"Luggage allowed", @"Luggage allowed");
        
        //NSArray *arrayChoices = [NSArray arrayWithObjects:@"Small",@"Medium",@"Large",@"No", nil];
       // NSArray *arrayChoicesLuggageTypes = [NSArray arrayWithObjects:@"SMALL",@"MEDIUM",@"LARGE",@"NO", nil];
        
        
       // [self selectDialogMultipleChoices:title withChoices:arrayChoicesLuggageTypes choicesShowAt:textField];
        
        [self selectDialogMultipleChoices:title withChoices:commonData.arrayChoicesLuggageTypes choicesShowAt:textField];
        
        
        return NO;
       
    }
    else if ( textField == self.txtfield_seats)
    {
        textField.backgroundColor = [UIColor yellowColor];
        
        [self customPhonePad:textField];
        
    }
//    else
//    {
//        textField.backgroundColor = [UIColor yellowColor];
//        
//        [textField resignFirstResponder];
//    }
    
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    textField.backgroundColor = [UIColor clearColor];
    
//    if (textField == self.txtfield_model)
//    {
//        sharedDriverProfile.model = self.txtfield_model.text;
//    }
//    else if (textField == self.txtfield_car_plate)
//    {
//        sharedDriverProfile.plate = self.txtfield_car_plate.text;
//    }
//    else if (textField == self.txtfield_colour)
//    {
//        sharedDriverProfile.colour = self.txtfield_colour.text;
//    }
//    else if ( textField == self.txtfield_seats)
//    {
//        sharedDriverProfile.seats = self.txtfield_seats.text;
//    }
//    else if (textField == self.txtfield_food)
//    {
//        sharedDriverProfile.food = self.txtfield_food.text;
//    }
//    else if (textField == self.txtfield_smoking)
//    {
//        sharedDriverProfile.smoking = self.txtfield_smoking.text;
//    }
//    else if (textField == self.txtfield_airconditiong)
//    {
//        sharedDriverProfile.air_conditioning = self.txtfield_airconditiong.text;
//    }
//    else if (textField == self.txtfield_pets)
//    {
//        sharedDriverProfile.pets = self.txtfield_pets.text;
//    }
//    else if (textField == self.txtfield_childseat)
//    {
//        sharedDriverProfile.child_seat = self.txtfield_childseat.text;
//    }
//    else if (textField == self.txtfield_music)
//    {
//        sharedDriverProfile.music = self.txtfield_music.text;
//    }
//    else if (textField == self.txtfield_luggage)
//    {
//        sharedDriverProfile.luggage = self.txtfield_luggage.text;
//    }
    
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    //Add code
    //To not be edited by the user after selection from Alert Dialog
//    if ( (textField == self.txtfield_gender) || (textField == self.txtfield_carpooler_gender) )
//    {
//        return NO;
//    }
    
    if ( (textField == self.txtfield_food) || (textField == self.txtfield_smoking) || (textField == self.txtfield_airconditiong) || (textField == self.txtfield_pets) || (textField == self.txtfield_luggage) ||  (textField == self.txtfield_childseat) ||(textField == self.txtfield_music)  )
    {
        return NO;
    }
   
    //End of add code
    return YES;
}


//hide the keyboard when you press the return/next or done button of the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    /// [textField resignFirstResponder];
    if (textField == self.txtfield_model)
    {
        NSInteger nextTag = textField.tag + 1;
        // Try to find next responder
        UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
        if (nextResponder) {
            // Found next responder, so set it.
            [nextResponder becomeFirstResponder];
        }
        else
        {
            // Not found, so remove keyboard.
            [textField resignFirstResponder];
        }
    }
    else if (textField == self.txtfield_car_plate)
    {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
   /* else if (textField == self.txtfield_seats)
    {
        NSString *stringValue = textField.text;
        NSInteger seats = [stringValue intValue];
        if (seats > 6)
        {
            NSString *message = NSLocalizedString(@"Maximum 6 seats supported", @"Maximum 6 seats supported");
            [self alertCustom:message andGoBackToRootViewController:NO];
            textField.backgroundColor = [UIColor redColor];
            
            return NO;
        }
        else
        {
            return YES;
        }
    }
*/
    return NO;

}

#pragma mark - multipleChoices and images AlertViewController dialog
- (void) selectDialogMultipleChoicesAndImages : (NSString *)title withChoices:(NSArray *) multipleChoices choicesShowAt: (UITextField *)txtfield withImages:imageArrayName withTitleColours: colourArray
{
    UIAlertController *view=   [UIAlertController
                                alertControllerWithTitle:title //nil
                                message:nil
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
                                     
                                     UIColor *titleTextColor= [colourArray objectAtIndex:i];
                                     txtfield.textColor = titleTextColor;
                                     
                                     //[choice setValue:colourArray[i] forKey:@"titleTextColor"];
                                     //?sharedProfile.gender = choiceStr1;
                                     //?storeStr = choiceStr1;
   
                                     [view dismissViewControllerAnimated:YES completion:nil];
                                     
                                     txtfield.backgroundColor = [UIColor clearColor]
                                     ;
                                     
                                     
                                   //  [txtfield resignFirstResponder];
                                     
                                 }];
        
        //Now add image to each UIAlertAction
       // UIImage *image = [UIImage imageNamed:imageArrayName[i] ];
       /*  UIImage *image = [UIImage imageNamed:@"ic_access_time"];
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        
        [imageView setImage:image];
      
    
        UIImage *newImage = [imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIGraphicsBeginImageContextWithOptions(image.size, NO, newImage.scale);
        [imageView setTintColor:[UIColor redColor]];
        [newImage drawInRect:CGRectMake(0, 0, image.size.width, newImage.size.height)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        imageView.image = newImage;
        */
        
        //[imageView setTintColor:[UIColor redColor]];
        //[choice setValue:image forKey:@"image"];
   
        
       //Creates and returns a new image object with the specified rendering mode.
       [choice setValue:[[UIImage imageNamed:imageArrayName[i] ] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];
        
        [choice setValue:colourArray[i] forKey:@"titleTextColor"];
        
        [view addAction:choice];
        
     //   [view.view setTintColor:colourArray[i] ];
    }
    
    [self presentViewController:view animated:YES completion:nil];
    
  //  [txtfield_current resignFirstResponder];
    
   // [view.view setTintColor:[UIColor yellowColor]];
}


#pragma mark - multipleChoices AlertViewController dialog
- (void) selectDialogMultipleChoices : (NSString *)title withChoices:(NSArray *) multipleChoices choicesShowAt: (UITextField *)txtfield
{
    UIAlertController *view =  [UIAlertController
                                alertControllerWithTitle:title //nil
                                message:nil
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


#pragma mark - custom phone pad
-(void) customPhonePad : (UITextField *)textField
{
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    numberToolbar.barStyle = UIBarStyleDefault;//UIBarStyleBlackTranslucent;
    
    NSString *clear= NSLocalizedString(@"Clear", @"Clear");
    NSString *done = NSLocalizedString(@"Done", @"Done");
    
    ////////// Add code   /////////
    if ( textField == self.txtfield_seats)
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
 //   [txtfield_current resignFirstResponder];
    txtfield_current.text = @"";
}

-(void)doneWithNumberPad
{
    NSString *stringValue = txtfield_current.text;
    NSInteger seats = [stringValue intValue];
    if (seats > 6)
    {
        NSString *message = NSLocalizedString(@"Maximum 6 seats allowed!", @"Maximum 6 seats allowed!");
        [self alertCustom:message andGoBackToRootViewController:NO];
    }
    else
    {
        
        [txtfield_current resignFirstResponder];
    }

    
}


#pragma mark selection dialog as AlertViewController
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

#pragma mark - check whether mandatory info are filled
-(BOOL) checkWhehetMandarotyInfoFilled
{
    if ( (sharedDriverProfile.model == nil )
        || (sharedDriverProfile.plate  == nil)
          || (sharedDriverProfile.colour == nil)
            || (sharedDriverProfile.seats == nil) )
    {
        return NO;
    }
    else if ( ([sharedDriverProfile.model isEqualToString:@""])
                || ([sharedDriverProfile.plate isEqualToString:@""])
                || ([sharedDriverProfile.colour isEqualToString:@""] )
                || ([sharedDriverProfile.seats isEqualToString:@""]) )
    {
        return NO;
    }
    
    return YES;
}

//#pragma mark - Navigation back cutom button pressed
//-(void) back_btn_nav_pressed : (UIBarButtonItem *)sender
//{
//    NSLog(@"Back Navigation Button pressed!");
//    //Pops all the view controllers on the stack except the root view controller
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

#pragma mark - REST calls
-(void) createCar
{
    if ( (![self.txtfield_model.text isEqualToString:@""])
        && (![self.txtfield_car_plate.text isEqualToString:@""])
        && (![self.txtfield_colour.text isEqualToString:@""])
        && (![self.txtfield_seats.text isEqualToString:@""])
        && (![self.txtfield_luggage.text isEqualToString:@""]) )
    {
        case_call_API = 1;
        
        //1. Create URL
        NSString *ulrStr = commonData.BASEURL;
        ulrStr = [ulrStr stringByAppendingString: commonData.URL_cars];
        
        NSURL *urlWithString = [NSURL URLWithString:ulrStr];
        
        NSLog(@"urlWitString=%@",urlWithString);
        
        //No need authorization
        //2. Get credentials from GUI
 /*       NSURLCredential *newCredential = [NSURLCredential credentialWithUser:sharedProfile.email password:sharedProfile.password
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
  */
       
        //2. Get credentials from GUI
        newCredential = [NSURLCredential credentialWithUser:sharedProfile.email                                                   password:sharedProfile.password                                                 persistence:NSURLCredentialPersistenceNone];
        
        authStr = [newCredential user];
        authStr = [authStr stringByAppendingString:@":"];
        authStr  = [authStr stringByAppendingString:[newCredential password] ];
        NSLog(@"authStr=%@",authStr);
        
        NSLog(@"username=%@",[newCredential user]);
        NSLog(@"hasPassword=%i",[newCredential hasPassword]);
        NSLog(@"password=%@",[newCredential password]);
        authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
        authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];

        //3.1 Configure Session Configuration with HTTP Additional Headers
    //    [sessionConfiguration setAllowsCellularAccess:YES];
        sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Accept" : @"application/json", @"Content-Type" : @"application/json", @"Authorization" : authValue  }];
    
       //? [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Content-Type" : @"application/json" }];
        //4. Create Session delegate
        sessionRequest  = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate: self delegateQueue: [NSOperationQueue mainQueue]]; /*An operation queue for scheduling the delegate calls and completion handlers. The queue should be a serial queue, in order to ensure the correct ordering of callbacks. If nil, the session creates a serial operation queue for performing all delegate method calls and completion handler calls.*/
        
        //5. Create and send Request
    
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
        //6. Set HTTP Method
        [urlRequest setHTTPMethod:HTTP_METHOD_POST];
        
        //7. Set parameters as JSON
        NSDictionary *parameters_basic = @{
                                     OWNER_ID : sharedProfile.userID,
                                     COLOUR_  : self.txtfield_colour.text,
                                     SEATS_   : self.txtfield_seats.text,
                                     MODEL_   : self.txtfield_model.text,
                                     PLATE_   : self.txtfield_car_plate.text,
                                     };
        
    
    
        /*NSDictionary *parameters_car_usage_preferences = @{
                                 FOOD_ALLOWED : [myTools from_Yes_No_to_TrueFalse:self.txtfield_food.text],
                                 AIR_CONDITIONING : [myTools from_Yes_No_to_TrueFalse:self.txtfield_airconditiong.text],
                                 MUSIC_ALLOWED : [myTools from_Yes_No_to_TrueFalse:self.txtfield_music.text],
                                 PETS_ALLOWED : [myTools from_Yes_No_to_TrueFalse:self.txtfield_pets.text],
                                 SMOKING_ALLOWED : [myTools from_Yes_No_to_TrueFalse:self.txtfield_smoking.text],
                                 CHILD_SEAT : [myTools from_Yes_No_to_TrueFalse:self.txtfield_childseat.text],
                                 LUGGAGE_TYPE : self.txtfield_luggage.text
                                 
                                 };
         */
        
        NSString *luggage_type = [myTools localized_luggageType_to_luggageType: self.txtfield_luggage.text];
        
        NSDictionary *parameters_car_usage_preferences = @{
                                                           FOOD_ALLOWED : [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_food.text],
                                                           AIR_CONDITIONING : [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_airconditiong.text],
                                                           MUSIC_ALLOWED : [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_music.text],
                                                           PETS_ALLOWED : [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_pets.text],
                                                           SMOKING_ALLOWED : [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_smoking.text],
                                                           CHILD_SEAT : [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_childseat.text],
                                                           LUGGAGE_TYPE : luggage_type
                                                           
                                                           };

        
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:parameters_car_usage_preferences, CAR_USAGE_PREFERENCES, nil];
        
        NSMutableDictionary *parameters_ALL = [[NSMutableDictionary alloc]init];
        [parameters_ALL addEntriesFromDictionary:parameters_basic];
        [parameters_ALL addEntriesFromDictionary:dictionary];
        
        //Convert NSDictionary to (JSON)String
        NSString *strRes = [myTools dictionaryToJSONString:parameters_ALL];
        NSLog(@"strRes=%@",strRes);
        
        [urlRequest setHTTPBody:[strRes dataUsingEncoding:NSUTF8StringEncoding]];
        
        //8. Send Request to Server
        NSURLSessionDataTask *dataTask = [sessionRequest dataTaskWithRequest:urlRequest];
        
        [dataTask resume];
        
    
        //9. Start UIActivityIndicatorView for GUI purposes
    //    indicatorView = [myTools setActivityIndicator:self];
    //    [indicatorView startAnimating];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
            [indicatorView stopAnimating];
        });
            
        NSString *error = NSLocalizedString(@"You have to fill in car info!", @"You have to fill in car info!");
        [self alertCustom:error andGoBackToRootViewController:NO];
        
       
        self.txtfield_model.backgroundColor = [UIColor yellowColor];
        self.txtfield_car_plate.backgroundColor = [UIColor yellowColor];
        self.txtfield_colour.backgroundColor = [UIColor yellowColor];
        self.txtfield_seats.backgroundColor = [UIColor yellowColor];
        self.txtfield_luggage.backgroundColor = [UIColor yellowColor];
        
    }
}


-(void) uploadPicture
{
    case_call_API = 2;
    // Dictionary that holds post parameters. You can set your post parameters that your server accepts or programmed to accept.
    NSMutableDictionary* _params = [[NSMutableDictionary alloc] init];
    
    [_params setObject:[NSString stringWithFormat:@"%@", sharedDriverProfile.car_id ] forKey:CAR_ID_];
    
    //? to be generated
    // the boundary string : a random string, that will not repeat in post data, to separate post data fields.
    NSString *BoundaryConstant = @"----------V2ymHFg03ehbqgZCaKO6jy";
    
    // string constant for the post parameter 'file'. My server uses this name: `file`. Your's may differ
    NSString* FileParamConstant = @"file";
    
    
    //1. Create URL  : http://BASEURL/user_pictures
    NSString *ulrStr = commonData.BASEURL;
    ulrStr = [ulrStr stringByAppendingString:commonData.URL_car_pictures];
    
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    
    NSLog(@"urlWitString=%@",urlWithString);
/*
    //2. Get credentials from GUI
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
  //  [sessionConfiguration setAllowsCellularAccess:YES];
 */
    [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Accept" : @"application/json", @"Content-Type" : @"application/json",
        @"Cache-Control": @"no-cache",@"Authorization" : authValue  }];
    
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

- (void)retrieveCar
{
    case_call_API = 3;
    //1. Create URL
    //http://BASEURL/cars/57d6710ba377f26c67fd6ac5
    NSString *ulrStr = commonData.BASEURL;
    ulrStr = [ulrStr stringByAppendingString:commonData.URL_cars];
    ulrStr = [ulrStr stringByAppendingString:sharedDriverProfile.car_id];
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    NSLog(@" ********    RETRIEVE   *********");
    NSLog(@"urlWitString=%@",urlWithString);

/*
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
   // [sessionConfiguration setAllowsCellularAccess:YES];
 */
    sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //2. Get credentials from GUI
    newCredential = [NSURLCredential credentialWithUser:sharedProfile.email                                                   password:sharedProfile.password                                                 persistence:NSURLCredentialPersistenceNone];
    
    authStr = [newCredential user];
    authStr = [authStr stringByAppendingString:@":"];
    authStr  = [authStr stringByAppendingString:[newCredential password] ];
    NSLog(@"authStr=%@",authStr);
    
    NSLog(@"username=%@",[newCredential user]);
    NSLog(@"hasPassword=%i",[newCredential hasPassword]);
    NSLog(@"password=%@",[newCredential password]);
    authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
    
    [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Accept" : @"application/json", @"Content-Type" : @"application/json", @"Authorization" : authValue  }];
    
    //4. Create Session delegate
    sessionRequest = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate: self delegateQueue: [NSOperationQueue mainQueue]]; /*An operation queue for scheduling the delegate calls and completion handlers. The queue should be a serial queue, in order to ensure the correct ordering of callbacks. If nil, the session creates a serial operation queue for performing all delegate method calls and completion handler calls.*/
    
    //5. Create and send Request
    //NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://46.101.238.243:5000/rest/v2/users?email="]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //6. Set HTTP Method
    [urlRequest setHTTPMethod:HTTP_METHOD_GET];//@"GET"];
    
    //7. Send Request to Server
    NSURLSessionDataTask *dataTask = [sessionRequest dataTaskWithRequest:urlRequest];
    [dataTask resume];
    
    //8. Start UIActivityIndicatorView for GUI purposes
    indicatorView = [myTools setActivityIndicator:self];
    [indicatorView startAnimating];
    
}


//Update car
- (void)updateCar
{
     case_call_API = 4;
    
    //1. Create URL  : http://BASEURL/users/57d66eb3a377f26c67fd6ac3
    NSString *ulrStr = commonData.BASEURL;
    ulrStr = [ulrStr stringByAppendingString:commonData.URL_cars];
    ulrStr = [ulrStr stringByAppendingString:sharedDriverProfile.car_id];
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    
    NSLog(@"urlWitString=%@",urlWithString);
    
    //2. Get credentials from GUI
/*
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
   // [sessionConfiguration setAllowsCellularAccess:YES];
*/
    sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Accept" : @"application/json", @"Content-Type" : @"application/json", @"Cache-Control": @"no-cache",
        @"Authorization" : authValue  }];
    
    //4. Create Session delegate
    sessionRequest = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate: self delegateQueue: [NSOperationQueue mainQueue]]; /*An operation queue for scheduling the delegate calls and completion handlers. The queue should be a serial queue, in order to ensure the correct ordering of callbacks. If nil, the session creates a serial operation queue for performing all delegate method calls and completion handler calls.*/
    
    //5. Create and send Request
    //NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://46.101.238.243:5000/rest/v2/users?email="]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //6. Set HTTP Method
    [urlRequest setHTTPMethod:HTTP_METHOD_PUT];// HTTP_METHOD_PUT
    
    
    
    //Put parameters as JSON
    //7. Set parameters as JSON
    NSDictionary *parameters_basic = @{
                                       OWNER_ID : sharedProfile.userID,
                                       COLOUR_  : self.txtfield_colour.text,
                                       SEATS_   : self.txtfield_seats.text,
                                       MODEL_   : self.txtfield_model.text,
                                       PLATE_   : self.txtfield_car_plate.text,
                                       };
    
    
    NSLog(@"[UPDATE] sharedProfile.userID=%@",sharedProfile.userID);
    
    NSString *luggage_type = [myTools localized_luggageType_to_luggageType: self.txtfield_luggage.text];
    
    NSDictionary *parameters_car_usage_preferences = @{
                                                       FOOD_ALLOWED : [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_food.text],
                                                       AIR_CONDITIONING : [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_airconditiong.text],
                                                       MUSIC_ALLOWED : [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_music.text],
                                                       PETS_ALLOWED : [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_pets.text],
                                                       SMOKING_ALLOWED : [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_smoking.text],
                                                       CHILD_SEAT : [myTools from_Yes_No_to_TrueFalse_Number:self.txtfield_childseat.text],
                                                    
                                                    LUGGAGE_TYPE : luggage_type
                                                       
                                                       };
    
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:parameters_car_usage_preferences, CAR_USAGE_PREFERENCES, nil];
    
    NSMutableDictionary *parameters_ALL = [[NSMutableDictionary alloc]init];
    [parameters_ALL addEntriesFromDictionary:parameters_basic];
    [parameters_ALL addEntriesFromDictionary:dictionary];
    
    //Convert NSDictionary to (JSON)String
    NSString *strRes = [myTools dictionaryToJSONString:parameters_ALL];
    NSLog(@"strRes=%@",strRes);
    
    [urlRequest setHTTPBody:[strRes dataUsingEncoding:NSUTF8StringEncoding]];
    
    //8. Send Request to Server
    NSURLSessionDataTask *dataTask = [sessionRequest dataTaskWithRequest:urlRequest];
    
    [dataTask resume];
    
 //   indicatorView = [myTools setActivityIndicator:self];
 //   [indicatorView startAnimating];

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
       // NSString *str = [parseJSON objectForKey:@"_issues"];
       // NSString *strFormatted = [NSString stringWithFormat: @"%@",str];
        //NSLog(@"_issues=%@",str);
        NSDictionary *dictError = [parseJSON objectForKey:@"_issues"];
        NSString *plateNotUnique = [dictError valueForKey:@"plate"];
        NSString *car_usage_preferencesError = [dictError valueForKey:@"car_usage_preferences"];
        //car_usage_preferences
       // NSLog(@"_issues(strFormatted)=%@",strFormatted);
        if (plateNotUnique!=nil)
        {
            plateNotUnique = [NSLocalizedString(@"Plate ", "Plate ") stringByAppendingString:plateNotUnique];
            [self alertCustom:plateNotUnique andGoBackToRootViewController:NO];
        }
       
        if (car_usage_preferencesError!=nil)
        {
            [self alertCustom:NSLocalizedString(@"Please select luggage type!", "Please,select luggage type!") andGoBackToRootViewController:NO];
        }
        
    }
   else if ([parseJSON objectForKey:@"_issues"])
   {
        NSDictionary *dictError = [parseJSON objectForKey:@"_issues"];
        NSString *plateNotUnique = [dictError valueForKey:@"plate"];
        
        if (plateNotUnique!=nil)
        {
            plateNotUnique = [NSLocalizedString(@"Plate ", "Plate ") stringByAppendingString:plateNotUnique];
            [self alertCustom:plateNotUnique andGoBackToRootViewController:NO];
        }
    }
    else
    {
        if (case_call_API == 1)
        {
            //Get the car id of created car
            sharedDriverProfile.car_id = [parseJSON valueForKey:ID_];
            
            if (picturePicked)
            {
                [self uploadPicture];
            }
            else
            {
                sharedProfile.hasCar = YES;
                
                [self alertCustom:NSLocalizedString(@"Car data created successfully!", "Car data created successfully!") andGoBackToRootViewController:YES];
            }
        }
        else if (case_call_API == 2) //End of uploading picture
        {
            NSString *registerTitle = NSLocalizedString(@"Register", @"Register");
            NSString *updateTitle = NSLocalizedString(@"Update", @"Update");
            
            if ([self.btn_register.currentTitle isEqualToString:registerTitle])
            {
                sharedProfile.hasCar = YES;
                
                [self alertCustom:NSLocalizedString(@"Car data created successfully!", "Car data created successfully!") andGoBackToRootViewController:YES];
                
            }
            else if ([self.btn_register.currentTitle isEqualToString:updateTitle])
            {
                 [self alertCustom:NSLocalizedString(@"Car data updated successfully!", "Car data updated successfully!") andGoBackToRootViewController:NO];
            }
            
            //Store picture data for later use
            sharedDriverProfile.car_picture_id = [parseJSON valueForKey:PICTURE_ID];
            
            sharedDriverProfile.car_picture_file = [parseJSON valueForKey:PICTURE_FILE];
            
        }
        else if (case_call_API == 3) //RETRIEVE CAR
        {
            //Get the car id of created car
            sharedDriverProfile.car_id = [parseJSON valueForKey:ID_];
            NSLog(@"ID of car = %@",sharedDriverProfile.car_id);
            
            self.txtfield_model.text = sharedDriverProfile.model = [parseJSON valueForKey:MODEL_];
            
            self.txtfield_car_plate.text = sharedDriverProfile.plate = [parseJSON valueForKey:PLATE_];

            self.txtfield_colour.text = sharedDriverProfile.colour = [parseJSON valueForKey:COLOUR_];
            
            
           // UIColor
        //    self.txtfield_colour.textColor = sharedDriverProfile.colour_text = [parseJSON valueForKey:COLOUR_]; //???
            //UIColor *colour =
            
            NSString *colourTextRetrieved = [parseJSON valueForKey:COLOUR_];
            
            for (int i=0;i<arrayChoices.count;i++)
            {
                //if [colourTextRetrieved
                if ([colourTextRetrieved isEqualToString:arrayChoices[i]])
                {
                 
                    sharedDriverProfile.colour_text = colourCustomArray[i];
                    
                    break;
                }
            }
            self.txtfield_colour.textColor = sharedDriverProfile.colour_text;
            
            self.txtfield_seats.text = sharedDriverProfile.seats = [ [parseJSON valueForKey:SEATS_]stringValue];

            
            //get car_usage_preferences
            NSDictionary *car_usage_preferences = [parseJSON valueForKey:CAR_USAGE_PREFERENCES];
            
            self.txtfield_luggage.text = sharedDriverProfile.luggage = [car_usage_preferences valueForKey:LUGGAGE_TYPE];

            NSDictionary *foodAllowed= [car_usage_preferences valueForKey:FOOD_ALLOWED];
            NSString *foodAllowedStr = [NSString stringWithFormat:@"%@",foodAllowed];
            self.txtfield_food.text = sharedDriverProfile.food = [foodAllowedStr boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No") ;

            NSDictionary *smokingAllowed= [car_usage_preferences valueForKey:SMOKING_ALLOWED];
            NSString *smokingAllowedStr = [NSString stringWithFormat:@"%@",smokingAllowed];
            self.self.txtfield_smoking.text = sharedDriverProfile.smoking = [smokingAllowedStr boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No");
           
            NSDictionary *aircondition= [car_usage_preferences valueForKey:AIR_CONDITIONING];
            NSString *airconditionStr = [NSString stringWithFormat:@"%@",aircondition];
            self.txtfield_airconditiong.text = sharedDriverProfile.air_conditioning = [airconditionStr boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No") ;
            
            NSDictionary *petsAllowed= [car_usage_preferences valueForKey:PETS_ALLOWED];
            NSString *petsStr = [NSString stringWithFormat:@"%@",petsAllowed];
            self.txtfield_pets.text = sharedDriverProfile.pets = [petsStr boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No") ;
            
            NSDictionary *childSeat= [car_usage_preferences valueForKey:CHILD_SEAT];
            NSString *childSeatStr = [NSString stringWithFormat:@"%@",childSeat];
            self.txtfield_childseat.text = sharedDriverProfile.child_seat = [childSeatStr boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No") ;
            
            NSDictionary *musicAllowed= [car_usage_preferences valueForKey:MUSIC_ALLOWED];
            NSString *musicAllowedStr = [NSString stringWithFormat:@"%@",musicAllowed];
            self.txtfield_music.text = sharedDriverProfile.music = [musicAllowedStr boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No") ;
            
            /*
       ==============================================================
             Possible tobe used - Back end should be corrected
       ==============================================================
             */
  /*        self.txtfield_food.text = sharedDriverProfile.food = [[car_usage_preferences     valueForKey:FOOD_ALLOWED] boolValue ] ? @"Yes" : @"No" ;
            
            self.txtfield_smoking.text = sharedDriverProfile.smoking = [[car_usage_preferences valueForKey:SMOKING_ALLOWED] boolValue ] ? @"Yes" : @"No" ;
            
            self.txtfield_airconditiong.text = sharedDriverProfile.air_conditioning = [ [car_usage_preferences valueForKey:AIR_CONDITIONING] boolValue ] ? @"Yes" : @"No";

            self.txtfield_pets.text = sharedDriverProfile.pets = [[car_usage_preferences valueForKey:PETS_ALLOWED]boolValue ] ? @"Yes" : @"No";
            
            self.txtfield_childseat.text = sharedDriverProfile.child_seat = [[car_usage_preferences valueForKey:CHILD_SEAT] boolValue ] ? @"Yes" : @"No" ;

            self.txtfield_music.text = sharedDriverProfile.music = [[car_usage_preferences valueForKey:MUSIC_ALLOWED] boolValue ] ? @"Yes" : @"No" ;
   */

            //Get picture if exists
            NSArray *pictures = [parseJSON valueForKey:PICTURES_];
            // NSDictionary *pictures = [parseJSON valueForKey:@"pictures"];
            if (pictures.count !=0 )
            {
                sharedDriverProfile.car_picture_id = [pictures[0] valueForKey:PICTURE_ID];
                NSLog(@"pictures_id=%@",[pictures[0] valueForKey:@"_id"]);
                
                sharedDriverProfile.car_picture_file = [pictures [0]valueForKey:PICTURE_FILE];
                NSLog(@"pictures_file=%@", [pictures[0] valueForKey:@"file"]);
                
                ///---------------///
                //Now create URL to download image (URL: BASEURL_FOR_PICTURES/car_picture_file)
                NSString *ulrStr = commonData.BASEURL_FOR_PICTURES;
                ulrStr = [ulrStr stringByAppendingString:sharedDriverProfile.car_picture_file];
                
                NSLog(@"url of image=%@",ulrStr);
                
                NSURL *imageURLString = [NSURL URLWithString:ulrStr];
                
                NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageWithData:
                                                                                   [NSData dataWithContentsOfURL:imageURLString]])];
                //Display it in the UIImage
                UIImage *image = [UIImage imageWithData:imageData];
                
                sharedDriverProfile.car_image = image;
                
                self.image_photo.image = sharedDriverProfile.car_image;
                [self setStyleForImageRectangle:self.image_photo];
                
                
                //?tmp_car_image = sharedDriverProfile.car_image;
                
                ///---------------///
                NSLog(@"********** END OF RETRIEVE **********");
            }
            
        }
        else if (case_call_API == 4) //UPDATE
        {
            [self uploadPicture];
          
            //Get the car id of created car
            sharedDriverProfile.car_id = [parseJSON valueForKey:ID_];
            
            //Here you will assign all the values from JSON received to shared object.
            self.txtfield_model.text = sharedDriverProfile.model = [parseJSON valueForKey:MODEL_];
            
            self.txtfield_car_plate.text = sharedDriverProfile.plate = [parseJSON valueForKey:PLATE_];
            
            self.txtfield_colour.text = sharedDriverProfile.colour = [parseJSON valueForKey:COLOUR_];
            
            
            // UIColor
            //    self.txtfield_colour.textColor = sharedDriverProfile.colour_text = [parseJSON valueForKey:COLOUR_]; //???
            //UIColor *colour =
            
            NSString *colourTextRetrieved = [parseJSON valueForKey:COLOUR_];
            
            for (int i=0;i<arrayChoices.count;i++)
            {
                //if [colourTextRetrieved
                if ([colourTextRetrieved isEqualToString:arrayChoices[i]])
                {
                    
                    sharedDriverProfile.colour_text = colourCustomArray[i];
                    
                    break;
                }
            }
            self.txtfield_colour.textColor = sharedDriverProfile.colour_text;
            
            self.txtfield_seats.text = sharedDriverProfile.seats = [ [parseJSON valueForKey:SEATS_]stringValue];
            
            //get car_usage_preferences
            NSDictionary *car_usage_preferences = [parseJSON valueForKey:CAR_USAGE_PREFERENCES];
            
            self.txtfield_luggage.text = sharedDriverProfile.luggage = NSLocalizedString([car_usage_preferences valueForKey:LUGGAGE_TYPE],[car_usage_preferences valueForKey:LUGGAGE_TYPE]);
            
            NSDictionary *foodAllowed= [car_usage_preferences valueForKey:FOOD_ALLOWED];
            NSString *foodAllowedStr = [NSString stringWithFormat:@"%@",foodAllowed];
            self.txtfield_food.text = sharedDriverProfile.food = [foodAllowedStr boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No") ;
            
            NSDictionary *smokingAllowed= [car_usage_preferences valueForKey:SMOKING_ALLOWED];
            NSString *smokingAllowedStr = [NSString stringWithFormat:@"%@",smokingAllowed];
            self.self.txtfield_smoking.text = sharedDriverProfile.smoking = [smokingAllowedStr boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No") ;
            
            NSDictionary *aircondition= [car_usage_preferences valueForKey:AIR_CONDITIONING];
            NSString *airconditionStr = [NSString stringWithFormat:@"%@",aircondition];
            self.txtfield_airconditiong.text = sharedDriverProfile.air_conditioning = [airconditionStr boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No") ;
            
            NSDictionary *petsAllowed= [car_usage_preferences valueForKey:PETS_ALLOWED];
            NSString *petsStr = [NSString stringWithFormat:@"%@",petsAllowed];
            self.txtfield_pets.text = sharedDriverProfile.pets = [petsStr boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No") ;
            
            NSDictionary *childSeat= [car_usage_preferences valueForKey:CHILD_SEAT];
            NSString *childSeatStr = [NSString stringWithFormat:@"%@",childSeat];
            self.txtfield_childseat.text = sharedDriverProfile.child_seat = [childSeatStr boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No") ;
            
            NSDictionary *musicAllowed= [car_usage_preferences valueForKey:MUSIC_ALLOWED];
            NSString *musicAllowedStr = [NSString stringWithFormat:@"%@",musicAllowed];
            self.txtfield_music.text = sharedDriverProfile.music = [musicAllowedStr boolValue ] ? NSLocalizedString(@"Yes",@"Yes") : NSLocalizedString(@"No",@"No") ;
            
            
            //Get picture if exists
            NSArray *pictures = [parseJSON valueForKey:PICTURES_];
            // NSDictionary *pictures = [parseJSON valueForKey:@"pictures"];
            if (pictures.count !=0 )
            {
                sharedDriverProfile.car_picture_id = [pictures[0] valueForKey:PICTURE_ID];
                NSLog(@"pictures_id=%@",[pictures[0] valueForKey:@"_id"]);
                
                sharedDriverProfile.car_picture_file = [pictures [0]valueForKey:PICTURE_FILE];
                NSLog(@"pictures_file=%@", [pictures[0] valueForKey:@"file"]);
                
                ///---------------///
                //Now create URL to download image (URL: BASEURL_FOR_PICTURES/car_picture_file)
                NSString *ulrStr = commonData.BASEURL_FOR_PICTURES;
                ulrStr = [ulrStr stringByAppendingString:sharedDriverProfile.car_picture_file];
                
                NSLog(@"url of image=%@",ulrStr);
                
                NSURL *imageURLString = [NSURL URLWithString:ulrStr];
                
                NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageWithData:
                                                                                   [NSData dataWithContentsOfURL:imageURLString]])];
                //Display it in the UIImage
                UIImage *image = [UIImage imageWithData:imageData];
                
                sharedDriverProfile.car_image = image;
                
                self.image_photo.image = sharedDriverProfile.car_image;
                [self setStyleForImageRectangle:self.image_photo];
                
                
                //?tmp_car_image = sharedDriverProfile.car_image;
                
                ///---------------///
                NSLog(@"********** END OF UPDATE **********");
            }

        }
    }
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
    [indicatorView stopAnimating];
    
    if(error == nil)
    {
        NSLog(@"Task finished succesfully!");
    }
    else
        NSLog(@"Error %@",[error userInfo]);
}

#pragma mark - alertCustom
-(void) alertCustom : (NSString *)error_message andGoBackToRootViewController: (BOOL)value
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
                                  
                                   if (value)
                                   {
                                       [self.navigationController popToRootViewControllerAnimated:YES];
                                   }
                                   
                               }];
    [alertAuthenticationError addAction:okAction];
    [self presentViewController:alertAuthenticationError animated:NO completion:nil];
    
}

-(void) clearSharedObjectDriverValues
{
    sharedDriverProfile.car_id=@"";
    sharedDriverProfile.model=@"";
    
    sharedDriverProfile.plate=@"";
    sharedDriverProfile.colour=@"";
    sharedDriverProfile.colour_text = nil;
    sharedDriverProfile.seats=@"";
    sharedDriverProfile.food=@"";
    sharedDriverProfile.smoking=@"";
    
    sharedDriverProfile.air_conditioning=@"";
    sharedDriverProfile.pets=@"";
    sharedDriverProfile.luggage=@"";
    sharedDriverProfile.child_seat=@"";
    sharedDriverProfile.music=@"";
    
    sharedDriverProfile.car_image=nil;
    sharedDriverProfile.car_picture_id=@"";
    sharedDriverProfile.car_picture_file=@"";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
