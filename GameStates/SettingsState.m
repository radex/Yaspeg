//
//  SettingsState.m
//  Yaspeg2
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
   [backButton handleEvents];
   [testCheckBox handleEvents];
   [testRadioButton handleEvents];
   [testGroup handleEvents];
   
   if([testButton handleEvents] == 1)
   {
      [flashLayer addAnimation:flashAnimation forKey:@"animateOpacity"];
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
      [testRadioButton handleRender];
      [testButton handleRender];
      [testGroup handleRender];
      
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
   [testRadioButton handleOutro];
   [testButton handleOutro];
   [testGroup handleOutro];
   
   bgLayer.opacity = 0;
   textLayer.opacity = 0;
   
   headerLayer.y = 600;
   
   [CATransaction commit];
   
   [super scheduleCleanUp:animationDuration];
   
   return animationDuration;
}

@end
