//
//  ImageManager.h
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIDownloadCache.h"

@interface ImageManager : NSObject {
    
    NSMutableArray* pendingImages;
	NSMutableDictionary* loadedImages;
	NSOperationQueue *downloadQueue;
	ASIDownloadCache *cache;
    
}

+ (UIImage*)loadImage:(NSURL *)url;
- (UIImage*)loadImage:(NSURL *)url;

+ (void) clearMemoryCache;
- (void) clearMemoryCache;

+ (void) clearCache;
- (void) clearCache;

- (NSString*) cacheDirectory;

+ (void) releaseSingleton;

@end
