//
//  VariableHeightExample.m
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VariableHeightExample.h"
#import "SVProgressHUD.h"
#import "JSONKit.h"
#import "DictionaryHelper.h"
#import "VariableHeightCell.h"

@implementation VariableHeightExample

@synthesize table;
@synthesize results;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - UITableViewDelegate and DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [results count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    VariableHeightCell *cell = (VariableHeightCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[VariableHeightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary* obj = [results objectAtIndex:indexPath.row];
    [cell updateCellInfo:obj];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* obj = [results objectAtIndex:indexPath.row];
    return [VariableHeightCell heightForCellWithInfo:obj inTable:tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Latest twits about #cats";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [SVProgressHUD showInView:self.view];
    
    // By using [self requestWithURL:@"..."]; the reques is cancelled if the user closes this view controller
    ASIHTTPRequest* request = [self requestWithURL:@"http://search.twitter.com/search.json?q=%23cats"];
    [request setDidFinishSelector:@selector(requestFinished:)];
    [request setDidFailSelector:@selector(requestFailed:)];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest*)request {
    [SVProgressHUD dismiss];
    
    NSDictionary* result = [[request responseString] objectFromJSONString];
    self.results = [result arrayForKey:@"results"];
    [table reloadData];
}

- (void)requestFailed:(ASIHTTPRequest*)request {
    [SVProgressHUD dismissWithError:[[request error] localizedDescription]];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)dealloc {
    [table release];
    [results release];
    
    [super dealloc];
}

@end
