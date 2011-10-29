//
//  BrowserViewController.m
//
//  This software is licensed under the MIT Software License
//
//  Copyright (c) 2011 Nathan Buggia
//  http://nathanbuggia.com/posts/browser-view-controller/
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation 
//  the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and 
//  to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of 
//  the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO 
//  THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
//  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
//  SOFTWARE.
//
//  Artwork generously contributed by Joseph Wain of http://glyphish.com (buy his Pro pack of icons!)
//


#import "BrowserViewController.h"

@implementation BrowserViewController

@synthesize webView;
@synthesize url;
@synthesize toolbar;
@synthesize forwardButton;
@synthesize backButton;
@synthesize stopButton;
@synthesize reloadButton;
@synthesize actionButton;


/**********************************************************************************************************************/
#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)uias clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // user pressed "Cancel"
    if(buttonIndex == [uias cancelButtonIndex]) return;
        
    // user pressed "Open in Safari"
    if([[uias buttonTitleAtIndex:buttonIndex] compare:ACTION_OPEN_IN_SAFARI] == NSOrderedSame)
    {
        [(MyApplication*)[UIApplication sharedApplication] openURL:self.url forceOpenInSafari:YES];
    }
    
    // TODO add your own actions here, like email the URL.
}


/**********************************************************************************************************************/
#pragma mark - Object lifecycle


- (void)dealloc
{
    [webView setDelegate:nil];
    [webView release];
    [url release];
    [activityIndicator release];
    
    [forwardButton release];
    [backButton release];
    [stopButton release];
    [reloadButton release];
    [actionButton release];

    [super dealloc];
}


- (id)initWithUrls:(NSURL*)u
{
    self = [self initWithNibName:@"BrowserViewController" bundle:nil];
    if(self)
    {
        self.webView.delegate = self;
        self.url = u;
        
        activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        
        self.forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:PNG_BUTTON_FORWARD] 
                                                              style:UIBarButtonItemStylePlain 
                                                             target:self 
                                                             action:@selector(forwardButtonPressed:)];

        
        self.backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:PNG_BUTTON_BACK]
                                                           style:UIBarButtonItemStylePlain 
                                                          target:self 
                                                          action:@selector(backButtonPressed:)];
         
        self.stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop 
                                                                        target:self 
                                                                        action:@selector(stopReloadButtonPressed:)];
        
        self.reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
                                                                          target:self 
                                                                          action:@selector(stopReloadButtonPressed:)];
        
        self.actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                          target:self
                                                                          action:@selector(actionButtonPressed:)];
    }
    
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**********************************************************************************************************************/
#pragma mark - View lifecycle


- (void)updateToolbar
{
    // toolbar
    self.forwardButton.enabled = [self.webView canGoForward];
    self.backButton.enabled = [self.webView canGoBack];

    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];        
    NSMutableArray *toolbarButtons = [[NSMutableArray alloc] initWithObjects:self.backButton, flexibleSpace, self.forwardButton, 
                                      flexibleSpace, self.reloadButton, flexibleSpace, self.actionButton, nil];
    
    if([activityIndicator isAnimating]) [toolbarButtons replaceObjectAtIndex:4 withObject:self.stopButton];
    
    [self.toolbar setItems:toolbarButtons animated:YES];
    [toolbarButtons release];
    [flexibleSpace release];
    
    // page title
    NSString *pageTitle = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if(pageTitle) [[self navigationItem] setTitle:pageTitle];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.scalesPageToFit = YES;
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:activityIndicator] autorelease];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    [self updateToolbar];
}


- (void)viewDidUnload
{
    [[self navigationItem] setRightBarButtonItem:nil];
    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait
            || interfaceOrientation == UIInterfaceOrientationLandscapeRight
            || interfaceOrientation == UIInterfaceOrientationLandscapeLeft
            || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}


/**********************************************************************************************************************/
#pragma mark - User Interaction


- (void)backButtonPressed:(id)sender
{
    if([self.webView canGoBack]) [self.webView goBack];
}


- (void)forwardButtonPressed:(id)sender
{
    if([self.webView canGoForward]) [self.webView goForward];
}


- (void)stopReloadButtonPressed:(id)sender
{
    if([activityIndicator isAnimating])
    {
        [self.webView stopLoading];
        [activityIndicator stopAnimating];
    }
    else
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
        [self.webView loadRequest:request];
    }
    
    [self updateToolbar];
}


- (void)actionButtonPressed:(id)sender
{    
    UIActionSheet *uias = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:self 
                                             cancelButtonTitle:ACTION_CANCEL 
                                        destructiveButtonTitle:nil 
                                             otherButtonTitles:ACTION_OPEN_IN_SAFARI, nil];
    
    [uias showInView:self.view];
    [uias release];
}


/**********************************************************************************************************************/
#pragma mark - WebView Delegate


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicator startAnimating];
    [self updateToolbar];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if(activityIndicator) [activityIndicator stopAnimating];
    [self updateToolbar];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{    
    [self updateToolbar];
}


@end
