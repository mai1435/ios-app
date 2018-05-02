//
//  BaseRModel.h
//  shadappmessenger
//
//  Created by Luca Comanducci on 17/05/17.
//  Copyright © 2017 Vittorio Tauro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>


@interface BaseRModel : RLMObject


- (void)initialize;

- (void)setPropertiesWithRawDictionary:(NSDictionary *)dict;

+ (RLMObject *)currentInRealm:(RLMRealm *)realm;
+ (RLMObject *)current;


@end
