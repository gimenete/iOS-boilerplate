//
//  VariableHeightCell.m
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
