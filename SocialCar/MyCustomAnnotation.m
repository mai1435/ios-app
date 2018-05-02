//
//  MKAnnotationProtocol.m
//  SocialCar
//
//  Created by Kostas Kalogirou (CERTH) on 13/02/17.
//  Copyright © 2017 Kostas Kalogirou (CERTH). All rights reserved.
//

#import "MyCustomAnnotation.h"


@implementation MyCustomAnnotation

-(id)initWithTitle:(NSString *)newTitle Location:(CLLocationCoordinate2D) location
{
    self = [super init];
    
    if (self)
    {
        _title = newTitle;
        _coordinate = location;
    }
    
    return self;
}

/*
-(void)setTitle:(NSString *)title
{
    self.title = title;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    self.coordinate = newCoordinate;
}
 */

//-(MKAnnotationView *)annotationView : (int) addressStatus
//{
//    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:_title];//]@"MyCustomAnnotation"];
//    
//    annotationView.enabled = YES;
//    annotationView.canShowCallout = YES;
//    annotationView.image = [UIImage imageNamed:@"ic_starting_point.png"];
//
//   
//    if (addressStatus == 0)
//    {
//        annotationView.image = [UIImage imageNamed:@"ic_starting_point.png"];
//    }
//    else if (addressStatus == 1)
//    {
//        annotationView.image = [UIImage imageNamed:@"ic_destination_point.png"];
//    }
//    
//    return annotationView;
//}


-(void) setPosiInArray:(int)pos
{
    _posInArray = pos;
}

-(int) getPosInArray
{
    return _posInArray;
}

@end
