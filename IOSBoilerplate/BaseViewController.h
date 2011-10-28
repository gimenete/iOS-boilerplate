//
//  BaseViewController.h
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


#import <UIKit/UIKit.h>
#import "AFJSONRequestOperation.h"
#import "AFXMLRequestOperation.h"
#import "AFImageRequestOperation.h"
#import "AFHTTPRequestOperation.h"

@interface BaseViewController : UIViewController {
	
	NSMutableArray* requests;
    NSOperationQueue *queue;
	
}

- (void) queueOperation:(NSOperation*)operation;
- (void) cancelOperations;

- (NSURLRequest*) requestWithURL:(NSString*)urlString;
- (NSMutableURLRequest*) mutableRequestWithURL:(NSString*)urlString;

- (AFHTTPRequestOperation *)simpleRequest:(NSURLRequest *)urlRequest
                                  success:(void (^)(id object))success 
                                  failure:(void (^)(NSHTTPURLResponse *response, NSError *error))failure;

- (AFImageRequestOperation*) imageRequest:(NSURLRequest *)urlRequest
                                  success:(void (^)(UIImage *image))success;

- (AFJSONRequestOperation*) jsonRequest:(NSURLRequest *)urlRequest
                                success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON))success
                                failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure;

- (AFXMLRequestOperation*) xmlRequest:(NSURLRequest *)urlRequest
                              success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser))success
                              failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure;

@end
