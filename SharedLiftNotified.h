//
//  SharedLiftNotified.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH)  on 29/09/17.
//  Copyright © 2017 CERTH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lift.h"

@interface SharedLiftNotified : NSObject

@property Lift *notified_lift;
@property BOOL notified_by_driver;

+(SharedLiftNotified *) sharedLiftNotifiedObject;

@end

