//  Copyright © 2018 foofastudios. All rights reserved.

#import "BaseModel.h"


#define SERVER_DATE_FORMAT @"yyyy-MM-dd HH:mm:ss"


@implementation BaseModel


- (instancetype)initWithDictionary:(NSDictionary *)dictionar
{
    return nil;
}

- (NSDictionary *)asDictionary
{
    return nil;
}

+ (NSArray *)listFromRawList:(NSArray *)rawList
{
    if (!rawList) return @[];
    
    NSMutableArray *list = [[NSMutableArray alloc] init];
    for (NSDictionary *rawElem in rawList)
    {
        id elem = [[[self class] alloc] initWithDictionary:rawElem];
        if (elem)
        {
            [list addObject:elem];
        }
    }
    return [[NSArray alloc] initWithArray:list];
}

+ (NSArray *)rawListFromList:(NSArray *)list
{
    if (!list) return @[];
    
    NSMutableArray *rawList = [[NSMutableArray alloc] init];
    for (BaseModel *elem in list)
    {
        NSDictionary *rawElem = [elem asDictionary];
        if (rawElem)
        {
            [rawList addObject:rawElem];
        }
    }
    return [[NSArray alloc] initWithArray:rawList];
}


@end
