//
//  TwitterSearchClient.h
//  IOSBoilerplate
//
//  Created by Mattt Thompson on 11/10/31.
//  Copyright (c) 2011年 Gowalla. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface TwitterSearchClient : AFHTTPClient
+ (TwitterSearchClient *)sharedClient;
@end
