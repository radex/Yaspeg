//
//  SettingsState.m
//  Yaspeg2
//
//  Created by Radex on 10-01-14.
//  Copyright 2010 Radex. All rights reserved.
//

#import "SettingsState.h"

@implementation SettingsState

/*
 * stateInit
 *
 *
 */

- (void) stateInit
{
   // background
   
   bgLayer = [ImageLayer layerWithImageNamed:@"bg"];
   bgLayer.opacity = 0;
   
   [yaspeg.rootLayer addSublayer:bgLayer];
   
   // header
   
   headerLayer = [ImageLayer layerWithImageNamed:@"header-ustawienia"];
   headerLayer.x = (800 - headerLayer.w) / 2;
   headerLayer.y = 600;
   
   [yaspeg.rootLayer addSublayer:headerLayer];
   
   // back button
   
   backButton = [BackButton buttonWithTargetState:MainMenu_GS];
   
   // testing checkboxes, radio buttons, buttons etc etc
   
   testCheckBox = [CheckBox buttonWithLabel:@"testowanie bla bla bla" position:NSMakePoint(100, 50)];
   
   // some text
   
   textLayer = [CATextLayer layer];
   textLayer.opacity  = 0;
   textLayer.string   = @"Tutaj w przyszłości będą ustawienia :)";
   textLayer.font     = @"palatino";
   textLayer.fontSize = 20;
   textLayer.foregroundColor = (CGColorRef)[NSColor blackColor];
   textLayer.frame = CGRectMake(25, 0, 800, 300);
   
   [yaspeg.rootLayer addSublayer:textLayer];
}

/*
 * events
 *
 *
 */

- (void) events
{
   [backButton handleEvents];
   [testCheckBox handleEvents];
   
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
      [CATransaction begin];
      [CATransaction setAnimationDuration_c:0.5];
      
      [backButton handleRender];
      [testCheckBox handleRender];
      
      bgLayer.opacity = 1;
      textLayer.opacity = 1;
      
      headerLayer.y = 600 - 10 - headerLayer.h;
      
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
   NSTimeInterval animationDuration = 0.5;
   
   [CATransaction begin];
   [CATransaction setAnimationDuration_c:animationDuration];
   
   [backButton handleOutro];
   [testCheckBox handleOutro];
   
   bgLayer.opacity = 0;
   textLayer.opacity = 0;
   
   headerLayer.y = 600;
   
   [CATransaction commit];
   
   [super scheduleCleanUp:animationDuration];
   
   return animationDuration;
}

@end
