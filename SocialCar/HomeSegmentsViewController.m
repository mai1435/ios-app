//
//  HomeSegmentsViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 04/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "HomeSegmentsViewController.h"

@interface HomeSegmentsViewController ()

@end

@implementation HomeSegmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];
    
    
    //Start with Segment A
    self.currentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Segment_Passenger"];
    self.currentViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addChildViewController:self.currentViewController];
    [self addSubview:self.currentViewController.view toView:self.containerView];
    
    //hide next button
    self.navigationItem.rightBarButtonItem = nil;
    
}


#pragma mark Segment changed
- (IBAction)segmentChanged:(id)sender
{
    
    if (self.segmentControl.selectedSegmentIndex == 0)
    {
        self.label_passenger.textColor = [UIColor whiteColor];
        self.label_driver.textColor =  [UIColor grayColor];
        
    
        
        if (self.passengerViewController== nil)
        {
            UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Segment_Passenger"];
            newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
            [self cycleFromViewController:self.currentViewController toViewController:newViewController];
            self.passengerViewController = newViewController;
            self.currentViewController = newViewController;
        }
        else
        {
            self.currentViewController = self.passengerViewController;
        }
        
    }
    else
    {
        self.label_driver.textColor =  [UIColor whiteColor];
        self.label_passenger.textColor = [UIColor grayColor];
        
        if (self.driverViewController == nil)
        {
            //?UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Segment_Driver"];
                            //Hide naviagation item Next > ic ase there
                if (self.navigationItem.rightBarButtonItem)
                {
                    self.navigationItem.rightBarButtonItem.title = @"";
                    
                    self.navigationItem.rightBarButtonItem.enabled = NO;
                }
   
                
                UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardOfferTripNavigationController"];//Segment_OfferedTrip"];
            
                newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
            
            
                [self cycleFromViewController:self.currentViewController toViewController:newViewController];
            
                if (sharedRoutesAsDriver.rides.count != 0)
                {
                    [newViewController performSegueWithIdentifier:@"segueShowRides" sender:self];
                   // [newViewController setTitle:@"Rides"];
                    
                    
                }
                else
                {
                    [newViewController performSegueWithIdentifier:@"segueOfferTrip" sender:self];
                }
            
                self.driverViewController = newViewController;
                self.currentViewController = newViewController;
//            }
//            else
//            {
//                //Display Lifts as Driver
//                NSLog(@"THERE ARE RIDES!");
//            }
         
        }
        else
        {
            self.currentViewController = self.driverViewController;
        }
        
    }
    
    
    
}


- (void)cycleFromViewController:(UIViewController*) oldViewController
               toViewController:(UIViewController*) newViewController
{
    
    [oldViewController willMoveToParentViewController:nil];
    [self addChildViewController:newViewController];
    [self addSubview:newViewController.view toView:self.containerView];
    newViewController.view.alpha = 0;
    [newViewController.view layoutIfNeeded];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         newViewController.view.alpha = 1;
                         oldViewController.view.alpha = 0;
                         //[newViewController.view layoutIfNeeded];
                     }
                     completion:^(BOOL finished) {
                         [oldViewController.view removeFromSuperview];
                         [oldViewController removeFromParentViewController];
                         [newViewController didMoveToParentViewController:self];
                     }];
}

- (void)addSubview:(UIView *)subView toView:(UIView*)parentView
{
    [parentView addSubview:subView];
    
    NSDictionary * views = @{@"subView" : subView,};
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subView]|"
                                                                   options:0
                                                                   metrics:0
                                                                     views:views];
    [parentView addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView]|"
                                                          options:0
                                                          metrics:0
                                                            views:views];
    [parentView addConstraints:constraints];
}


- (IBAction)nextItem_pressed:(id)sender {
    
    NSLog(@"Next Bar Button Item pressed!");
    
    [self.navigationController performSegueWithIdentifier:@"showSegueRoutes" sender:self];
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

- (IBAction)segmentChnaged:(id)sender {
}
@end
