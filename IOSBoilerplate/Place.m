//
//  Place.m
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Place.h"

@implementation Place

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc {
    [title release];
    [subtitle release];
    [super dealloc];
}

@end
