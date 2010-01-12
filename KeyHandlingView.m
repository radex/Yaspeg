//
//  KeyHandlingView.m
//  Yaspeg2
//
//  Created by Radex on 10-01-09.
//  Copyright 2010 Radex. All rights reserved.
//

#import "KeyHandlingView.h"

@implementation KeyHandlingView

- (BOOL)acceptsFirstResponder
{
	return YES;
}

- (void)keyDown:(NSEvent *)event
{
   yaspeg.currentState.eventType = KeyDown_ET;
   yaspeg.currentState.eventCharachters = event.characters;
   yaspeg.currentState.eventIsRepeat = event.isARepeat;
}

- (void)keyUp:(NSEvent *)event
{
}

- (void)mouseDown:(NSEvent *)event
{
   yaspeg.currentState.eventType = MouseDown_ET;
   yaspeg.currentState.eventMousePoint = [self convertPoint:event.locationInWindow fromView:nil];
}

- (void)mouseUp:(NSEvent *)event
{
   yaspeg.currentState.eventType = MouseUp_ET;
   yaspeg.currentState.eventMousePoint = [self convertPoint:event.locationInWindow fromView:nil];
}

- (void)mouseDragged:(NSEvent *)event
{
   yaspeg.currentState.eventType = MouseDrag_ET;
   yaspeg.currentState.eventMousePoint = [self convertPoint:event.locationInWindow fromView:nil];
}

@end
