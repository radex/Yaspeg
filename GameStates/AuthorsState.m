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
   
   // back button
   
   backButton = [BackButton buttonWithTargetState:MainMenu_GS];
   
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
   
   // "podziękowaia" header
   
   thanksHeaderLayer = [CATextLayer layer];
   thanksHeaderLayer.opacity  = 0;
   thanksHeaderLayer.string   = @"Podziękowania:";
   thanksHeaderLayer.font     = @"palatino";
   thanksHeaderLayer.fontSize = 28;
   thanksHeaderLayer.foregroundColor = (CGColorRef)[NSColor blackColor];
   thanksHeaderLayer.frame = NSMakeRect(25, 250, 500, 70);
   
   [yaspeg.rootLayer addSublayer:thanksHeaderLayer];
   
   // "podziękowania" text
   
   thanksLayer = [CATextLayer layer];
   thanksLayer.opacity  = 0;
   thanksLayer.string   = @"- dla Matta Gallaghera (cocoawithlove.com) za świetne artykuły,\n  bez których Yaspeg by nie powstał.\n\n- dla użytkowników strony Stack Overflow (stackoverflow.com) za pomoc\n\n- dla MWL-a i wszystkich innych, którzy w jakiś sposób pomogli";
   thanksLayer.font     = @"palatino";
   thanksLayer.fontSize = 20;
   thanksLayer.foregroundColor = (CGColorRef)[NSColor blackColor];
   thanksLayer.frame = NSMakeRect(15, 0, 800, 275);
   
   [yaspeg.rootLayer addSublayer:thanksLayer];
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
   [backButton handleEvents];
   
   if(eventType == MouseMove_ET)
   {
      if([radexLayer isInBounds:eventMousePoint])
      {
         radexGlowLayer.opacity = 1;
      }
      else
      {
         radexGlowLayer.opacity = 0;
      }
   }
   else if(eventType == MouseDown_ET)
   {
      if([radexLayer isInBounds:eventMousePoint])
      {
         [yaspeg runYaspegHomepage];
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
      
      [backButton handleRender];
      
      bgLayer.opacity = 1;
      scenarioLayer.opacity = 1;
      radexLayer.opacity = 1;
      thanksLayer.opacity = 1;
      thanksHeaderLayer.opacity = 1;
      
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
   
   [backButton handleOutro];
   
   bgLayer.opacity = 0;
   scenarioLayer.opacity = 0;
   radexLayer.opacity = 0;
   radexGlowLayer.opacity = 0;
   thanksHeaderLayer.opacity = 0;
   thanksLayer.opacity = 0;
   
   headerLayer.y = 600;
   
   [CATransaction commit];
   
   [super scheduleCleanUp:animationDuration];
   
   return animationDuration;
}

@end

