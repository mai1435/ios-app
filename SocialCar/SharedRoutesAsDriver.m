//
//  SharedRoutesAsDriver.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH)on 24/07/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import "SharedRoutesAsDriver.h"

@implementation SharedRoutesAsDriver

+(SharedRoutesAsDriver *) sharedRoutesAsDriverObject;
{
    static dispatch_once_t once;
    static SharedRoutesAsDriver *sharedRoutesAsDriverObject;
    
    //    NSString *no = NSLocalizedString(@"No", @"No");
    //    sharedObject.tableTravelModesValues = [NSMutableArray arrayWithObjects:no,no,no,no,no,no, nil];
    //  sharedObject.tableTravelModesValues = [NSMutableArray arrayWithCapacity:6];
    
    dispatch_once(&once, ^{
        sharedRoutesAsDriverObject = [[self alloc] init];
    });
    
    return sharedRoutesAsDriverObject;
}


@end
