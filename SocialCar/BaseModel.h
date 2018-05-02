//  Copyright © 2018 foofastudios. All rights reserved.

#import <Foundation/Foundation.h>
#import "MyTools.h"

#define UNDEFINED_INTEGER -99999


@interface BaseModel : NSObject


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)asDictionary;

+ (NSArray *)listFromRawList:(NSArray *)rawList;
+ (NSArray *)rawListFromList:(NSArray *)list;


@end
