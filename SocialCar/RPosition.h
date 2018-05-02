//
//  RMessage.h
//  shadappmessenger
//
//  Created by Luca Comanducci on 21/06/17.
//  Copyright © 2017 Vittorio Tauro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseRModel.h"


@interface RPosition : BaseRModel

@property float lng;
@property float lat;
@property NSString *timestamp;

- (void)setPropertiesWithRawDictionary:(NSDictionary *)dict;

@end
