//
//  FastCell.m
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FastCell.h"

@interface ContentView : UIView
@end

@implementation ContentView

- (void)drawRect:(CGRect)r
{
	[(FastCell*)[self superview] drawContentView:r];
}

@end

@implementation FastCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        backView = [[UIView alloc] initWithFrame:CGRectZero];
        backView.opaque = YES;
        [self addSubview:backView];
        
		contentView = [[ContentView alloc] initWithFrame:CGRectZero];
		contentView.opaque = YES;
		[self addSubview:contentView];
    }
    return self;
}

- (void)dealloc {
	[backView removeFromSuperview];
	[backView release];
    
	[contentView removeFromSuperview];
	[contentView release];
	[super dealloc];
}

- (void)setFrame:(CGRect)f {
	[super setFrame:f];
	CGRect b = [self bounds];
	b.size.height -= 1; // leave room for the seperator line
	
    [backView setFrame:b];
	[contentView setFrame:b];
    [self setNeedsDisplay];
}

- (void)setNeedsDisplay {
	[super setNeedsDisplay];
    [backView setNeedsDisplay];
	[contentView setNeedsDisplay];
}

- (void)drawContentView:(CGRect)r {
	// subclasses should implement this
}

@end
