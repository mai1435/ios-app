//
//  Steps.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 24/06/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "Steps.h"

@implementation Steps

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.cars = [[NSMutableArray alloc]init];
        self.driver = [[NSMutableArray alloc]init];
        self.intermediate_points = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
