//
//  MyTripsNavigationConroller.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 04/07/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "MyTripsNavigationController.h"

@interface MyTripsNavigationController ()

@end

@implementation MyTripsNavigationController


- (void)comingFrom:(NSString *)viewControllerStr
{
    comingFromViewController = viewControllerStr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if   ([segue.identifier isEqualToString:@"showLiftStepDetails"]) // ||          ([segue.identifier isEqualToString:@"showMyTripsNavigatorSegue"]) )
    {
        RouteDetailsStatusViewController *routeDetailsStatusViewController = ( RouteDetailsStatusViewController *)[segue destinationViewController];
        //[routeDetailsStatusViewController comingFrom:@"RetrieveLifts"];
       
        if ( [comingFromViewController isEqualToString:@"Driver"] )
        {
            [routeDetailsStatusViewController comingFrom:@"Driver"];
        }
        else if ( [comingFromViewController isEqualToString:@"Passenger"] )
        {
            [routeDetailsStatusViewController comingFrom:@"Passenger"];
        }
        
    }
    else if ([segue.identifier isEqualToString:@"showSegueDriverDetailsFromLifts"])
    {
        DriverDetailsViewController *driverDetailsViewController = (DriverDetailsViewController *)[segue destinationViewController];
       // [driverDetailsViewController comingFrom:@"RetrieveLifts"];
        if ( [comingFromViewController isEqualToString:@"Driver"] )
        {
            [driverDetailsViewController comingFrom:@"Driver"];
        }
        else if ( [comingFromViewController isEqualToString:@"Passenger"] )
        {
            [driverDetailsViewController comingFrom:@"Passenger"];
        }
        
    }//showMyTripsNavigatorSegue
    else if ([segue.identifier isEqualToString:@"segueShowRides"])
    {
        RidesViewController *ridesViewController = (RidesViewController *) [segue destinationViewController];
        
        
    }
    //else if
//
}

@end
