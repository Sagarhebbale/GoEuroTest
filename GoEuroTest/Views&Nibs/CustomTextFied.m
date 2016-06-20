//
//  CustomTextFied.m
//  GoEuroTest
//
//  Created by master on 6/19/16..
//  Copyright © 2016 Neemo. All rights reserved.
//

#import "CustomTextFied.h"

@implementation CustomTextFied

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + 60, bounds.origin.y + 1,
                      bounds.size.width - 60, bounds.size.height);
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}
@end
