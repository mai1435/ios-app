//
//  OfferTripViewController.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH)on 25/07/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePassengerViewController.h"
#import "ExternalCarpoolerViewController.h"
#import "OfferTripNavigationControllerViewController.h"
#import "SharedProfileData.h"


@interface OfferTripViewController : UIViewController
{
    SharedProfileData *sharedProfileData;
}

@property (strong, nonatomic) IBOutlet UILabel *label_no_trips;

@property (strong, nonatomic) IBOutlet UIButton *btn_offerTrip;

@property BOOL isFirstTime;

- (IBAction)btn_offerTrip_pressed:(id)sender;


@end
