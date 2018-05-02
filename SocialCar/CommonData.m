//
//  CommonData.m
//  SocialCar
//
//  Created by Kostas Kalogirou(CERTH) on 31/03/17.
//  Copyright © 2017 Kostas Kalogirou(CERTH). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonData.h"


@interface CommonData ()

@end

@implementation CommonData



-(void)initWithValues
{

    //Official Server with HTTPS
    self.BASEURL = @"*";
    
    self.BASEURL_FOR_PICTURES = @"*";
    
    self.BASEURL_FOR_FEEDBACKS = @"*";
    
    self.ROLE_DRIVER=@"&role=driver";
    self.ROLE_PASSENGER=@"&role=passenger";
    
    self.URL_users = @"users/";
    
    self.BASEURL_LIFTS_DRIVER = @"*";
    self.BASEURL_LIFTS_PASSENGER = @"*";
    self.BASEURL_CREATE_LIFTS = @"*";
    self.BASEURL_FOR_TRIPS = @"*";
    
    self.BASEURL_CREATE_FEEDBACK = @"*";
    
	self.BASEURL_CREATE_FEEDBACKS = @"*";
	self.BASEURL_SEND_POSITION = @"*";

    
    self.BASEURL_CREATE_RIDES = @"*";
    
    self.BASEURL_RETRIEVE_RIDES = @"*";
    self.BASEURL_RETRIEVE_REPORTS = @"*";
    self.BASEURL_CREATE_REPORT = @"*";
	self.BASEURL_CHAT = @"*";

    self.BASEURL_UDATE_LIFTS = self.BASEURL_CREATE_LIFTS;
    
    self.URL_user_pictures = @"*";
    self.URL_cars = @"*";
    self.URL_car_pictures = @"*";

    //////
    
   
    self.notAvailable = NSLocalizedString(@"N/A", @"N/A");
    
    //Table data for Travel Modes
    NSString *bus = NSLocalizedString(@"BUS", @"BUS");
    NSString *car_pooling = NSLocalizedString(@"CAR_POOLING", @"CAR_POOLING");
    NSString *feet = NSLocalizedString(@"FEET", @"FEET");
    NSString *metro = NSLocalizedString(@"METRO", @"METRO");
    NSString *rail = NSLocalizedString(@"RAIL", @"RAIL");
    NSString *tram = NSLocalizedString(@"TRAM", @"TRAM");
    
    self.tableTravelModes = [NSArray arrayWithObjects:bus,car_pooling,feet,metro,rail,tram, nil];
    
    //Table Data for Optimise Travel Solutions
    NSString *cheapest = NSLocalizedString(@"CHEAPEST", @"CHEAPEST");
    NSString *comfort = NSLocalizedString(@"COMFORT", @"COMFORT");
    NSString *fastest = NSLocalizedString(@"FASTEST", @"FASTEST");
    NSString *safest = NSLocalizedString(@"SAFEST", @"SAFEST");
    NSString *shortest = NSLocalizedString(@"SHORTEST", @"SHORTEST");
    
    self.tableOptimiseTravelSolutions = [NSArray arrayWithObjects:cheapest,comfort,fastest,safest,shortest, nil];
    
    
    //Table Data for Special Needs
    NSString *wheelchair = NSLocalizedString(@"WHEELCHAIR", @"WHEELCHAIR");
    NSString *deaf = NSLocalizedString(@"DEAF", @"DEAF");
    NSString *blind = NSLocalizedString(@"BLIND", @"BLIND");
    NSString *elderly = NSLocalizedString(@"ELDERLY", @"ELDERLY");
    
    self.tableSpecialNeeds = [NSArray arrayWithObjects:wheelchair,deaf,blind,elderly,nil];
    
   // NSString *s= TRAVEL_MODES;
    //NSLog(@"%@",s);
    
    //Table data for luggage type
    NSString *small = NSLocalizedString(@"SMALL", @"SMALL");
    NSString *medium = NSLocalizedString(@"MEDIUM", @"MEDIUM");
    NSString *large = NSLocalizedString(@"LARGE", @"LARGE");
    NSString *no = NSLocalizedString(@"NO", @"NO");
    
    self.arrayChoicesLuggageTypes = [NSArray arrayWithObjects:small,medium,large,no, nil];
    
    //Table data for filters
    self.tableFilters = [NSArray arrayWithObjects:bus, car_pooling, metro, rail, tram,cheapest, fastest, nil];
}


@end
