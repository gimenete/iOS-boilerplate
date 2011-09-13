//
//  ListViewController.h
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 13/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface ListViewController : BaseViewController<EGORefreshTableHeaderDelegate> {

    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;

}

@property (nonatomic, retain) IBOutlet UITableView* table;

@end
