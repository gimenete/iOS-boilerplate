//
//  SwipeableTableViewExample.h
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 13/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

@interface SwipeableTableViewExample : BaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UITableView* table;

@end
