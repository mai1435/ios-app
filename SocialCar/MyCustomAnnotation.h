//
//  MKAnnotationProtocol.h
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 13/02/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyCustomAnnotation : NSObject <MKAnnotation>

@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property(nonatomic, readonly, copy) NSString *title;

@property int posInArray;


-(id)initWithTitle:(NSString *)newTitle Location:(CLLocationCoordinate2D) location;
//-(void)setTitle:(NSString *)title;
//-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
//-(MKAnnotationView *)annotationView : (int) addressStatus;

@end
