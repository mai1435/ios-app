//
//  RidesMapDetailViewController.m
//  SocialCar
//
//  Created by Vittorio Tauro on 22/03/18.
//  Copyright © 2018 Ab.Acus. All rights reserved.
//

#import "RidesMapDetailViewController.h"

@interface RidesMapDetailViewController ()

@end

@implementation RidesMapDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.mapView.delegate = self;
	
	MKPolyline *polyline = [self polylineWithEncodedString:self.passedRide.polyline];
	[self.mapView addOverlay:polyline];
	[self zoomToPolyLine:self.mapView polyline:polyline animated:NO];

    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - decode the Google Directions API polylines field into lat long points in objective-C, see https://stackoverflow.com/questions/9217274/how-to-decode-the-google-directions-api-polylines-field-into-lat-long-points-in

-(MKPolyline *)polylineWithEncodedString:(NSString *)encodedString
{
	const char *bytes = [encodedString UTF8String];
	NSUInteger length = [encodedString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
	NSUInteger idx = 0;
	
	NSUInteger count = length / 4;
	CLLocationCoordinate2D *coords = calloc(count, sizeof(CLLocationCoordinate2D));
	NSUInteger coordIdx = 0;
	
	float latitude = 0;
	float longitude = 0;
	while (idx < length) {
		char byte = 0;
		int res = 0;
		char shift = 0;
		
		do {
			byte = bytes[idx++] - 63;
			res |= (byte & 0x1F) << shift;
			shift += 5;
		} while (byte >= 0x20);
		
		float deltaLat = ((res & 1) ? ~(res >> 1) : (res >> 1));
		latitude += deltaLat;
		
		shift = 0;
		res = 0;
		
		do {
			byte = bytes[idx++] - 0x3F;
			res |= (byte & 0x1F) << shift;
			shift += 5;
		} while (byte >= 0x20);
		
		float deltaLon = ((res & 1) ? ~(res >> 1) : (res >> 1));
		longitude += deltaLon;
		
		float finalLat = latitude * 1E-5;
		float finalLon = longitude * 1E-5;
		
		CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(finalLat, finalLon);
		coords[coordIdx++] = coord;
		
		if (coordIdx == count) {
			NSUInteger newCount = count + 10;
			coords = realloc(coords, newCount * sizeof(CLLocationCoordinate2D));
			count = newCount;
		}
	}
	
	MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coords count:coordIdx];
	free(coords);
	
	return polyline;
}


-(void)zoomToPolyLine: (MKMapView*)map polyline: (MKPolyline*)polyline animated: (BOOL)animated
{
	
	//top left bottom right
	[map setVisibleMapRect:[polyline boundingMapRect] edgePadding:UIEdgeInsetsMake(15.0, 20.0, 15.0, 20.0) animated:animated];
	
}

#pragma mark MKMapViewDelegate
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
	MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
	renderer.strokeColor = [UIColor blueColor];
	renderer.lineWidth = 5.0;
	
	
	[self zoomToPolyLine:mapView polyline:renderer.polyline animated:NO];
	
	return renderer;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
