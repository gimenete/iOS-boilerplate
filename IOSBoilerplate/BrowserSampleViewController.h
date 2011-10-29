//
//  BrowserSampleViewController.h
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

#import <UIKit/UIKit.h>
#import "BrowserViewController.h"

#define DEMO_URL    @"http://nytimes.com"

@interface BrowserSampleViewController : UIViewController
<UIWebViewDelegate>
{
    IBOutlet UIWebView *webView;
    IBOutlet UIButton *button;
    IBOutlet UITextView *textView;
}

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) UITextView *textView;

- (IBAction)openLinkInBrowser:(id)sender;

@end
