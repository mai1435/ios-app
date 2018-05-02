//
//  ShareRoutes.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 23/06/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "ShareRoutes.h"

@implementation ShareRoutes

+(ShareRoutes *) sharedObject;
{
    static dispatch_once_t once;
    static ShareRoutes *sharedObject;
    
    //    NSString *no = NSLocalizedString(@"No", @"No");
    //    sharedObject.tableTravelModesValues = [NSMutableArray arrayWithObjects:no,no,no,no,no,no, nil];
    //  sharedObject.tableTravelModesValues = [NSMutableArray arrayWithCapacity:6];
    
    dispatch_once(&once, ^{
        sharedObject = [[self alloc] init];
    });
    
    return sharedObject;
}


@end
