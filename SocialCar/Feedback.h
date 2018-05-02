//
//  Feedback.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 29/06/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ratings.h"

@interface Feedback : NSObject
{
    Ratings *ratings;
}


@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *reviewer_id;

@property (nonatomic,strong) NSDictionary *ratings;
//For driver
@property (nonatomic,strong) NSString *punctuation;
@property (nonatomic,strong) NSString *satisfaction_level;
@property (nonatomic,strong) NSString *carpooler_behaviour;
//For passenger
@property (nonatomic,strong) NSString *comfort_level;
@property (nonatomic,strong) NSString *driving_behaviour;
@property (nonatomic,strong) NSString *duration;
@property (nonatomic,strong) NSString *route_rating;

@property (nonatomic,strong) NSString *role;
@property (nonatomic,strong) NSString *reviewed_id;
@property (nonatomic,strong) NSString *lift_id;
@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *reviewed_name;
@property (nonatomic,strong) NSString *review; //the comments
@property (nonatomic,strong) NSString *reviewer;
@property (nonatomic,strong) NSString *rating;






//"_id": "58f611bce04bd520a7e0dd1d",
//"reviewer_id": "58e1f4f8e04bd507d11d9f77",
/*"ratings": {
    "punctuation": 2,
    "satisfaction_level": 2,
    "carpooler_behaviour": 3
},*/
//"role": "driver",
//"reviewed_id": "58d3ac61e04bd5249b4f6608",
//"lift_id": "58e4a969e04bd54a04d75bbf",
//"date": 1492521404,
/*reviewed_name": "Jim Tsoukalas",
"review": "toohf",
"reviewer": "Nikolett Kovacs",
"rating": 2
*/

@end
