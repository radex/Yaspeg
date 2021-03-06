//
//  SettingsState.m
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

#import "SettingsState.h"

@implementation SettingsState

/*
 * stateInit
 *
 *
 */

- (void) stateInit
{
   [Background genericBackground];
   [BackButton button];
   [Header     headerWithFilename:@"header-ustawienia"];
   
   // testing checkboxes, radio buttons, buttons etc etc
   
   testCheckBox = [CheckBox buttonWithLabel:@"testowanie ggyy" position:NSMakePoint(100, 50)];
   
   testRadioButton = [RadioButton buttonWithLabel:@"radio ggyy" position:NSMakePoint(100, 100)];
   testRadioButton.state = YES;
   
   testButton = [Button buttonWithLabel:@"testing foobar" position:NSMakePoint(400, 100) width:250];
   
   testGroup = [RadioButtonGroup buttonGroupWithLabels:[NSArray arrayWithObjects:@"test1", @"test2", @"test3", nil] current:1 position:NSMakePoint(100, 200)];
   
   // some text
   
   textLayer = [CATextLayer layer];
   textLayer.opacity  = 0;
   textLayer.string   = @"Tutaj w przyszłości będą ustawienia :)";
   textLayer.font     = @"palatino";
   textLayer.fontSize = 20;
   textLayer.foregroundColor = (CGColorRef)[NSColor blackColor];
   textLayer.frame = CGRectMake(25, 0, 800, 500);
   
   [yaspeg.rootLayer addSublayer:textLayer];
   
   // flash
   
   flashLayer = [CALayer layer];
   flashLayer.frame = CGRectMake(0, 0, 800, 600);
   flashLayer.backgroundColor = CGColorCreateGenericRGB(1, 1, 1, 1);
   flashLayer.opacity = 0;
   
   [yaspeg.rootLayer addSublayer:flashLayer];
   
   flashAnimation = [CABasicAnimation animation];
   flashAnimation.keyPath      = @"opacity";
   flashAnimation.repeatCount  = 1;
   flashAnimation.duration     = 0.3;
   flashAnimation.fromValue    = [NSNumber numberWithFloat:0];
   flashAnimation.toValue      = [NSNumber numberWithFloat:0.7];
   flashAnimation.autoreverses = YES;
}

/*
 * events
 *
 *
 */

- (void) events
{
   if([testButton handleEvents] == 1)
   {
      [flashLayer addAnimation:flashAnimation forKey:@"animateOpacity"];
   }
   
   [super handleEvents];
   
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
