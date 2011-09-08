//
//  ImageManager.m
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageManager.h"
#import "ASIHTTPRequest.h"
#import "IOSBoilerplateAppDelegate.h"

@implementation ImageManager

- (id)init
{
    self = [super init];
    if (self) {
        pendingImages = [[NSMutableArray alloc] initWithCapacity:10];
        loadedImages = [[NSMutableDictionary alloc] initWithCapacity:50];
        downloadQueue = [[NSOperationQueue alloc] init];
        [downloadQueue setMaxConcurrentOperationCount:3];
    }
    
    return self;
}

- (void)dealloc {
    [pendingImages release];
    [loadedImages release];
    [downloadQueue release];
    [cache release];
    
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

- (NSString*) cacheDirectory {
	return [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/images/"];
}

+ (UIImage*)loadImage:(NSURL *)url {
    return [sharedSingleton loadImage:url];
}

- (UIImage*)loadImage:(NSURL *)url {
	// NSLog(@"url = %@", url);
	UIImage* img = [loadedImages objectForKey:url];
    if (img) {
        return img;
    }
    
    if ([pendingImages containsObject:url]) {
        // already being downloaded
        return nil;
    }
    
    [pendingImages addObject:url];
    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    /*
     Here you can configure a cache system
     
     if (!cache) {
     ASIDownloadCache* _cache = [[ASIDownloadCache alloc] init];
     self.cache = _cache;
     [_cache release];
     [cache setStoragePath:[self cacheDirectory]];
     }
     // [request setDownloadCache:cache];
     // [request setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];
     // [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
     
     */
    
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(imageDone:)];
    [request setDidFailSelector:@selector(imageWentWrong:)];
    [downloadQueue addOperation:request];
    [request release];
    return nil;
}

- (void)imageDone:(ASIHTTPRequest*)request {
	UIImage* image = [UIImage imageWithData:[request responseData]];
	if (!image) {
		return;
	}
	
	// NSLog(@"image done. %@ cached = %d", request.url, [request didUseCachedResponse]);
	
	[pendingImages removeObject:request.url];
	[loadedImages setObject:image forKey:request.url];
	
	SEL selector = @selector(imageLoaded:withURL:);
	NSArray* viewControllers = nil;
	
    IOSBoilerplateAppDelegate* delegate = [IOSBoilerplateAppDelegate sharedAppDelegate];
    // change this if your application is not based on a UINavigationController
	viewControllers = delegate.navigationController.viewControllers;
	
	for (UIViewController* vc in viewControllers) {
		if ([vc respondsToSelector:selector]) {
			[vc performSelector:selector withObject:image withObject:request.url];
		}
	}
}

- (void)imageWentWrong:(ASIHTTPRequest*)request {
	NSLog(@"image went wrong %@", [[request error] localizedDescription]);
	[pendingImages removeObject:request.url]; // TODO should not try to load the image again for a while
}

+ (void) clearMemoryCache {
    [sharedSingleton clearMemoryCache];
}

- (void) clearMemoryCache {
	[loadedImages removeAllObjects];
	[pendingImages removeAllObjects];
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
