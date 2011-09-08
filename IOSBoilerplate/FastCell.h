//
//  FastCell.h
//  IOSBoilerplate
//
//  Created by Alberto Gimeno Brieba on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FastCell : UITableViewCell {

    UIView* contentView;

}

- (void) drawContentView:(CGRect)r;

@end
