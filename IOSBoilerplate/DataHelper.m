//
//  DataHelper.m
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataHelper.h"

@implementation NSData (helper)

- (NSString*)hexString {
	NSMutableString *str = [NSMutableString stringWithCapacity:64];
	int length = [self length];
	char *bytes = malloc(sizeof(char) * length);
	
	[self getBytes:bytes length:length];
	
	int i = 0;
	
	for (; i < length; i++) {
		[str appendFormat:@"%02.2hhx", bytes[i]];
	}
	free(bytes);
	
	return str;
}

@end
