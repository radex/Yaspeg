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
   
   // header
   
   headerLayer = [ImageLayer layerWithImageNamed:@"header-autorzy"];
   headerLayer.x = (800 - headerLayer.w) / 2;
   headerLayer.y = 600;
   
   [yaspeg.rootLayer addSublayer:headerLayer];
   
   // scenario, direction, graphics
   
   scenarioLayer = [ImageLayer layerWithImageNamed:@"scenariusz-rezyseria"];
   scenarioLayer.x = 50;
   scenarioLayer.y = 350;
   scenarioLayer.opacity = 0;
   
   [yaspeg.rootLayer addSublayer:scenarioLayer];
   
   // radex, radex glow
   
   radexLayer     = [ImageLayer layerWithImageNamed:@"radex-medium"];
   radexGlowLayer = [ImageLayer layerWithImageNamed:@"radex-medium-glow"];
   
   radexLayer.x = 250;
   radexLayer.y = 400;
   radexGlowLayer.x = 250;
   radexGlowLayer.y = 400;
   
   radexLayer.opacity = 0;
   radexGlowLayer.opacity = 0;
   
   [yaspeg.rootLayer addSublayer:radexLayer];
   [yaspeg.rootLayer addSublayer:radexGlowLayer];
}

#pragma mark -
#pragma mark ELR

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
   else if(eventType == MouseMove_ET)
   {
      if([radexLayer isInBounds:eventMousePoint])
      {
         radexGlowLayer.opacity = 1.0;
      }
      else
      {
         radexGlowLayer.opacity = 0;
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
      scenarioLayer.opacity = 1.0;
      radexLayer.opacity = 1.0;
      //radexGlowLayer.opacity = 1.0;
      headerLayer.y = 600 - 10 - headerLayer.h;
      
      [CATransaction commit];
      
      inited = YES;
   }
   
   
}

#pragma mark -
#pragma mark cleaning

/*
 * outro
 *
 *
 */

- (NSTimeInterval) outro
{
   NSTimeInterval animationDuration = 0.5;
   
   [CATransaction begin];
   [CATransaction setAnimationDuration_c:animationDuration];
   
   bgLayer.opacity = 0;
   scenarioLayer.opacity = 0;
   radexLayer.opacity = 0;
   radexGlowLayer.opacity = 0;
   headerLayer.y = 600;
   
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
   [bgLayer removeFromSuperlayer];
   [headerLayer removeFromSuperlayer];
   [scenarioLayer removeFromSuperlayer];
   [radexLayer removeFromSuperlayer];
   [radexGlowLayer removeFromSuperlayer];
}

@end

