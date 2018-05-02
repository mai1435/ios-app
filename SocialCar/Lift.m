//
//  Lift.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 03/07/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "Lift.h"

@implementation Lift


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.steps = [[NSMutableArray alloc]init];
        
    }
    return self;
}


@end
