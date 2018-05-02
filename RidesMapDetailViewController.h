//
//  RidesMapDetailViewController.h
//  SocialCar
//
//  Created by Vittorio Tauro on 22/03/18.
//  Copyright © 2018 Ab.Acus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Ride.h"

@interface RidesMapDetailViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) Ride *passedRide;

@end
