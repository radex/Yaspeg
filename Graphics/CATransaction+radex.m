//
//  CATransaction+radex.m
//  Yaspeg2
//
//  Created by Radex on 10-01-14.
//  Copyright 2010 Radex. All rights reserved.
//

#import "CATransaction+radex.h"

@implementation CATransaction (Radex)

+ (void)setAnimationDuration_c:(CFTimeInterval)duration
{
   [CATransaction setValue:[NSNumber numberWithFloat:duration] forKey:kCATransactionAnimationDuration]; //that's for 10.5 compatibility
}

@end
