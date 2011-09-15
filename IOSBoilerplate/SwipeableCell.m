//
//  SwipeableCell.m
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

#import "SwipeableCell.h"
#import "DictionaryHelper.h"

@implementation SwipeableCell

@synthesize info;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) 
    {
		self.backgroundColor = [UIColor whiteColor];
		self.opaque = YES;
        
        // configure "backView"
        UIButton* b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        b.frame = CGRectMake(5, 5, 100, 30);
        [b setTitle:@"Hi there!" forState:UIControlStateNormal];
        [b setTitle:@"Hi there!" forState:UIControlStateHighlighted];
        [b setTitle:@"Hi there!" forState:UIControlStateSelected];
        [backView addSubview:b];
        backView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [b addTarget:self action:@selector(doSomething) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void) doSomething {
    NSLog(@"do something");
    
    UIView* view = self.superview;
    if ([view isKindOfClass:[UITableView class]]) {
        UITableView* table = (UITableView*)view;
        [table setEditing:NO animated:YES];
    }
}

- (void) prepareForReuse {
	[super prepareForReuse];
}

static UIFont* bold22 = nil;

+ (void)initialize
{
	if(self == [SwipeableCell class])
	{
		bold22 = [[UIFont boldSystemFontOfSize:22] retain];
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
	
	[[UIColor blackColor] set];
    [text drawAtPoint:CGPointMake(15.0, 10.0) forWidth:rect.size.width withFont:bold22 lineBreakMode:UILineBreakModeTailTruncation];
}

- (void) updateCellInfo:(NSDictionary*)_info {
	self.info = _info;
    [self setNeedsDisplay];
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated {
    // Do not call the super method. It shows a delete button by deafult
	// [super setEditing:editing animated:animated];
	
    if (editing) {
        // swiped
        swipe = YES;
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        CGRect frame = contentView.frame;
        // this makes visible just 10 points of the contentView
        frame.origin.x = contentView.frame.size.width - 10;
        contentView.frame = frame;
        [UIView commitAnimations];
    } else if (swipe) {
        // swipe finished
        swipe = NO;
        
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        CGRect frame = contentView.frame;
        frame.origin.x = 0;
        contentView.frame = frame;
        [UIView commitAnimations];
    }
    
    // [self setNeedsDisplay];
}

@end
