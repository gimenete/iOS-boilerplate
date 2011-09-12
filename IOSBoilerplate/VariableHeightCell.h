//
//  VariableHeightCell.h
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FastCell.h"

@interface VariableHeightCell : FastCell

@property (nonatomic, retain) NSDictionary* info;

- (void) updateCellInfo:(NSDictionary*)_info;
+ (CGFloat) heightForCellWithInfo:(NSDictionary*)_info inTable:(UITableView *)tableView;

@end
