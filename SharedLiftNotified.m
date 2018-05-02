//
//  SharedLiftNotified.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH)  on 29/09/17.
//  Copyright © 2017 CERTH. All rights reserved.
//

#import "SharedLiftNotified.h"

@implementation SharedLiftNotified

+(SharedLiftNotified *) sharedLiftNotifiedObject;
{
    static dispatch_once_t once;
    static SharedLiftNotified *sharedLiftNotified;
    
    dispatch_once(&once, ^{
        sharedLiftNotified = [[self alloc] init];
    });
    
    return sharedLiftNotified;
}

@end
