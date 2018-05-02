//
//  ParseObjects.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 03/07/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "ParseObjects.h"

@implementation ParseObjects


-(void)initWithValues
{
    thumbnails_transport = [NSArray arrayWithObjects:@"ic_directions_car", @"ic_directions_bus",@"ic_train",@"ic_tram",@"ic_directions_walk",@"ic_directions_car_purple",nil];
    
    commonData = [[CommonData alloc]init];
    [commonData initWithValues];
    
}

#pragma mark - miscellenaous for Step object; store Car and Driver data, and assign appropriate transport image
#pragma mark - put values to Car for the step
-(Steps *) assignCarValuesForStep:(Steps *)step withDictionary: (NSDictionary *)transport
{
    step.has_CAR_POOLING = YES;
    
    Car *car = [[Car alloc] init];
    
    car.ride_id = [transport valueForKey:@"ride_id"];
    NSDictionary *carDictionary = [transport valueForKey:@"car"];
    
    NSArray *pictures = [carDictionary valueForKey:PICTURES_];
    // NSDictionary *pictures = [parseJSON valueForKey:@"pictures"];
    if (pictures.count !=0 )
    {
        car.car_picture_id = [pictures[0] valueForKey:PICTURE_ID];
        
        car.car_picture_file = [pictures [0]valueForKey:PICTURE_FILE];
        
        ///---------------///
        //Now create URL to download image (URL: BASEURL_FOR_PICTURES/car_picture_file)
        NSString *ulrStr = commonData.BASEURL_FOR_PICTURES;
        ulrStr = [ulrStr stringByAppendingString:car.car_picture_file];
        
        NSLog(@"url of image=%@",ulrStr);
        
        NSURL *imageURLString = [NSURL URLWithString:ulrStr];
        
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageWithData:
                                                                           [NSData dataWithContentsOfURL:imageURLString]])];
        //Display it in the UIImage
        UIImage *image = [UIImage imageWithData:imageData];
        
        car.car_image = image;
    }
    
    car.car_id = [carDictionary valueForKey:ID_];
    car.model = [carDictionary valueForKey:MODEL_];
    car.plate = [carDictionary valueForKey:PLATE_];
    car.colour = [carDictionary valueForKey:COLOUR_];
    // NSString *seatsInt = [carDictionary valueForKey:SEATS_];
    car.seats = [carDictionary valueForKey:SEATS_];
    // car.seats = [NSString stringWithFormat:@"%i",seatsInt];
    
    NSDictionary *car_usage_preferences = [carDictionary valueForKey:CAR_USAGE_PREFERENCES];
    
    car.luggage = [car_usage_preferences valueForKey:LUGGAGE_TYPE];
    
    NSDictionary *foodAllowed= [car_usage_preferences valueForKey:FOOD_ALLOWED];
    NSString *foodAllowedStr = [NSString stringWithFormat:@"%@",foodAllowed];
    car.food = [foodAllowedStr boolValue ] ? @"Yes" : @"No" ;
    
    NSDictionary *smokingAllowed= [car_usage_preferences valueForKey:SMOKING_ALLOWED];
    NSString *smokingAllowedStr = [NSString stringWithFormat:@"%@",smokingAllowed];
    car.smoking = [smokingAllowedStr boolValue ] ? @"Yes" : @"No" ;
    
    NSDictionary *aircondition= [car_usage_preferences valueForKey:AIR_CONDITIONING];
    NSString *airconditionStr = [NSString stringWithFormat:@"%@",aircondition];
    car.air_conditioning = [airconditionStr boolValue ] ? @"Yes" : @"No" ;
    
    NSDictionary *petsAllowed= [car_usage_preferences valueForKey:PETS_ALLOWED];
    NSString *petsStr = [NSString stringWithFormat:@"%@",petsAllowed];
    car.pets = [petsStr boolValue ] ? @"Yes" : @"No" ;
    
    NSDictionary *childSeat= [car_usage_preferences valueForKey:CHILD_SEAT];
    NSString *childSeatStr = [NSString stringWithFormat:@"%@",childSeat];
    car.child_seat = [childSeatStr boolValue ] ? @"Yes" : @"No" ;
    
    NSDictionary *musicAllowed= [car_usage_preferences valueForKey:MUSIC_ALLOWED];
    NSString *musicAllowedStr = [NSString stringWithFormat:@"%@",musicAllowed];
    car.music = [musicAllowedStr boolValue ] ? @"Yes" : @"No" ;
    
    [step.cars addObject:car];
    
    //  [self assignDriverValuesForStep:step withDictionary:transport];
    
    return step;
    
}

