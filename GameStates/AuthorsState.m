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
   // background
   
   bgLayer = [ImageLayer layerWithImageNamed:@"bg"];
   bgLayer.opacity = 0.0;
   
   [yaspeg.rootLayer addSublayer:bgLayer];
}

/*
 * events
 *
 *
 */

- (void) events
{
   if(eventType == KeyDown_ET)
   {
      unichar character = [eventCharachters characterAtIndex:0];
      
      if(character == YK_ESC)
      {
         [yaspeg scheduledNextState:MainMenu_GS];
         return;
      }
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
      [CATransaction begin];
      [CATransaction setAnimationDuration_c:0.5];
      
      bgLayer.opacity = 1.0;
      
      [CATransaction commit];
      
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
   NSLog(@"outro");
   NSTimeInterval animationDuration = 0.5;
   
   [CATransaction begin];
   [CATransaction setAnimationDuration_c:animationDuration];
   
   bgLayer.opacity = 0;
   
   [CATransaction commit];
   
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
   NSLog(@"cleanUp");
   [bgLayer removeFromSuperlayer];
}

@end

