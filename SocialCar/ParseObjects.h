//
//  ParseObjects.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 03/07/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Driver.h"
#import "Steps.h"
#import "Car.h"
#import "CommonData.h"


@interface ParseObjects : NSObject
{
    NSArray *thumbnails_transport;
    CommonData *commonData;
}

-(void)initWithValues;
-(Steps *) assignCarValuesForStep:(Steps *)step withDictionary: (NSDictionary *)transport;
-(Steps *) assignDriverValuesForStep:(Steps *)step withDictionary: (NSDictionary *)transport;
-(UIImage *) get_transport_image : (NSString *)transportType withCarPoolingProvider:(BOOL)isExternalProviderAvailable;


@end
