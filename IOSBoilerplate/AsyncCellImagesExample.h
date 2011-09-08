//
//  AsyncCellImagesExample.h
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

@interface AsyncCellImagesExample : BaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UITableView* table;
@property (nonatomic, retain) NSArray* results;

@end
