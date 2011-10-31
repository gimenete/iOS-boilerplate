//
//  DirectionsExample.m
//  IOSBoilerplate
//
//  Copyright (c) 2011 Alberto Gimeno Brieba
//  
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//  
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//  

#import "DirectionsExample.h"
#import "StringHelper.h"
#import "AFHTTPRequestOperation.h"

@implementation DirectionsExample

@synthesize routeLine;
@synthesize source;
@synthesize destination;
@synthesize map;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
		MKPinAnnotationView* pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
		pin.canShowCallout = YES;
		if (annotation == source) {
			pin.pinColor = MKPinAnnotationColorGreen;
		} else {
			pin.pinColor = MKPinAnnotationColorRed;
		}
		return [pin autorelease];
	}
	return nil;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id )overlay {
	MKPolylineView* routeLineView = [[[MKPolylineView alloc] initWithPolyline:self.routeLine] autorelease];
	routeLineView.fillColor = [UIColor colorWithRed:0.0f green:0.0f blue:1.0f alpha:0.5f];
	routeLineView.strokeColor = [UIColor colorWithRed:0.0f green:0.0f blue:1.0f alpha:0.5f];
	routeLineView.lineWidth = 4;
	return routeLineView;
}

#pragma mark -
#pragma mark Directions

- (void) setRoutePoints:(NSArray*)locations {
	MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * locations.count);
	NSUInteger i, count = [locations count];
	for (i = 0; i < count; i++) {
		CLLocation* obj = [locations objectAtIndex:i];
		MKMapPoint point = MKMapPointForCoordinate(obj.coordinate);
		pointArr[i] = point;
	}
	
	if (routeLine) {
		[map removeOverlay:routeLine];
	}
	
	self.routeLine = [MKPolyline polylineWithPoints:pointArr count:locations.count];
	free(pointArr);
	
	[map addOverlay:routeLine];
	
	
	CLLocationDegrees maxLat = -90.0f;
	CLLocationDegrees maxLon = -180.0f;
	CLLocationDegrees minLat = 90.0f;
	CLLocationDegrees minLon = 180.0f;
	
	for (int i = 0; i < locations.count; i++) {
		CLLocation *currentLocation = [locations objectAtIndex:i];
		if(currentLocation.coordinate.latitude > maxLat) {
			maxLat = currentLocation.coordinate.latitude;
		}
		if(currentLocation.coordinate.latitude < minLat) {
			minLat = currentLocation.coordinate.latitude;
		}
		if(currentLocation.coordinate.longitude > maxLon) {
			maxLon = currentLocation.coordinate.longitude;
		}
		if(currentLocation.coordinate.longitude < minLon) {
			minLon = currentLocation.coordinate.longitude;
		}
	}
	
	MKCoordinateRegion region;
	region.center.latitude     = (maxLat + minLat) / 2;
	region.center.longitude    = (maxLon + minLon) / 2;
	region.span.latitudeDelta  = maxLat - minLat;
	region.span.longitudeDelta = maxLon - minLon;
	
	[map setRegion:region animated:YES];
}

- (void)drawRoute:(NSMutableDictionary *)response
{
	NSMutableArray* coordinates = [response objectForKey:@"coordinates"];
	
	NSMutableArray* aux = [[NSMutableArray alloc] initWithCapacity:[coordinates count]];
	for (NSMutableDictionary* dict in coordinates) 
	{
		NSNumber* lat = [dict objectForKey:@"lat"];
		NSNumber* lon = [dict objectForKey:@"lon"];
		
		CLLocation* location = [[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[lon doubleValue]];
		[aux addObject:location];
		[location release];
	}
	
	[self setRoutePoints:aux];
	[aux release];
}

- (void)calculateDirections {
	CLLocationCoordinate2D f = source.coordinate;
	CLLocationCoordinate2D t = destination.coordinate;
	NSString* saddr = [NSString stringWithFormat:@"%f,%f", f.latitude, f.longitude];
	NSString* daddr = [NSString stringWithFormat:@"%f,%f", t.latitude, t.longitude];
	
	NSString* urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?output=dragdir&saddr=%@&daddr=%@&hl=%@", saddr, daddr, [[NSLocale currentLocale] localeIdentifier]];
    // by car:
    // urlString = [urlString stringByAppendingFormat:@"&dirflg=w"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
    operation.completionBlock = ^ {
        @try {
            NSData* data = operation.responseData;
            NSString* responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            // TODO: better parsing. Regular expression?
            
            NSInteger a = [responseString indexOf:@"points:\"" from:0];
            NSInteger b = [responseString indexOf:@"\",levels:\"" from:a] - 10;
            
            NSInteger c = [responseString indexOf:@"tooltipHtml:\"" from:0];
            NSInteger d = [responseString indexOf:@"(" from:c];
            NSInteger e = [responseString indexOf:@")\"" from:d] - 2;
            
            NSString* info = [[responseString substringFrom:d to:e] stringByReplacingOccurrencesOfString:@"\\x26#160;" withString:@""];
            NSLog(@"tooltip %@", info);
            
            NSString* encodedPoints = [responseString substringFrom:a to:b];
            NSArray* steps = [self decodePolyLine:[encodedPoints mutableCopy]];
            if (steps && [steps count] > 0) {
                [self setRoutePoints:steps];
                //} else if (!steps) {
                //	[self showError:@"No se pudo calcular la ruta"];
            } else {
                // TODO: show error
            }
            
            [responseString release];
        }
        @catch (NSException * e) {
            // TODO: show error
        } 
    };
    [operation start];
    [operation release];
}

// Decode a polyline.
// See: http://code.google.com/apis/maps/documentation/utilities/polylinealgorithm.html
- (NSMutableArray *)decodePolyLine:(NSMutableString *)encoded {
	[encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
								options:NSLiteralSearch
								  range:NSMakeRange(0, [encoded length])];
	NSInteger len = [encoded length];
	NSInteger index = 0;
	NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
	NSInteger lat=0;
	NSInteger lng=0;
	while (index < len) {
		NSInteger b;
		NSInteger shift = 0;
		NSInteger result = 0;
		do {
			b = [encoded characterAtIndex:index++] - 63;
			result |= (b & 0x1f) << shift;
			shift += 5;
		} while (b >= 0x20);
		NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
		lat += dlat;
		shift = 0;
		result = 0;
		do {
			b = [encoded characterAtIndex:index++] - 63;
			result |= (b & 0x1f) << shift;
			shift += 5;
		} while (b >= 0x20);
		NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
		lng += dlng;
		NSNumber *latitude = [[[NSNumber alloc] initWithFloat:lat * 1e-5] autorelease];
		NSNumber *longitude = [[[NSNumber alloc] initWithFloat:lng * 1e-5] autorelease];
		// printf("[%f,", [latitude doubleValue]);
		// printf("%f]", [longitude doubleValue]);
		CLLocation *loc = [[[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]] autorelease];
		[array addObject:loc];
	}
	
	return array;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Santurce » Bilbao";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    MKPointAnnotation* a = [[MKPointAnnotation alloc] init];
    a.title = @"Santurce";
    a.coordinate = CLLocationCoordinate2DMake(43.3282, -3.031509);

    MKPointAnnotation* b = [[MKPointAnnotation alloc] init];
    b.title = @"Bilbao";
    b.coordinate = CLLocationCoordinate2DMake(43.256963, -2.923441);
    
    self.source = a;
    self.destination = b;
    
    [map addAnnotation:a];
    [map addAnnotation:b];
    
    [map setCenterCoordinate:a.coordinate animated:NO];
    
    [a release];
    [b release];
    
    [self calculateDirections];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
