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
      
      buttonImage = [NSImage imageNamed:@"back-button-unselected"];
      buttonSelectedImage = [NSImage imageNamed:@"back-button-selected"];
      
		self.x = -50;
      self.y = 540;
      self.opacity = -2;
      self.w = 50;
      self.h = 50;
      
      selected = NO;
      
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
      if([self isInBounds:state.eventMousePoint])
      {
         selected = YES;
         [self setNeedsDisplay];
      }
      else
      {
         selected = NO;
         [self setNeedsDisplay];
      }
   }
   else if(state.eventType == MouseDown_ET)
   {
      if([self isInBounds:state.eventMousePoint])
      {
         [yaspeg scheduledNextState:leadingState];
      }
   }
   
}

- (void)handleRender
{
   self.x = 10;
   self.opacity = 1;
}

- (void)handleOutro
{
   self.x = -50;
   self.opacity = -2;
}

- (void)drawInContext:(CGContextRef)ctx
{
	NSGraphicsContext *oldContext = [NSGraphicsContext currentContext];
	NSGraphicsContext *context    = [NSGraphicsContext graphicsContextWithGraphicsPort:ctx flipped:NO];
   
	NSGraphicsContext.currentContext = context;
	
   if(selected)
   {
      [buttonSelectedImage
       drawInRect:NSRectFromCGRect(self.bounds)
       fromRect:[buttonImage alignmentRect]
       operation:NSCompositeSourceOver
       fraction:1.0];
   }
   else
	{
      [buttonImage
       drawInRect:NSRectFromCGRect(self.bounds)
       fromRect:[buttonImage alignmentRect]
       operation:NSCompositeSourceOver
       fraction:1.0];
	}
   
	NSGraphicsContext.currentContext = oldContext;
}

@end
