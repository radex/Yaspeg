//
//  RadioButton.m
//  Yaspeg
//
//  Created by Radex on 10-01-17.
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

#import "RadioButton.h"
#import "YaspegController.h"

@implementation RadioButton

@synthesize state;

- (id) initWithLabel:(NSString*)label position:(NSPoint)position
{
   if(self = [super init])
   {
      yaspeg    = [YaspegController sharedYaspegController];
      gameState = yaspeg.currentState;
      
      self.frame = CGRectMake(position.x, position.y, 800, 50);
      
      // circle
      
      circleLayer = [ImageLayer layerWithImageNamed:@"radio-button"];
      circleLayer.opacity = -2;
      
      [self addSublayer:circleLayer];
      
      // flipped circle
      
      circleFlippedLayer = [ImageLayer layerWithImageNamed:@"radio-button"];
      circleFlippedLayer.opacity   = 0;
      circleFlippedLayer.transform = CATransform3DMakeScale(1, -1, 1);
      
      [self addSublayer:circleFlippedLayer];
      
      // dot
      
      dotLayer = [ImageLayer layerWithImageNamed:@"radio-button-dot"];
      dotLayer.opacity = 0;
      
      [self addSublayer:dotLayer];
      
      // label
      
      labelLayer          = [CATextLayer layer];
      labelLayer.frame    = CGRectMake(45, 0, 750, 30);
      labelLayer.font     = @"palatino";
      labelLayer.fontSize = 24;
      labelLayer.string   = label;
      labelLayer.foregroundColor = CGColorCreateGenericRGB(0, 0, 0, 1);
      labelLayer.opacity  = 0;
      
      [self addSublayer:labelLayer];
      
      /***/
      
      [self setNeedsDisplay];
      
      [yaspeg.rootLayer addSublayer:self];
   }
   
   return self;
}

+ (id) buttonWithLabel:(NSString*)label position:(NSPoint)position
{
   return [[self alloc] initWithLabel:label position:position];
}

- (int) handleEvents
{
   if(gameState.eventType == MouseMove_ET || gameState.eventType == MouseDrag_ET)
   {
      if([circleLayer isInBounds:gameState.eventMousePoint])
      {
         circleFlippedLayer.opacity = 1;
      }
      else
      {
         circleFlippedLayer.opacity = 0;
      }
   }
   
   if(gameState.eventType == MouseDown_ET && [circleLayer isInBounds:gameState.eventMousePoint])
   {
      circleLayer.shadowColor   = CGColorCreateGenericRGB(80.0/256, 100.0/256, 50.0/256, 1);
      circleLayer.shadowOffset  = CGSizeMake(0, 0);
      circleLayer.shadowRadius  = 5;
      circleLayer.shadowOpacity = 1;
   }
   
   if(gameState.eventType == MouseUp_ET)
   {
      circleLayer.shadowOpacity = 0;
      
      if([circleLayer isInBounds:gameState.eventMousePoint])
      {
         self.state = !state; // swapping state. "self." is needed to invoke setState
         
         return 1; // state changed
      }
   }
   
   return 0; // nothing happened
}

- (void) setState:(bool)newState
{
   if(state == newState) return;
   
   state = newState;
   
   if(newState)
   {
      [CATransaction begin];
      [CATransaction setAnimationDuration_c:0];
      dotLayer.opacity = -0.5;
      dotLayer.x = -32;
      dotLayer.y = -32;
      dotLayer.w = 96;
      dotLayer.h = 96;
      [CATransaction commit];
      
      [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(dotRevert) userInfo:nil repeats:NO];
   }
   else
   {
      [CATransaction begin];
      [CATransaction setAnimationDuration_c:0.5];
      dotLayer.x = 16;
      dotLayer.y = 16;
      dotLayer.w = 0;
      dotLayer.h = 0;
      dotLayer.opacity = 0;
      [CATransaction commit];
   }
}

- (void) dotRevert
{
   [CATransaction begin];
   [CATransaction setAnimationDuration_c:0.5];
   dotLayer.y = 0;
   dotLayer.x = 0;
   dotLayer.w = 32;
   dotLayer.h = 32;
   dotLayer.opacity = 1;
   [CATransaction commit];
}

- (void) handleRender
{
   circleLayer.opacity = 1;
   labelLayer.opacity  = 1;
}

- (void) handleOutro
{
   circleLayer.opacity = -2;
   circleFlippedLayer.opacity = -2;
   
   dotLayer.x = 16;
   dotLayer.y = 16;
   dotLayer.w = 0;
   dotLayer.h = 0;
   dotLayer.opacity = 0;
   
   labelLayer.opacity  = 0;
}

@end
