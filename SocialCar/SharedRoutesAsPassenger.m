//
//  SharedRoutesAsPassenger.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 03/07/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "SharedRoutesAsPassenger.h"

@implementation SharedRoutesAsPassenger


+(SharedRoutesAsPassenger *) sharedRoutesAsPassengerObject;
{
    static dispatch_once_t once;
    static SharedRoutesAsPassenger *sharedRoutesAsPassenger;
    
    //    NSString *no = NSLocalizedString(@"No", @"No");
    //    sharedObject.tableTravelModesValues = [NSMutableArray arrayWithObjects:no,no,no,no,no,no, nil];
    //  sharedObject.tableTravelModesValues = [NSMutableArray arrayWithCapacity:6];
    
    dispatch_once(&once, ^{
        sharedRoutesAsPassenger = [[self alloc] init];
    });
    
    return sharedRoutesAsPassenger;
}


@end


