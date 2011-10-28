//
//  BaseViewController.m
//
//  Copyright (c) 2011 Alberto Gimeno Brieba
//  
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//  
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//  

#import "BaseViewController.h"
#import "IOSBoilerplateAppDelegate.h"

@implementation BaseViewController

#pragma mark -
#pragma mark HTTP requests

- (NSURLRequest*) requestWithURL:(NSString*)urlString {
    return [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
}

- (NSMutableURLRequest*) mutableRequestWithURL:(NSString*)urlString {
    return [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
}

- (AFImageRequestOperation*) imageRequest:(NSURLRequest *)urlRequest
                                 success:(void (^)(UIImage *image))success {
    
    AFImageRequestOperation* operation = [AFImageRequestOperation imageRequestOperationWithRequest:urlRequest success:success];
    [self queueOperation:operation];
    return operation;
}

- (AFJSONRequestOperation*) jsonRequest:(NSURLRequest *)urlRequest
                                success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
                                failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure {

    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:urlRequest success:success failure:failure];
    operation.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
    [self queueOperation:operation];
    return operation;
}

- (AFXMLRequestOperation*) xmlRequest:(NSURLRequest *)urlRequest
                              success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser))success
                              failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure {
    
    AFXMLRequestOperation* operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:urlRequest success:success failure:failure];
    [self queueOperation:operation];
    return operation;
}

- (AFHTTPRequestOperation *)simpleRequest:(NSURLRequest *)urlRequest
                                                    success:(void (^)(id object))success 
                                                    failure:(void (^)(NSHTTPURLResponse *response, NSError *error))failure {
    AFHTTPRequestOperation* operation = [AFHTTPRequestOperation HTTPRequestOperationWithRequest:urlRequest success:success failure:failure];
    [self queueOperation:operation];
    return operation;
}


- (void) queueOperation:(NSOperation*)operation {
    if (!queue) {
        queue = [[NSOperationQueue alloc] init];
    }
    [queue addOperation:operation];
}

- (void) cancelOperations {
    [queue cancelAllOperations];
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
	[self cancelOperations];
	[requests release];
	
    [super dealloc];
}


@end
