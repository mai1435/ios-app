//
//  TripsRetrieved.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 24/06/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TripRetrieved : NSObject

@property (nonatomic,strong) NSString *total_duration;

@property (nonatomic,strong) NSString *total_price;
@property (nonatomic,strong) NSString *currency;
//@property (nonatomic,strong) NSMutableArray *stepsAfter;
//@property  NSInteger stepsLength;


@end