#pragma mark - put values to Driver for the step
-(Steps *) assignDriverValuesForStep:(Steps *)step withDictionary: (NSDictionary *)transport
{
    
    Driver *driver = [[Driver alloc] init];
    NSDictionary *driverDictionary = [transport valueForKey:@"driver"];
    
    driver.userID = [driverDictionary valueForKey:@"_id"];
    driver.email = [driverDictionary valueForKey:@"email"];
    driver.password = [driverDictionary valueForKey:@"password"];
    driver.user_name = [driverDictionary valueForKey:@"name"];
    driver.phone = [driverDictionary valueForKey:@"phone"];
    driver.dateofBirth = [driverDictionary valueForKey:@"dob"];
    driver.gender = [driverDictionary valueForKey:@"gender"];
    
    NSDictionary *social_provider = [driverDictionary valueForKey:@"social_provider"];
    
    NSString *social_network = [social_provider valueForKey:@"social_network"];
    if ([social_network isEqualToString:SOCIAL_NETWORK_FACEBOOK])
    {
        driver.useFacebook = YES;
        driver.facebook_id = [social_provider valueForKey:@"social_id"];
    }
    
    //Assign car values to the driver
    NSArray *cars = [driverDictionary valueForKey:@"cars"];
    
    if (cars.count!=0)
    {
        driver.hasCar = YES;
        driver.cars  = [[NSMutableArray alloc]initWithCapacity:cars.count];
        
        for (int i=0;i<cars.count;i++)
        {
            // sharedProfile.cars  = [NSMutableArray arrayWithObjects:cars[,no,no,no,no, nil];
            [driver.cars addObject:cars[i]];
        }
        driver.car_last_id = [driver.cars lastObject]; //Get the last object
    }
    
    
    NSArray *pictures = [driverDictionary valueForKey:@"pictures"];
    // NSDictionary *pictures = [parseJSON valueForKey:@"pictures"];
    if (pictures.count !=0 )
    {
        driver.picture_id = [pictures[0] valueForKey:PICTURE_ID];//]@"_id"];
        driver.picture_file = [pictures [0]valueForKey:PICTURE_FILE];//]@"file"];
        
        ///---------------///
        //Now create URL to download image
        NSString *ulrStr = commonData.BASEURL_FOR_PICTURES;
        ulrStr = [ulrStr stringByAppendingString:driver.picture_file];
        
        NSURL *imageURLString = [NSURL URLWithString:ulrStr];
        
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation([UIImage imageWithData:
                                                                           [NSData dataWithContentsOfURL:imageURLString]])];
        //Display it in the UIImage
        UIImage *image = [UIImage imageWithData:imageData];
        
        driver.user_image = image;
        
    }
    
    driver.rating  = [ [driverDictionary valueForKey:@"rating"] stringValue];
    
    NSDictionary *travel_preferences = [driverDictionary valueForKey:@"travel_preferences"];
    
    driver.max_no_transfers  = [ [travel_preferences valueForKey:@"max_transfers"] stringValue];
  //  NSLog(@"max_transfers=%@", [travel_preferences valueForKey:@"max_transfers"]);
    
    driver.max_cost  = [ [travel_preferences valueForKey:@"max_cost"] stringValue];
    
    driver.max_distance  = [ [travel_preferences valueForKey:@"max_walk_distance"] stringValue];
    
    driver.carpooler_age  =  [travel_preferences valueForKey:@"carpooler_preferred_age_group"]; //stringValue];
    
    driver.carpooler_gender  = [travel_preferences valueForKey:@"carpooler_preferred_gender"];
    
    //Convert NSNumber value to BOOL and then String
    driver.gps_tracking =  [[travel_preferences valueForKey:@"gps_tracking"]  boolValue ] ? @"Yes" : @"No" ;
    
    driver.luggage =  [[travel_preferences valueForKey:@"luggage"]  boolValue ] ? @"Yes" : @"No" ;
    
    driver.pets =  [[travel_preferences valueForKey:@"pets"]  boolValue ] ? @"Yes" : @"No" ;
    
    driver.smoking =  [[travel_preferences valueForKey:@"smoking"]  boolValue ] ? @"Yes" : @"No" ;
    
    driver.food =  [[travel_preferences valueForKey:@"food"]  boolValue ] ? @"Yes" : @"No" ;
    
    driver.music =  [[travel_preferences valueForKey:@"music"]  boolValue ] ? @"Yes" : @"No" ;
    
    //End of converting NSNumber value to BOOL and then String
    
    
    //Compare NSMutuableArray with CommonData
    //and store "Yes" or "No" value respectively
    //          commonData = [[CommonData alloc]init];
    //          [commonData initWithValues];
    
    NSString *yes = NSLocalizedString(@"Yes", @"Yes");
    NSString *no = NSLocalizedString(@"No", @"No");
    
    //Copy NSArray values to NSMutableArray
    //tableOptimiseTravelSolutions
    NSArray *optimisationArray = [travel_preferences valueForKey:@"optimisation"];
    
    //Initialise NSMutableArray with "No" values
    //if (sharedProfile.tableOptimiseTravelSolutions == nil)
    driver.tableOptimiseTravelSolutions = [NSMutableArray arrayWithObjects:no,no,no,no,no, nil];
    
    for (int j=0;j<commonData.tableOptimiseTravelSolutions.count;j++)
    {
        for (int i=0;i<optimisationArray.count;i++)
        {
            if ([optimisationArray[i] isEqualToString:commonData.tableOptimiseTravelSolutions[j]])
            {
                [driver.tableOptimiseTravelSolutions replaceObjectAtIndex:j withObject:yes];
                
                break;
            }
        }
    }
    
    //Copy NSArray values to NSMutableArray
    //tableOptimiseTravelSolutions
    NSArray *tableTravelModesValues = [travel_preferences valueForKey:@"preferred_transport"];
    
    //Initialise NSMutableArray with "No" values
    // if (sharedProfile.tableTravelModesValues == nil)
    driver.tableTravelModesValues = [NSMutableArray arrayWithObjects:no,no,no,no,no,no, nil];
    
    for (int j=0;j<commonData.tableTravelModes.count;j++)
    {
        for (int i=0;i<tableTravelModesValues.count;i++)
        {
            if ([tableTravelModesValues[i] isEqualToString:commonData.tableTravelModes[j]])
            {
                [driver.tableTravelModesValues replaceObjectAtIndex:j withObject:yes ];
                
                break;
            }
        }
    }
    
    //Copy NSArray values to NSMutableArray
    //tableOptimiseTravelSolutions
    NSArray *tableSpecialNeeds = [travel_preferences valueForKey:@"special_request"];
    
    //Initialise NSMutableArray with "No" values
    //if (sharedProfile.tableSpecialNeeds == nil)
    driver.tableSpecialNeeds = [NSMutableArray arrayWithObjects:no,no,no,no, nil];
    
    for (int j=0;j<commonData.tableSpecialNeeds.count;j++)
    {
        for (int i=0;i<tableSpecialNeeds.count;i++)
        {
            if ([tableSpecialNeeds[i] isEqualToString:commonData.tableSpecialNeeds[j]])
            {
                [driver.tableSpecialNeeds replaceObjectAtIndex:j withObject:yes];
                break;
            }
        }
    }
    
    
    [step.driver addObject:driver];
    
    return step;
}

