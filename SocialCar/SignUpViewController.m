//
//  SignUpViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 29/11/16.
//  Copyright © 2016 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "SignUpViewController.h"


@interface SignUpViewController () <SFSafariViewControllerDelegate>

@end

@implementation SignUpViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Left Line
#pragma view_lineLeft UIView
    
    self.view_lineLeft = [self.view_lineLeft initWithFrame:CGRectMake(0, 0, self.view_lineLeft.bounds.size.width, 1)];
    
    self.view_lineLeft.backgroundColor = [UIColor grayColor];
    
    [self.stackview_social addArrangedSubview:self.view_lineLeft];// addSubview:self.view_lineLeft];
    
    //[self.view addSubview:self.view_social];
#pragma label_social UILabel
    [self.stackview_social addArrangedSubview:self.label_social];//
    
    //Right Line
#pragma view_lineRight UIView
    self.view_lineRight = [self.view_lineRight initWithFrame:CGRectMake(0, 0, self.view_lineRight.bounds.size.width, 1)];
    
    self.view_lineRight.backgroundColor = [UIColor grayColor];
    
    [self.stackview_social addArrangedSubview:self.view_lineRight];//
    
    //[self.view_social addSubview:self.view_lineRight];
    //[self.view addSubview:self.view_social];
    
    /*UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    */
    //[self.image_facebook addGestureRecognizer:singleFingerTap];
    
   
    NSString *next_str = NSLocalizedString(@"Next", @"Next");
    
    
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:next_str style:UIBarButtonItemStylePlain target:self action:@selector(showNextScreen)];
   
   /* //Change font of all UIBarButtons
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0.0, 1.0);
    shadow.shadowColor = [UIColor whiteColor];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
     setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor],
       NSShadowAttributeName:shadow,
       NSFontAttributeName:[UIFont boldSystemFontOfSize:12.0]
       }
     forState:UIControlStateNormal];
    */
    
    self.navigationItem.rightBarButtonItem = nextButton;
   
}

- (void) showNextScreen
{
    NSLog(@"Next pressed!");
    
    //Show ViewController via storyboard
    //From info.plist see "Main storyboard file base name" property
  /*  
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
 
   //See identity storyboard ID- I put the class name for the storyboard ID
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ProfileDataViewController"];
   [self.navigationController showViewController:vc sender:nil];
    */
   
    //You have to design and declare(identifier name="SegueToNextPage") that in the storyboard in the NavigationController
   //?1 [self.navigationController performSegueWithIdentifier:@"SegueToNextPage" sender:self];
   //?CHQNGE IT: [self.navigationController performSegueWithIdentifier:@"SegueToProfileViewControllerRegister" sender:self];
   [self.navigationController performSegueWithIdentifier:@"SegueToProfileViewControllerRegisterLIMIT" sender:self];
    
   // [self.navigationController performSegueWithIdentifier:@"testSegue" sender:self];
    
}


#pragma mark - SFSafariViewController delegate methods
-(void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully {
    // Load finished
}

-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    // Done button pressed
}


///See http://stackoverflow.com/questions/4660371/how-to-add-a-touch-event-to-a-uiview
- (IBAction)tap_Facebook:(id)sender
{
    //NSLog(@"Facebook tapped!");
    // Check if FB app installed on device
    
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://"] options:@{} completionHandler:^(BOOL success)
     {
         if (!success)
         {
             //Not recommended by Apple' review process.
             //Use SFSafariViewController
          /*   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com"] options:@{} completionHandler:nil];
           */
             [self displayFacebookInBrowser];
             
         }
     }];
    
}

- (void)displayFacebookInBrowser
{
    SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"*"] entersReaderIfAvailable:NO];
    safariVC.delegate = self;
    [self presentViewController:safariVC animated:NO completion:nil];
}

- (IBAction)tap_GooglePlus:(id)sender
{
    //NSLog(@"GooglePlus tapped!");
    // Check if GooglePlus app installed on device
    
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"gplus://plus.google.com/"] options:@{} completionHandler:^(BOOL success)
     {
         if (!success)
         {
             /////Not recommended by Apple' review process.
             //Use SFSafariViewController instead.
             
            /* [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://plus.google.com/"] options:@{} completionHandler:nil];*/
             [self displayGooglePlusInBrowser];
             
         }
     }];
  
    
}

- (void)displayGooglePlusInBrowser
{
    SFSafariViewController *safariVC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:@"*"] entersReaderIfAvailable:NO];
    safariVC.delegate = self;
    [self presentViewController:safariVC animated:NO completion:nil];
}
/*
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
 */

@end
