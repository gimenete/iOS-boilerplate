//
//  AutocompleteLocationExample.m
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AutocompleteLocationExample.h"
#import "Place.h"
#import "StringHelper.h"
#import "JSONKit.h"

@implementation AutocompleteLocationExample

@synthesize suggestions;
@synthesize dirty;
@synthesize loading;
@synthesize label;

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

#pragma mark -
#pragma mark SearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	if ([searchText length] > 2) {
		if (loading) {
			dirty = YES;
		} else {
			[self loadSearchSuggestions];
		}
	}
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
	return NO;
}


#pragma mark -
#pragma mark ASIHTTPRequest delegate methods

- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSMutableArray* sug = [[NSMutableArray alloc] init];
	
    NSString *responseString = [request responseString];
	
	NSDictionary* dict = [responseString objectFromJSONString];
	NSArray* placemarks = [dict objectForKey:@"Placemark"];
	
	for (NSDictionary* placemark in placemarks) {
		NSString* address = [placemark objectForKey:@"address"];
		
		NSDictionary* point = [placemark objectForKey:@"Point"];
		NSArray* coordinates = [point objectForKey:@"coordinates"];
		NSNumber* lon = [coordinates objectAtIndex:0];
		NSNumber* lat = [coordinates objectAtIndex:1];
		
		Place* place = [[Place alloc] init];
		place.title = address;
		CLLocationCoordinate2D c = CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
		place.coordinate = c;
		[sug addObject:place];
		[place release];
	}
	
	self.suggestions = sug;
    [sug release];
    
	[self.searchDisplayController.searchResultsTableView reloadData];
	loading = NO;
	
	if (dirty) {
		dirty = NO;
		[self loadSearchSuggestions];
	}
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	loading = NO;
}

#pragma mark -
#pragma mark Search backend

- (void) loadSearchSuggestions {
	loading = YES;
	NSString* query = self.searchDisplayController.searchBar.text;
    // You could limit the search to a region (e.g. a country) by appending more text to the query
	// example: query = [NSString stringWithFormat:@"%@, Spain", text];
	NSString *urlEncode = [query urlEncode];
	NSString* u = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&hl=%@&oe=UTF8", urlEncode, [[NSLocale currentLocale] localeIdentifier]];
	NSURL* url = [NSURL URLWithString:u];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
	[request setDelegate:self];
	[request startAsynchronous];
}

#pragma mark -
#pragma mark UITableView methods

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"suggest";
	
	UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) 
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
	}
	
	Place* suggestion = [suggestions objectAtIndex:indexPath.row];
	cell.textLabel.text = suggestion.title;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	self.searchDisplayController.searchBar.hidden = YES;
	[self.searchDisplayController setActive:NO animated:YES];
	
	Place* suggestion = [suggestions objectAtIndex:indexPath.row];
    // You could add "suggestion" to a map since it implements MKAnnotation
    // example: [map addAnnotation:suggestion]

    label.text = suggestion.title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [suggestions count];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Search a location";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)dealloc {
    [suggestions release];
    [label release];
    [super dealloc];
}

@end
