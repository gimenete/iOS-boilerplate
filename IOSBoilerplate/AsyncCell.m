//
//  AsyncCell.m
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AsyncCell.h"
#import "ImageManager.h"
#import "DictionaryHelper.h"

@implementation AsyncCell

@synthesize info;
@synthesize imageURL;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) 
    {
		self.backgroundColor = [UIColor whiteColor];
		self.opaque = YES;
    }
    return self;
}

- (void) prepareForReuse {
	[super prepareForReuse];
}

static UIFont* system14 = nil;
static UIFont* bold14 = nil;

+ (void)initialize
{
	if(self == [AsyncCell class])
	{
		system14 = [[UIFont systemFontOfSize:14] retain];
		bold14 = [[UIFont boldSystemFontOfSize:14] retain];
	}
}

- (void)dealloc {
    [info release];
    [imageURL release];
    
    [super dealloc];
}

- (void) drawContentView:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	[[UIColor whiteColor] set];
	CGContextFillRect(context, rect);
	
	NSString* name = [info stringForKey:@"from_user"];
	NSString* text = [info stringForKey:@"text"];
	
	CGFloat widthr = self.frame.size.width - 70;
	
	[[UIColor blackColor] set];
	[name drawInRect:CGRectMake(63.0, 5.0, widthr, 20.0) withFont:bold14 lineBreakMode:UILineBreakModeTailTruncation];
	[[UIColor grayColor] set];
	[text drawInRect:CGRectMake(63.0, 25.0, widthr, 20.0) withFont:system14 lineBreakMode:UILineBreakModeTailTruncation];
	
	if (imageURL) {
		UIImage* img = [ImageManager loadImage:imageURL];
		if (img) {
			CGRect r = CGRectMake(5.0, 5.0, 48.0, 48.0);
			[img drawInRect:r];
		}
	}
}

- (void) updateCellInfo:(NSDictionary*)_info {
	self.info = _info;
	NSString* image = [info stringForKey:@"profile_image_url"];
	if (image) {
		NSURL* url = [[NSURL alloc] initWithString:image];
		self.imageURL = url;
		[url release];
	} else {
        self.imageURL = nil;
    }
	[self setNeedsDisplay];
}

- (void) imageLoaded:(UIImage*)image withURL:(NSURL*)url {
	if ([imageURL isEqual:url]) {
		[self setNeedsDisplay];
	}
}

@end
