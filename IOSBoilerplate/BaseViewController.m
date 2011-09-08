//
//  BaseViewController.m
//
//  Created by Alberto Gimeno Brieba on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"
#import "IOSBoilerplateAppDelegate.h"

@implementation BaseViewController

#pragma mark -
#pragma mark HTTP requests

- (ASIHTTPRequest*) requestWithURL:(NSString*) s {
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:s]];
	[self addRequest:request];
	return request;
}

- (ASIFormDataRequest*) formRequestWithURL:(NSString*) s {
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:s]];
	[self addRequest:request];
	return request;
}

- (void) addRequest:(ASIHTTPRequest*)request {
	[request setDelegate:self];
	if (!requests) {
		requests = [[NSMutableArray alloc] initWithCapacity:3];
	} else {
		[self clearFinishedRequests];
	}
	[requests addObject:request];
}

- (void) clearFinishedRequests {
	NSMutableArray* toremove = [[NSMutableArray alloc] initWithCapacity:[requests count]];
	for (ASIHTTPRequest* r in requests) {
		if ([r isFinished]) {
			[toremove addObject:r];
		}
	}
	
	for (ASIHTTPRequest* r in toremove) {
		[requests removeObject:r];
	}
	[toremove release];
}

- (void) cancelRequests {
	for (ASIHTTPRequest* r in requests) {
		r.delegate = nil;
		[r cancel];
	}	
	[requests removeAllObjects];
}

- (void) refreshCellsWithImage:(UIImage*)image fromURL:(NSURL*)url inTable:(UITableView*)tableView {
    NSArray *cells = [tableView visibleCells];
    [cells retain];
    SEL selector = @selector(imageLoaded:withURL:);
    for (int i = 0; i < [cells count]; i++) {
		UITableViewCell* c = [[cells objectAtIndex: i] retain];
        if ([c respondsToSelector:selector]) {
            [c performSelector:selector withObject:image withObject:url];
        }
        [c release];
		c = nil;
    }
    [cells release];
}

#pragma mark -
#pragma mark UIViewController

- (void) viewDidLoad {
	[super viewDidLoad];
}

- (void) viewDidUnload {
	[super viewDidUnload];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[self cancelRequests];
	[requests release];
	
    [super dealloc];
}


@end
