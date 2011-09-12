//
//  DirectionsExample.h
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>

@interface DirectionsExample : BaseViewController

@property(nonatomic, retain) id<MKAnnotation> source;
@property(nonatomic, retain) id<MKAnnotation> destination;
@property(nonatomic, retain) MKPolyline* routeLine;
@property (nonatomic, retain) IBOutlet MKMapView* map;

- (NSMutableArray *)decodePolyLine:(NSMutableString *)encoded;

@end
