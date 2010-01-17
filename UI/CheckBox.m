//
//  CheckBox.m
//  Yaspeg2
//
//  Created by Radex on 10-01-15.
//  Copyright 2010 Radex. All rights reserved.
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
      
      state = NO;
      
      self.frame = CGRectMake(position.x, position.y, 800, 50);
      
      // box
      
      boxLayer = [ImageLayer layerWithImageNamed:@"checkbox"];
      boxLayer.opacity  = -2;
      
      [self addSublayer:boxLayer];
      
      // tick
      
      tickLayer = [ImageLayer layerWithImageNamed:@"checkbox-tick"];
      tickLayer.opacity = -0.5;
      tickLayer.y = 30;
      
      [self addSublayer:tickLayer];
      
      // label
      
      labelLayer          = [CATextLayer layer];
      labelLayer.frame    = CGRectMake(45, 5, 750, 24);
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

- (void) handleEvents
{
   if(gameState.eventType == MouseUp_ET && [boxLayer isInBounds:gameState.eventMousePoint])
   {
      if(state == YES)
      {
         state = NO;
         
         [CATransaction begin];
         [CATransaction setAnimationDuration_c:0.5];
         tickLayer.y = -30;
         tickLayer.opacity = -0.5;
         [CATransaction commit];
      }
      else
      {
         state = YES;
         
         [CATransaction begin];
         [CATransaction setAnimationDuration_c:0];
         tickLayer.y = 30;
         tickLayer.opacity = -0.5;
         [CATransaction commit];
         
         [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(tickSlideDown) userInfo:nil repeats:NO];
      }
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
   tickLayer.y       = -30;
   tickLayer.opacity = -0.5;
   labelLayer.opacity = 0;
}

@end
