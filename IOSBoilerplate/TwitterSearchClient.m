//
//  TwitterSearchClient.m
//  IOSBoilerplate
//
//  Created by Mattt Thompson on 11/10/31.
//  Copyright (c) 2011年 Gowalla. All rights reserved.
//

#import "TwitterSearchClient.h"

#import "AFJSONRequestOperation.h"

NSString * const kTwitterBaseURLString = @"https://search.twitter.com/";


@implementation TwitterSearchClient

+ (TwitterSearchClient *)sharedClient {
    static TwitterSearchClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
	// X-UDID HTTP Header
	[self setDefaultHeader:@"X-UDID" value:[[UIDevice currentDevice] uniqueIdentifier]];
    
    return self;
}



@end
