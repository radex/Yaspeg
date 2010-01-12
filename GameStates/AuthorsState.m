//
//  AuthorsState.m
//  Yaspeg2
//
//  Created by Radex on 10-01-12.
//  Copyright 2010 Radex. All rights reserved.
//

#import "AuthorsState.h"

@implementation AuthorsState

/*
 * stateInit
 *
 *
 */

- (void) stateInit
{
   
}

/*
 * events
 *
 *
 */

- (void) events
{
   if(eventType == None_ET)
   {
      
   }
   
   eventType = None_ET;
}

/*
 * logic
 *
 *
 */

- (void) logic
{
   
}

/*
 * render
 *
 *
 */

- (void) render
{
   // rendering for first time
   
   if(!inited)
   {
      
      
      inited = YES;
   }
   
   
}

/*
 * outro
 *
 *
 */

- (NSTimeInterval) outro
{
   NSTimeInterval animationDuration = 1.0;
   
   
   
   [NSTimer scheduledTimerWithTimeInterval:animationDuration target:self selector:@selector(cleanUp) userInfo:nil repeats:NO];
   
   return animationDuration;
}

/*
 * cleanUp
 *
 *
 */

- (void) cleanUp
{
   
}

/*
 * finalize
 *
 *
 */

- (void) finalize
{
   [self cleanUp];
   [super finalize];
}

@end


@end
