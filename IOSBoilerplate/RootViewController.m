//
//  RootViewController.m
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "HTTPHUDExample.h"
#import "AsyncImageExample.h"
#import "AsyncCellImagesExample.h"

@implementation RootViewController

@synthesize table;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Demos";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"HTTP requests";
            break;
            
        default:
            break;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"HUD + JSON parsing";
            cell.detailTextLabel.text = @"Shows a HUD spinner and parses JSON";
            break;
            
        case 1:
            cell.textLabel.text = @"Async image";
            cell.detailTextLabel.text = @"Loads a simple image asynchronously";
            break;
            
        case 2:
            cell.textLabel.text = @"Async cell images";
            cell.detailTextLabel.text = @"Loads images inside cells asynchronously";
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController* vc = nil;
    
    switch (indexPath.row) {
        case 0:
            vc = [[HTTPHUDExample alloc] init];
            break;
            
        case 1:
            vc = [[AsyncImageExample alloc] init];
            break;
            
        case 2:
            vc = [[AsyncCellImagesExample alloc] init];
            break;
            
        default:
            break;
    }
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
        [vc release];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)dealloc
{
    [table release];
    
    [super dealloc];
}

@end
