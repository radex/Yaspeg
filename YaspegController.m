//
//  MainMenuState.m
//  Yaspeg
//
//  Created by Radex on 10-01-01.
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

#import "YaspegController.h"
#import "SynthesizeSingleton.h"

#import "MainMenuState.h"
#import "TestState.h"

@implementation YaspegController

@synthesize rootLayer, currentState;

SYNTHESIZE_SINGLETON_FOR_CLASS(YaspegController);

/*
 * awakeFromNib
 *
 * makes root layer and sets initial state
 */

- (void)awakeFromNib
{
   rootLayer = contentView.layer;
   rootLayer.masksToBounds = YES;
	rootLayer.backgroundColor = CGColorCreateGenericRGB(0, 0, 0, 1);
	CGColorRelease(rootLayer.backgroundColor);
   
   [[contentView window] setAcceptsMouseMovedEvents:YES];
   
   // setting up main menu
   
   currentState = [[TestState alloc] init];
   currentState.yaspeg = self;
   
   [currentState stateInit];
   
   shouldUpdate = YES;
   
   // scheduling main timer
   
   [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(updateState) userInfo:nil repeats:YES];
}

/*
 * windowWillClose
 *
 * terminates Yaspeg if window closed
 */

- (void)windowWillClose:(NSNotification *)aNotification
{
   shouldUpdate = NO;
   
   [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(terminate) userInfo:nil repeats:NO];
}

- (void)terminate
{
   [NSApp performSelectorOnMainThread:@selector(terminate:) withObject:self waitUntilDone:NO];
}

#pragma mark -
#pragma mark state machine

/*
 * updateState
 *
 * updates state. launched every frame by timer initialized in awakeFromNib
 */

- (void)updateState
{
   if(!shouldUpdate) return;
   
   [currentState events];
   [currentState logic];
   [currentState render];
   
   for(id object in currentState.handledObjects)
   {
      if([object respondsToSelector:@selector(setEventsHandled:)])
      {
         [object setEventsHandled:NO];
      }
   }
}

/*
 * setNextState
 *
 * closes current state, and launches new one
 */

- (void) setNextState: (NSTimer*) timer
{
   NSString *state = [timer userInfo];
   
   currentState = [[NSClassFromString([state stringByAppendingString:@"State"]) alloc] init];
   currentState.yaspeg = self;
   
   [currentState stateInit];
   
   shouldUpdate = YES;
}

/*
 * scheduleNextState
 *
 * schedules to launch nextState
 * (it will launch after outro)
 */

- (void) scheduleNextState: (NSString*) state
{
   shouldUpdate = NO;
   
   [CATransaction begin];
   [CATransaction setAnimationDuration_c:0.5];
   
   [currentState handleOutro];
   [currentState outro];
   
   [CATransaction commit];
   
   [currentState scheduleCleanUp:0.5];
   
   [NSTimer scheduledTimerWithTimeInterval:0.5 * 0.3 target:self selector:@selector(setNextState:) userInfo:state repeats:NO];
}

/*
 * runAuthorsState
 *
 *
 */

- (IBAction) runAuthorsState: (id) sender
{
   [self scheduleNextState:Authors_GS];
}

/*
 * runHelp
 *
 *
 */

- (IBAction) runHelp: (id) sender
{
   [self scheduleNextState:Help_GS];
}

#pragma mark -
#pragma mark various stuff

- (void) runYaspegHomepage
{
   [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://example.com/"]];
}

@end
