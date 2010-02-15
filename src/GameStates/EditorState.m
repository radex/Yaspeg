//
//  EditorState.m
//  Yaspeg
//
//  Created by Radex on 10-01-14.
//  Copyright 2010 Radosław Pietruszewski. All rights reserved.
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
   [Background genericBackground];
   [BackButton button];
   [Header     headerWithFilename:@"header-edytor-poziomow"];
   
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
   [super handleEvents];
   
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
      
      [super handleIntro];
      
      textLayer.opacity = 1;
      
      [CATransaction commit];
      
      inited = YES;
   }
   
   
}

/*
 * outro
 *
 *
 */

- (void) outro
{
   textLayer.opacity = 0;
}

@end
