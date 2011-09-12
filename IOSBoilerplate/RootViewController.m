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
#import "VariableHeightExample.h"
#import "DirectionsExample.h"
#import "AutocompleteLocationExample.h"

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
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"HTTP requests";
            break;
            
        case 1:
            return @"UITableView";
            break;
            
        case 2:
            return @"Maps & locations";
            break;
            
        default:
            break;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 3;
            break;
            
        case 1:
            return 1; // TODO: 3
            break;
            
        case 2:
            return 2;
            break;
            
        default:
            break;
    }
    return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (indexPath.section == 0) {
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
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Variable cell height";
                cell.detailTextLabel.text = @"Implements a FastCell with variable height";
                break;
                
            case 1:
                cell.textLabel.text = @"Pull down to refresh";
                cell.detailTextLabel.text = @"Extends a base class to add that feature";
                break;
                
            case 2:
                cell.textLabel.text = @"Swipe cell";
                cell.detailTextLabel.text = @"Demonstrates how to make swipeable cells";
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Directions";
                cell.detailTextLabel.text = @"Map Overlays + Google Maps API";
                break;
                
            case 1:
                cell.textLabel.text = @"Autocomplete location";
                cell.detailTextLabel.text = @"Uses the Google Maps API to search locations";
                break;
                
            default:
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController* vc = nil;
    
    if (indexPath.section == 0) {
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
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                vc = [[VariableHeightExample alloc] init];
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                vc = [[DirectionsExample alloc] init];
                break;
                
            case 1:
                vc = [[AutocompleteLocationExample alloc] init];
                break;
                
            default:
                break;
        }
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
