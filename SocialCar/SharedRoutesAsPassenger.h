//
//  SharedRoutesAsPassenger.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 03/07/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Steps.h"
#import "Lift.h"
#import "Driver.h"


@interface SharedRoutesAsPassenger : NSObject

//1 lift has more than one trip and one trip has more than one steps

//May have many lifts
//@property (nonatomic,strong) NSMutableArray<Lifts *>* lifts;
@property (nonatomic,strong) NSMutableArray *lifts;

//Selected trip form TableView
@property  NSInteger lift_selected;

//Selected step form TableView
@property  NSInteger step_selected;

@property (nonatomic,strong) NSMutableArray *feedbackArray;

//Keep selected Driver in order to re-use its value
//@property Driver *selectedDriver;


//For GUI purposes;if it comes from FindTrips call or from RetrieveLiftsAsPassenger
@property (nonatomic,strong) NSString *comingFromViewController;

+(SharedRoutesAsPassenger *) sharedRoutesAsPassengerObject;

@end
