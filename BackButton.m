//
//  BackButton.m
//  Yaspeg2
//
//  Created by Radex on 10-01-14.
//  Copyright 2010 Radex. All rights reserved.
//

#import "BackButton.h"


@implementation BackButton

#pragma mark -
#pragma mark initializers

- (id)initWithImageNamed:(NSString *)newImageName frame:(NSRect)newFrame{return nil;}   /* thou shall not use it */
- (id)initWithImageNamed:(NSString *)newImageName{return nil;}
+ (id)layerWithImageNamed:(NSString *)newImageName frame:(NSRect)newFrame{return nil;}
+ (id)layerWithImageNamed:(NSString *)newImageName{return nil;}

- (id)initWithLeadingState:(GameStateType)stateType sender:(GameState*)sender
{
   if(self = [super init])
   {
      state = sender;
      yaspeg = sender.yaspeg;
      leadingState = stateType;
      
      buttonLayer         = [ImageLayer layerWithImageNamed:@"back-button-unselected" frame:NSMakeRect(-50, 540, 50, 50)];
      selectedButtonLayer = [ImageLayer layerWithImageNamed:@"back-button-selected"   frame:NSMakeRect(-50, 540, 50, 50)];
      
      buttonLayer.opacity = -2;
      selectedButtonLayer.opacity = -2;
      
      [self addSublayer:buttonLayer];
      [self addSublayer:selectedButtonLayer];
      
      [self setNeedsDisplay];
      [[yaspeg rootLayer] addSublayer:self];
   }
   
   return self;
}

+ (id)buttonWithLeadingState:(GameStateType)stateType sender:(GameState*)sender
{
   return [[self alloc] initWithLeadingState:stateType sender:sender];
}

- (void)handleEvents
{
   if(state.eventType == MouseMove_ET)
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
   else if(state.eventType == MouseDown_ET)
   {
      if([buttonLayer isInBounds:state.eventMousePoint])
      {
         [yaspeg scheduledNextState:leadingState];
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