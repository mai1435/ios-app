//
//  RMessage.m
//  shadappmessenger
//
//  Created by Luca Comanducci on 21/06/17.
//  Copyright © 2017 Vittorio Tauro. All rights reserved.
//

#import "RPosition.h"


@implementation RPosition


- (void)initialize
{
    [super initialize];
    
    self.lng = 0;
    self.lat = 0;
    self.timestamp = @"";
	
}

- (void)setPropertiesWithRawDictionary:(NSDictionary *)dict
{
    if (dict)
    {        
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            
			
        }];
    }
}


@end
