//
//  BaseRModel.m
//  shadappmessenger
//
//  Created by Luca Comanducci on 17/05/17.
//  Copyright © 2017 Vittorio Tauro. All rights reserved.
//

#import "BaseRModel.h"


@implementation BaseRModel


- (id)init
{
    self = [super init];
    if (self)
    {
        [self initialize];
    }
    return self;
}

- (void)initialize
{

}

- (void)setPropertiesWithRawDictionary:(NSDictionary *)dict
{

}

+ (RLMObject *)currentInRealm:(RLMRealm *)realm
{
    Class class = [self class];
    
    id obj = [[class allObjectsInRealm:realm] firstObject];
    
    if (!obj)
    {
        obj = [[class alloc] init];
        
        [realm transactionWithBlock:^{
            [realm addObject:obj];
        }];
    }
    
    return obj;
}


+ (RLMObject *)current
{
    return [self currentInRealm:[RLMRealm defaultRealm]];
}


@end