#pragma mark - get the transport type image
-(UIImage *) get_transport_image : (NSString *)transportType withCarPoolingProvider:(BOOL)isExternalProviderAvailable
{
    //thumbnails_transport = [NSArray arrayWithObjects:@"ic_directions_car", @"ic_directions_bus",@"ic_train",@"ic_tram","ic_directions_walk",nil];
    UIImage *image_tranport = [[UIImage alloc]init];
    
    if ([transportType isEqualToString:TRANSPORT_CAR_POOLING])
    {
        // cell.image_transport.image = [UIImage imageNamed:[thumbnails_transport objectAtIndex:0]];
        if (isExternalProviderAvailable)
        {
            image_tranport = [UIImage imageNamed:[thumbnails_transport objectAtIndex:0]];
        }
        else
        {
            image_tranport = [UIImage imageNamed:[thumbnails_transport objectAtIndex:5]];
        }
    }
    else if ([transportType isEqualToString:TRANSPORT_BUS])
    {
        //cell.image_transport.image = [UIImage imageNamed:[thumbnails_transport objectAtIndex:1]];
        image_tranport = [UIImage imageNamed:[thumbnails_transport objectAtIndex:1]];
    }
    else if ([transportType isEqualToString:TRANSPORT_RAIL])
    {
        image_tranport = [UIImage imageNamed:[thumbnails_transport objectAtIndex:2]];
    }
    else if ([transportType isEqualToString:TRANSPORT_TRAM])
    {
        image_tranport = [UIImage imageNamed:[thumbnails_transport objectAtIndex:3]];
    }
    else if ([transportType isEqualToString:TRANSPORT_FEET])
    {
        image_tranport = [UIImage imageNamed:[thumbnails_transport objectAtIndex:4]];
    }
    
    return image_tranport;
    
}


@end
