//
//  ReportTableViewController.m
//  SocialCar
//
//  Created by Vittorio Tauro on 01/08/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import "ReportTableViewController.h"
#import "NewReportTableViewController.h"
#import "MyTools.h"
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface ReportTableViewController ()
@property (nonatomic) int levelSelected;
@property (nonatomic) int typeSelected;
@property (nonatomic) float fromLat;
@property (nonatomic) float toLat;
@property (nonatomic) float fromLng;
@property (nonatomic) float toLng;


@end

@implementation ReportTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.levelSelected = -1;
    self.typeSelected = -1;
    
    self.toLat = 0.0f;
    self.fromLat = 0.0f;
    self.toLng = 0.0f;
    self.fromLng = 0.0f;
    
    sharedProfile = [SharedProfileData sharedObject];
    commonData = [[CommonData alloc]init];
    [commonData initWithValues];

    self.labelLow.text = NSLocalizedString(@"Low", @"Low");
    self.labelMedium.text = NSLocalizedString(@"Medium", @"Medium");
    self.labelHigh.text = NSLocalizedString(@"High", @"High");
    self.labelWork.text = NSLocalizedString(@"Men at work", @"Men at work");
    self.labelTraffic.text = NSLocalizedString(@"Traffic jam", @"Traffic jam");
    self.labelAccident.text = NSLocalizedString(@"Accident", @"Accident");

    self.textFieldTo.delegate = self;
    self.textFieldFrom.delegate = self;
    
    UITapGestureRecognizer *tapLow = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnCircle:)];
    [_imageLow addGestureRecognizer:tapLow];

    UITapGestureRecognizer *tapMedium = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnCircle:)];
    [_imageMedium addGestureRecognizer:tapMedium];
    
    UITapGestureRecognizer *tapHigh = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnCircle:)];
    [_imageHigh addGestureRecognizer:tapHigh];
    
    UITapGestureRecognizer *tapWork = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnCircle:)];
    [_imageWork addGestureRecognizer:tapWork];

    UITapGestureRecognizer *tapTraffic = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnCircle:)];
    [_imageTraffic addGestureRecognizer:tapTraffic];

    UITapGestureRecognizer *tapAccident = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnCircle:)];
    [_imageAccident addGestureRecognizer:tapAccident];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateEditTextFrom:)
                                                 name:@"SelectedAddressFrom"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateEditTextTo:)
                                                 name:@"SelectedAddressTo"
                                               object:nil];
}

- (void)updateEditTextFrom:(NSNotification*)notification
{
    
    NSLog(@"%@", notification.userInfo);
    NSLog(@"%@", notification.name);
    self.fromLat = [(MKPlacemark*)[notification.userInfo objectForKey:@"place"] location].coordinate.latitude;
    self.fromLng = [(MKPlacemark*)[notification.userInfo objectForKey:@"place"] location].coordinate.longitude;
    self.textFieldFrom.text = [notification.userInfo objectForKey:@"address"];

}

- (void)updateEditTextTo:(NSNotification*)notification
{
    NSLog(@"%@", notification.userInfo);
    NSLog(@"%@", notification.name);
    self.toLat = [(MKPlacemark*)[notification.userInfo objectForKey:@"place"] location].coordinate.latitude;
    self.toLng = [(MKPlacemark*)[notification.userInfo objectForKey:@"place"] location].coordinate.longitude;
    self.textFieldTo.text = [notification.userInfo objectForKey:@"address"];

}

-(IBAction)tapOnCircle:(UIGestureRecognizer*)sender{
    
    if(sender.state == UIGestureRecognizerStateEnded)
    {
       
        if ([((UIImageView*)sender.view) tag] == 101) {
            [self resetImagesFromType];
            [self.imageWork setImage:[ UIImage imageNamed:@"img_report_level_low_selected"]];
            _typeSelected = 1;
        }
        
        if ([((UIImageView*)sender.view) tag] == 102) {
            [self resetImagesFromType];
            [self.imageTraffic setImage:[ UIImage imageNamed:@"img_report_level_low_selected"]];
            _typeSelected = 2;
        }
        
        if ([((UIImageView*)sender.view) tag] == 103) {
            [self resetImagesFromType];
            [self.imageAccident setImage:[ UIImage imageNamed:@"img_report_level_low_selected"]];
            _typeSelected = 3;
        }
        
        if ([((UIImageView*)sender.view) tag] == 201) {
            [self resetImagesFromLevel];
            [self.imageLow setImage:[ UIImage imageNamed:@"img_report_level_low_selected"]];
            _levelSelected = 1;
        }
        
        if ([((UIImageView*)sender.view) tag] == 202) {
            [self resetImagesFromLevel];
            [self.imageMedium setImage:[UIImage imageNamed:@"img_report_level_low_selected"]];
            _levelSelected = 2;
        }
        
        if ([((UIImageView*)sender.view) tag] == 203) {
            [self resetImagesFromLevel];
            [self.imageHigh setImage:[ UIImage imageNamed:@"img_report_level_low_selected"]];
            _levelSelected = 3;
        }
    }
    
    
}

- (void)resetImagesFromType{
    
    self.typeSelected = -1;
    self.levelSelected = -1;
    
    self.imageLow.image = [UIImage imageNamed:@"img_report_level_low"];
    self.imageMedium.image = [UIImage imageNamed:@"img_report_level_medium"];
    self.imageHigh.image = [UIImage imageNamed:@"img_report_level_high"];
    
    self.imageWork.image = [UIImage imageNamed:@"img_report_work"];
    self.imageTraffic.image = [UIImage imageNamed:@"img_report_traffic"];
    self.imageAccident.image = [UIImage imageNamed:@"img_report_accident"];
    
}

