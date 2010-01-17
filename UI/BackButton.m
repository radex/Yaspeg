//
//  BackButton.m
//  Yaspeg2
//
//  Created by Radex on 10-01-14.
//  Copyright 2010 Radex. All rights reserved.
//

#import "BackButton.h"
#import "YaspegController.h"

@implementation BackButton

- (id)initWithTargetState:(GameStateType)stateType
{
   if(self = [super init])
   {
      yaspeg = [YaspegController sharedYaspegController];
      state = yaspeg.currentState;
      
      targetState = stateType;
      
      buttonLayer         = [ImageLayer layerWithImageNamed:@"back-button-unselected" frame:NSMakeRect(-50, 540, 50, 50)];
      selectedButtonLayer = [ImageLayer layerWithImageNamed:@"back-button-selected"   frame:NSMakeRect(-50, 540, 50, 50)];
      
      buttonLayer.opacity = -2;
      selectedButtonLayer.opacity = -2;
      
      [self addSublayer:buttonLayer];
      [self addSublayer:selectedButtonLayer];
      [self setNeedsDisplay];
      
      [yaspeg.rootLayer addSublayer:self];
   }
   
   return self;
}

+ (id)buttonWithTargetState:(GameStateType)stateType
{
   return [[self alloc] initWithTargetState:stateType];
}

- (void)handleEvents
{
   if(state.eventType == KeyDown_ET)
   {
      if([state.eventCharachters characterAtIndex:0] == YK_ESC)
      {
         [yaspeg scheduleNextState:MainMenu_GS];
         return;
      }
   }
   else if(state.eventType == MouseMove_ET)
   {
      if([buttonLayer isInBounds:state.eventMousePoint])
      {
         selectedButtonLayer.opacity = 1;
      }
      else
      {
         selectedButtonLayer.opacity = 0;
      }
   }
   else if(state.eventType == MouseUp_ET)
   {
      if([buttonLayer isInBounds:state.eventMousePoint])
      {
         [yaspeg scheduleNextState:targetState];
      }
   }
   
}

- (void)handleRender
{
   buttonLayer.x = 10;
   selectedButtonLayer.x = 10;
   
   buttonLayer.opacity = 1;
}

- (void)handleOutro
{
   buttonLayer.x = -50;
   selectedButtonLayer.x = -50;
   
   buttonLayer.opacity = -2;
   selectedButtonLayer.opacity = -2;
}

@end
