//
//  VariableHeightExample.h
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

@interface VariableHeightExample : BaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UITableView* table;
@property (nonatomic, retain) NSArray* results;

@end
