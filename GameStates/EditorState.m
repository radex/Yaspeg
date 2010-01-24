//
//  EditorState.m
//  Yaspeg
//
//  Created by Radex on 10-01-14.
//  Copyright 2010 Radex. All rights reserved.
//  
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//  
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//  
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#import "EditorState.h"

@implementation EditorState

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
   
   headerLayer = [ImageLayer layerWithImageNamed:@"header-edytor-poziomow"];
   headerLayer.x = (800 - headerLayer.w) / 2;
   headerLayer.y = 600;
   
   [yaspeg.rootLayer addSublayer:headerLayer];
   
   // back button
   
   backButton = [BackButton buttonWithTargetState:MainMenu_GS];
   
   // some text
   
   textLayer = [CATextLayer layer];
   textLayer.opacity  = 0;
   textLayer.string   = @"Tutaj w przyszłości będzie edytor poziomów :)";
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
   
   bgLayer.opacity = 0;
   textLayer.opacity = 0;
   
   headerLayer.y = 600;
   
   [CATransaction commit];
   
   [super scheduleCleanUp:animationDuration];
   
   return animationDuration;
}

@end
