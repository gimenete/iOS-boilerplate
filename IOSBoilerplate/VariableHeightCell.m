//
//  VariableHeightCell.m
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 09/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VariableHeightCell.h"
#import "ImageManager.h"
#import "DictionaryHelper.h"

@implementation VariableHeightCell

@synthesize info;

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

+ (void)initialize
{
	if(self == [VariableHeightCell class])
	{
		system14 = [[UIFont systemFontOfSize:14] retain];
	}
}

- (void)dealloc {
    [info release];
    
    [super dealloc];
}

- (void) drawContentView:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	[[UIColor whiteColor] set];
	CGContextFillRect(context, rect);
	
	NSString* text = [info stringForKey:@"text"];
	
	CGFloat widthr = rect.size.width - 10;
    
	CGSize size = [text sizeWithFont:system14 constrainedToSize:CGSizeMake(widthr, 999999) lineBreakMode:UILineBreakModeTailTruncation];
	
	[[UIColor blackColor] set];
	[[UIColor grayColor] set];
	[text drawInRect:CGRectMake(5.0, 5.0, widthr, size.height) withFont:system14 lineBreakMode:UILineBreakModeTailTruncation];
}

- (void) updateCellInfo:(NSDictionary*)_info {
	self.info = _info;
    [self setNeedsDisplay];
}

+ (CGFloat) heightForCellWithInfo:(NSDictionary*)_info inTable:(UITableView *)tableView {
	NSString* text = [_info stringForKey:@"text"];
    
	CGFloat widthr = tableView.frame.size.width - 10;
    
	CGSize size = [text sizeWithFont:system14 constrainedToSize:CGSizeMake(widthr, 999999) lineBreakMode:UILineBreakModeTailTruncation];
	return size.height + 10;
}

@end
