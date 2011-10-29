//
//  MyApplication.m
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


#import "MyApplication.h"

@implementation MyApplication


- (BOOL)openURL:(NSURL *)url
{
    return [self openURL:url forceOpenInSafari:NO];
}


-(BOOL)openURL:(NSURL *)url forceOpenInSafari:(BOOL)forceOpenInSafari
{
    if(forceOpenInSafari) 
    {
        // We're overriding our app trying to open this URL, so we'll let UIApplication federate this request back out
        //  through the normal channels. The return value states whether or not they were able to open the URL.
        return [super openURL:url];
    }
    
    //
    // Otherwise, we'll see if it is a request that we should let our app open.
    
    BOOL couldWeOpenUrl = NO;
    
    NSString* scheme = [url.scheme lowercaseString];
    if([scheme compare:@"http"] == NSOrderedSame 
        || [scheme compare:@"https"] == NSOrderedSame)
    {
        // TODO - Here you might also want to check for other conditions where you do not want your app opening URLs (e.g. 
        //  Facebook authentication requests, OAUTH requests, etc)

        // TODO - Update the cast below with the name of your AppDelegate
        // Let's call the method you wrote on your AppDelegate to actually open the BrowserViewController
        // NATE
        couldWeOpenUrl = [(IOSBoilerplateAppDelegate*)self.delegate openURL:url];
    }
    
    if(!couldWeOpenUrl)
    {
        return [super openURL:url];
    }
    else
    {
        return YES;
    }
}


@end
