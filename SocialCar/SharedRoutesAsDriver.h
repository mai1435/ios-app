//
//  SharedRoutesAsDriver.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH)on 24/07/17.
//  Copyright © 2017 Kostas Kalogirou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedRoutesAsDriver : NSObject

//1 lift has more than one trip and one trip has more than one steps

//May have many lifts
//@property (nonatomic,strong) NSMutableArray<Lifts *>* lifts;
@property (nonatomic,strong) NSMutableArray *lifts;

@property (nonatomic,strong) NSString *origin_address;
@property (nonatomic,strong) NSString *destination_address;

//Selected trip form TableView
@property  NSInteger lift_selected;

//Selected step form TableView
@property  NSInteger step_selected;

//Selected trip form TableView
@property  NSInteger ride_selected;

@property (nonatomic,strong) NSMutableArray *feedbackArray;

//@property (nonatomic,strong) NSMutableArray<Ride>
@property (nonatomic,strong) NSMutableArray *rides;
//Keep selected Driver in order to re-use its value
//@property Driver *selectedDriver;


@property (nonatomic,strong) NSString *routeCoordinates_polyline;



//For GUI purposes;if it comes from FindTrips call or from RetrieveLiftsAsPassenger
@property (nonatomic,strong) NSString *comingFromViewController;

+(SharedRoutesAsDriver *) sharedRoutesAsDriverObject;


@end
