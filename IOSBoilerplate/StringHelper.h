//
//  StringHelper.h
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (helper)

- (NSString*)substringFrom:(NSInteger)a to:(NSInteger)b;

- (NSInteger)indexOf:(NSString*)substring from:(NSInteger)starts;

- (NSString*)trim;

- (BOOL)startsWith:(NSString*)s;

- (BOOL)containsString:(NSString*)aString;

- (NSString*)urlEncode;

- (NSString*)sha1;

@end

