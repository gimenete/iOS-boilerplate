//
//  ImageManager.m
//  IOSBoilerplate
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

#import "ImageManager.h"
#import "IOSBoilerplateAppDelegate.h"
#import "AFImageRequestOperation.h"
#import "AFImageCache.h"

@implementation ImageManager

- (id)init
{
    self = [super init];
    if (self) {
        downloadQueue = [[NSOperationQueue alloc] init];
        [downloadQueue setMaxConcurrentOperationCount:3];
    }
    
    return self;
}

- (void)dealloc {
    [downloadQueue release];
    
    [super dealloc];
}

static ImageManager *sharedSingleton;

+ (void)initialize {
    static BOOL initialized = NO;
    if(!initialized) {
        initialized = YES;
        sharedSingleton = [[ImageManager alloc] init];
    }
}

// Future use
- (NSString*) cacheDirectory {
	return [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/images/"];
}

- (void)loadImage:(NSString*)url success:(void (^)(UIImage *image))success {
    static NSString* cacheName = nil;
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    UIImage *image = [[AFImageCache sharedImageCache] cachedImageForURL:request.URL cacheName:cacheName];
    if (image) {
        success(image);
    } else {
        AFImageRequestOperation* operation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil cacheName:cacheName success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            success(image);
        } failure:nil];
        
        [downloadQueue addOperation:operation];
    }
}

+ (void)loadImage:(NSString*)url success:(void (^)(UIImage *image))success {
    [sharedSingleton loadImage:url success:success];
}

+ (void) clearMemoryCache {
    [sharedSingleton clearMemoryCache];
}

- (void) clearMemoryCache {
    [[AFImageCache sharedImageCache] removeAllObjects];
}

+ (void) clearCache {
    [sharedSingleton clearCache];
}

- (void) clearCache {
    NSFileManager* fs = [NSFileManager defaultManager];
	// BOOL b = 
	[fs removeItemAtPath:[self cacheDirectory] error:NULL];
    
}

+ (void) releaseSingleton {
    [sharedSingleton release];
}


@end
