 //
//  MyTripsViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 22/03/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "MyTripsViewController.h"

@interface MyTripsViewController ()

@end

@implementation MyTripsViewController

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    
//}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];//]animated];

    //
//-(void) viewWillAppear:(BOOL)animated
//{
  //  [super viewWillAppear:animated];

//    sharedRoutes = [ShareRoutes sharedObject];
//    
//    if ( [sharedRoutes.comingFrom isEqualToString:@"AsPassenger"] )
//    {
    sharedRoutesAsDriver = [SharedRoutesAsDriver sharedRoutesAsDriverObject];
    
    sharedLiftNotified = [SharedLiftNotified sharedLiftNotifiedObject];
        //Start with Segment A
    
    self.currentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Segment_Requested_Trips"];
    if (sharedLiftNotified.notified_lift!=nil)
    {
        if (sharedLiftNotified.notified_by_driver)
        {
            //[(RequestedTripsViewController *)self.currentViewController comingFrom:@"Passenger"];
            
            RequestedTripsViewController *requestedTripsVC = (RequestedTripsViewController *)self.currentViewController;
            [requestedTripsVC comingFrom:@"Passenger"];
            
            [requestedTripsVC.tableView_requestedTrips reloadData];

            [self.segmentControl setSelectedSegmentIndex:0];
        }
        else
        {
           // [(RequestedTripsViewController *)self.currentViewController comingFrom:@"Driver"];

            RequestedTripsViewController *requestedTripsVC = (RequestedTripsViewController *)self.currentViewController;
            [requestedTripsVC comingFrom:@"Driver"];
            
            [requestedTripsVC.tableView_requestedTrips reloadData];
            
           
            [self.segmentControl setSelectedSegmentIndex:1];
        }
    }
    else//show deafault the Passenger view controller
    {
        if ([sharedRoutesAsDriver.comingFromViewController isEqualToString:@"Driver"])
        {
            [(RequestedTripsViewController *)self.currentViewController comingFrom:@"Driver"];
            
        }
        else //Default show REQUESTED lifts
        {
            [(RequestedTripsViewController *)self.currentViewController comingFrom:@"Passenger"];
        }
       //? [self.segmentControl setSelectedSegmentIndex:0];
    }
    
        self.currentViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addChildViewController:self.currentViewController];
        [self addSubview:self.currentViewController.view toView:self.containerView];
    
        //[self.segmentControl setSelectedSegmentIndex:1];
        
//        //Clear it
//        sharedRoutes.comingFrom=@"";
//    }
    
    
}


#pragma mark Segment changed //Simulation buttons for notifications
- (IBAction)btn_notified_by_driver:(id)sender {
    sharedLiftNotified.notified_by_driver = YES;
    
}

- (IBAction)btn_notified_passenger:(id)sender {
    sharedLiftNotified.notified_by_driver = NO;
}

- (IBAction)segment_changed:(id)sender
{

    if (self.segmentControl.selectedSegmentIndex == 0)
    {
        self.label_requested.textColor = [UIColor whiteColor];
        self.label_offerred.textColor =  [UIColor grayColor];
        
        
        
     //   if (self.requestedTripsViewController== nil)
      //  {
            //if (sharedRoutesAsDriver.rides.count == 0)
            //{
                RequestedTripsViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Segment_Requested_Trips"];
            
   //         [self performSegueWithIdentifier:@"Segment_Requested_Trips" sender:self];
              
                [newViewController comingFrom:@"Passenger"];
                
                
                newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
                [self cycleFromViewController:self.currentViewController toViewController:newViewController];
                self.requestedTripsViewController = newViewController;
                self.currentViewController = newViewController;
       // }
        
            //}
//            else
//            {
//                //Display Lifts as Driver
//                NSLog(@"THERE ARE RIDES!");
//            }
//        }
//        else
//        {
//            self.currentViewController = self.requestedTripsViewController;
//        }
        
    }
    else
    {
      
        self.label_requested.textColor = [UIColor grayColor];
        self.label_offerred.textColor =  [UIColor whiteColor];
        
       // if (self.offeredTripsViewController == nil)
        //{
         //   [self performSegueWithIdentifier:@"Segment_Driver" sender:self];
        
        //RIDES or LIFTS for the Driver?
            if (sharedRoutesAsDriver.rides.count == 0)
           // if (sharedRoutesAsDriver.lifts.count == 0)
            {
               // UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Segment_Driver"];
                
               /* UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Segment_NoTripsFound"];
                
                newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
                [self cycleFromViewController:self.currentViewController toViewController:newViewController];
                self.offeredTripsViewController = newViewController;
                self.currentViewController = newViewController;*/
                
                
          /*      UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardOfferTripNavigationController"];
                
                newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
                [self cycleFromViewController:self.currentViewController toViewController:newViewController];
                self.offeredTripsViewController = newViewController;
                self.currentViewController = newViewController;
                
           */
                
                
                UIViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"storyboardOfferTripNavigationController"];//Segment_OfferedTrip"];
                
                newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
                
                                
                [self cycleFromViewController:self.currentViewController toViewController:newViewController];
                [newViewController performSegueWithIdentifier:@"segueOfferTrip" sender:self];
                
                self.offeredTripsViewController = newViewController;
                self.currentViewController = newViewController;
                
                /*
                self.driverViewController = newViewController;
                self.currentViewController = newViewController; 
                 */

                
            }
            else
            {
//                Now  (self.offeredTripsViewController != nil)
                //Display Lifts as Driver
                NSLog(@"THERE ARE RIDES AS DRIVER!");
                
                RequestedTripsViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Segment_Requested_Trips"];
                
                //         [self performSegueWithIdentifier:@"Segment_Requested_Trips" sender:self];
                
                [newViewController comingFrom:@"Driver"];
                
                newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
                [self cycleFromViewController:self.currentViewController toViewController:newViewController];
                self.requestedTripsViewController = newViewController;
                self.currentViewController = newViewController;

            }
       // }
        /*else
        {
            self.currentViewController = self.offeredTripsViewController;
        }*/
        
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


#pragma mark - End of Segment changed methods



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
