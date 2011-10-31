//
//  AsyncCell.m
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

#import "AsyncCell.h"
#import "DictionaryHelper.h"
#import "AFImageRequestOperation.h"

@implementation AsyncCell

@synthesize info;
@synthesize image;

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
    self.image = nil;
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
    [image release];
    
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
	
	if (image) {
		CGRect r = CGRectMake(5.0, 5.0, 48.0, 48.0);
		[image drawInRect:r];
	}
}

- (void) updateCellInfo:(NSDictionary*)_info {
	self.info = _info;
	NSString *urlString = [info stringForKey:@"profile_image_url"];
	if (urlString) {
        AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] success:^(UIImage *requestedImage) {
            self.image = requestedImage;
            [self setNeedsDisplay];
        }];
        [operation start];
    }
}

@end
