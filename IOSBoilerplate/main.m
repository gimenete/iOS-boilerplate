//
//  main.m
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, @"MyApplication", nil);
    [pool release];
    return retVal;
}
