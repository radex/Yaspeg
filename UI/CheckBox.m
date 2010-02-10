//
//  CheckBox.m
//  Yaspeg
//
//  Created by Radex on 10-01-15.
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

#import "CheckBox.h"
#import "YaspegController.h"

@implementation CheckBox

@synthesize state;

- (id) initWithLabel:(NSString*)label position:(NSPoint)position
{
   if(self = [super init])
   {
      yaspeg    = [YaspegController sharedYaspegController];
      gameState = yaspeg.currentState;
      
      self.frame = CGRectMake(position.x, position.y, 800, 50);
      
      // box
      
      boxLayer = [ImageLayer layerWithImageNamed:@"checkbox"];
      boxLayer.opacity = -2;
      
      [self addSublayer:boxLayer];
      
      // flipped box
      
      boxFlippedLayer = [ImageLayer layerWithImageNamed:@"checkbox"];
      boxFlippedLayer.opacity   = 0;
      boxFlippedLayer.transform = CATransform3DMakeScale(1, -1, 1);
      
      [self addSublayer:boxFlippedLayer];
      
      // tick
      
      tickLayer = [ImageLayer layerWithImageNamed:@"checkbox-tick"];
      tickLayer.opacity = -0.5;
      tickLayer.y = 30;
      
      [self addSublayer:tickLayer];
      
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
      if([boxLayer isInBounds:gameState.eventMousePoint])
      {
         boxFlippedLayer.opacity = 1;
      }
      else
      {
         boxFlippedLayer.opacity = 0;
      }
   }
   
   if(gameState.eventType == MouseDown_ET && [boxLayer isInBounds:gameState.eventMousePoint])
   {
      clicked = YES;
      boxLayer.shadowColor   = CGColorCreateGenericRGB(80.0/256, 100.0/256, 50.0/256, 1);
      boxLayer.shadowOffset  = CGSizeMake(0, 0);
      boxLayer.shadowRadius  = 5;
      boxLayer.shadowOpacity = 1;
   }
   
   if(gameState.eventType == MouseUp_ET)
   {
      boxLayer.shadowOpacity = 0;
      
      if([boxLayer isInBounds:gameState.eventMousePoint] && clicked)
      {
         self.state = !state; // swapping state. "self." is needed to invoke setState
         
         return 1; // 1 if clicked
      }
      
      clicked = NO;
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
      tickLayer.y = 30;
      tickLayer.opacity = -0.5;
      [CATransaction commit];
      
      [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(tickSlideDown) userInfo:nil repeats:NO];
   }
   else
   {
      [CATransaction begin];
      [CATransaction setAnimationDuration_c:0.5];
      tickLayer.y = -30;
      tickLayer.opacity = -0.5;
      [CATransaction commit];
   }
}

- (void) tickSlideDown
{
   [CATransaction begin];
   [CATransaction setAnimationDuration_c:0.5];
   tickLayer.y = 0;
   tickLayer.opacity = 1;
   [CATransaction commit];
}

- (void) handleRender
{
   boxLayer.opacity   = 1;
   labelLayer.opacity = 1;
}

- (void) handleOutro
{
   boxLayer.opacity  = -2;
   boxFlippedLayer.opacity = -2;
   
   tickLayer.y       = -30;
   tickLayer.opacity = -0.5;
   
   labelLayer.opacity = 0;
}

@end
