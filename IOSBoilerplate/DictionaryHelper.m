//
//  DictionaryHelper.m
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DictionaryHelper.h"

@implementation NSDictionary (helper)

- (NSString*) stringForKey:(id)key {
	id s = [self objectForKey:key];
	if (s == [NSNull null] || ![s isKindOfClass:[NSString class]]) {
		return nil;
	}
	return s;
}

- (NSNumber*) numberForKey:(id)key {
	id s = [self objectForKey:key];
	if (s == [NSNull null] || ![s isKindOfClass:[NSNumber class]]) {
		return nil;
	}
	return s;
}

- (NSMutableDictionary*) dictionaryForKey:(id)key {
	id s = [self objectForKey:key];
	if (s == [NSNull null] || ![s isKindOfClass:[NSMutableDictionary class]]) {
		return nil;
	}
	return s;
}

- (NSMutableArray*) arrayForKey:(id)key {
	id s = [self objectForKey:key];
	if (s == [NSNull null] || ![s isKindOfClass:[NSMutableArray class]]) {
		return nil;
	}
	return s;
}


@end
