//
//  SwipeableCell.h
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 13/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FastCell.h"

@interface SwipeableCell : FastCell {
    
    BOOL swipe;
    
}

@property (nonatomic, retain) NSDictionary* info;

- (void) updateCellInfo:(NSDictionary*)_info;


@end
