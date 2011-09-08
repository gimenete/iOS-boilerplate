//
//  AsyncCell.h
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FastCell.h"

@interface AsyncCell : FastCell

@property (nonatomic, retain) NSDictionary* info;
@property (nonatomic, retain) NSURL* imageURL;

- (void) updateCellInfo:(NSDictionary*)_info;

@end