- (void)resetImagesFromLevel{
    
    self.imageLow.image = [UIImage imageNamed:@"img_report_level_low"];
    self.imageMedium.image = [UIImage imageNamed:@"img_report_level_medium"];
    self.imageHigh.image = [UIImage imageNamed:@"img_report_level_high"];
    
    self.levelSelected = -1;
}

- (IBAction)sendReport:(id)sender {
    if ([self checkSelection]&&[self checkCoordinates]) {
        [self fireReport];
    }else{
        [self showAlertWithTitle:@"" message:@"Report Incomplete. Please check report's fields" onController:self completion:nil];
    }
}

#pragma mark - Fire Reports (as driver)
-(void) fireReport
{
    //case_call_API = 7;
    NSDictionary *dataToSend = @{
                                 @"severity":self.levelSelected == 1 ? @"LOW" : self.levelSelected == 2 ? @"MEDIUM" : @"HIGH",
                                 @"category":self.typeSelected == 1 ? @"WORKS" : self.typeSelected == 2 ? @"TRAFFIC" : @"ACCIDENT",
                                 @"source":@"USER",
                                 @"location":@{
                                         @"address":self.textFieldFrom.text,
                                         @"geometry":@{
                                                 @"type":@"Point",
                                                 @"coordinates":@[@(self.fromLng), @(self.fromLat)]
                                                 }
                                         }
                                 };
    
    //1. Create URL
    NSString *ulrStr = commonData.BASEURL_CREATE_REPORT;
    
    //ulrStr = [ulrStr stringByAppendingString:sharedProfile.userID];
    
    NSURL *urlWithString = [NSURL URLWithString:ulrStr];
    
    NSLog(@"urlWithString=%@",urlWithString);
    //2. Create and send Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urlWithString];
    //3. Set HTTP Headers and HTTP Method
    [urlRequest setValue:sharedProfile.authCredentials forHTTPHeaderField:@"Authorization"];
    [urlRequest setValue:@"no-cache" forHTTPHeaderField:@"Cache-Control"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    MyTools* myTools = [[MyTools alloc]init];
    NSString *strRes = [myTools dictionaryToJSONString:dataToSend];
    
    [urlRequest setHTTPBody:[strRes dataUsingEncoding:NSUTF8StringEncoding]];
    //4. Set HTTP Method
    [urlRequest setHTTPMethod:HTTP_METHOD_POST];
    
    //5. Send Request to Server
    //?        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest];
    //?        [dataTask resume];
    //create the task
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                  {
                                      
                                      NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                      NSLog(@"%@",json);
                                      dispatch_async(dispatch_get_main_queue(), ^{

                                      if ([json objectForKey:@"timestamp"]) {
                                          FCAlertView* alert = [[FCAlertView alloc] init];
                                          [alert showAlertWithTitle:@"SUCCESS" withSubtitle:@"Information Reported" withCustomImage:nil withDoneButtonTitle:@"OK" andButtons:nil];
                                          [alert makeAlertTypeSuccess];
                                          FBSDKShareDialog *dialog = [[FBSDKShareDialog alloc] init];
                                          FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
                                          content.quote = [NSString stringWithFormat:@"%@ / Severity: %@ @ %@",self.typeSelected == 1 ? @"WORKS" : self.typeSelected == 2 ? @"TRAFFIC" : @"ACCIDENT",self.textFieldFrom.text, self.levelSelected == 1 ? @"LOW" : self.levelSelected == 2 ? @"MEDIUM" : @"HIGH"];
                                          content.contentURL = [NSURL URLWithString:[NSString stringWithFormat:@"*"]];
                            
                                          dialog.fromViewController = self;
                                          
                                          dialog.shareContent = content;
                                          dialog.mode = FBSDKShareDialogModeAutomatic; // if you don't set this before canShow call, canShow would always return YES
                                          if (![dialog canShow]) {
                                              // fallback presentation when there is no FB app
                                              dialog.mode = FBSDKShareDialogModeFeedBrowser;
                                          }
                                          [dialog show];
                                          [self.navigationController popViewControllerAnimated:YES];
                                      }else{
                                          FCAlertView* alert = [[FCAlertView alloc] init];
                                          [alert showAlertWithTitle:@"ERROR" withSubtitle:@"Something went wrong!" withCustomImage:nil withDoneButtonTitle:@"OK" andButtons:nil];
                                          [alert makeAlertTypeWarning];
                                      }
                                      });
                                      
                                  }];
    [task resume];
    
}


#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //textField.backgroundColor = [UIColor yellowColor];
    [textField resignFirstResponder];
    if (textField==self.textFieldTo) {
        _from = NO;
    }
    if (textField==self.textFieldFrom) {
        _from = YES;
    }
    [self performSegueWithIdentifier:@"selectAddressReport" sender:self];
    
    return NO;
}

- (BOOL)checkSelection
{
    if (_levelSelected!=-1&&_typeSelected!=-1) {
        return YES;
    }
    return NO;
}

- (BOOL)checkCoordinates
{
    if (self.fromLat!=0.0f&&self.fromLng!=0.0f) {
        return YES;
    }
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)showAlertWithTitle:(NSString *)title message:(NSString *)message onController:(id)controller completion:(void (^)(void))completion
{
    if ((title || ![title isEqualToString:@""]) &&
        (message || ![message isEqualToString:@""]))
    {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:title
                                                              message:message
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
                                            
        [myAlertView show];
    }
    
    return nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (_from) {
        
        // Get destination view
        NewReportTableViewController *vc = [segue destinationViewController];
        
        [vc setFrom:_from];              
    }
}



@end
