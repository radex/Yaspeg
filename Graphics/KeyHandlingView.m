//
//  KeyHandlingView.m
//  Yaspeg
//
//  Created by Radex on 10-01-09.
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
   yaspeg.currentState.eventType = KeyUp_ET;
   yaspeg.currentState.eventCharachters = event.characters;
   yaspeg.currentState.eventIsRepeat = event.isARepeat;
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

- (void)mouseMoved:(NSEvent *)event
{
   if(yaspeg.currentState.eventType != None_ET) return; // keyDown event have priority
   
   yaspeg.currentState.eventType = MouseMove_ET;
   yaspeg.currentState.eventMousePoint = [self convertPoint:event.locationInWindow fromView:nil];
}

@end
