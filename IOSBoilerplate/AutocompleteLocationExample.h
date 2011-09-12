//
//  AutocompleteLocationExample.h
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"

@interface AutocompleteLocationExample : BaseViewController

@property (nonatomic, retain) NSMutableArray* suggestions;
@property (nonatomic, retain) IBOutlet UILabel* label;
@property (assign) BOOL dirty;
@property (assign) BOOL loading;

- (void) loadSearchSuggestions;

@end
