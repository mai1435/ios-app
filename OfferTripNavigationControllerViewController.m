//
//  OfferTripNavigationControllerViewController.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH)on 25/07/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import "OfferTripNavigationControllerViewController.h"
#import "AddressesTableViewController.h"

@interface OfferTripNavigationControllerViewController ()

@end

@implementation OfferTripNavigationControllerViewController

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
    //Segment_OfferedTrip
    
    
    if  ([segue.identifier isEqualToString:@"segueSetAddresses"])
    {
        HomePassengerViewController *homePassengerViewController = (HomePassengerViewController *) [segue destinationViewController];
        
        [homePassengerViewController comingFrom:@"Segment_OfferedTrip"];
        
    }
    else if ([segue.identifier isEqualToString:@"segueSelectAddress"])
    {
        AddressesTableViewController *addressesTableViewController = (AddressesTableViewController *) [segue destinationViewController];
        
        [addressesTableViewController comingFrom:@"Segment_OfferedTrip"];
        
    }

}


@end
