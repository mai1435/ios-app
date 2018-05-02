//
//  MyTripsNavigationConroller.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 04/07/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RouteDetailsStatusViewController.h"
#import "DriverDetailsViewController.h"
#import "RidesViewController.h";

@interface MyTripsNavigationController : UINavigationController
{
    NSString *comingFromViewController;
}

- (void)comingFrom:(NSString *)viewControllerStr;

@end
