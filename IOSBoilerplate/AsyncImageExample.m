//
//  AsyncImageExample.m
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AsyncImageExample.h"
#import "ImageManager.h"

@implementation AsyncImageExample

@synthesize imageView;
@synthesize url;

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    
    NSURL* _url = [[NSURL alloc] initWithString:@"http://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/Zaragoza_shel.JPG/266px-Zaragoza_shel.JPG"];
    self.url = _url;
    [_url release];
    
    UIImage* image = [ImageManager loadImage:url];
    
    if (image) {
        imageView.image = image;
    }
}

- (void)imageLoaded:(UIImage*)image withURL:(NSURL*)_url {
    if ([url isEqual:_url]) {
        imageView.image = image;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)dealloc {
    [imageView release];
    [url release];
    
    [super dealloc];
}

@end
