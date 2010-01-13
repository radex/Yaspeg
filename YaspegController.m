//
//  MainMenuState.m
//  Yaspeg2
//
//  Created by Radex on 10-01-01.
//  Copyright 2010 Radex. All rights reserved.
//

#import "YaspegController.h"
#import "SynthesizeSingleton.h"

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
	contentView.layer.backgroundColor = CGColorCreateGenericRGB(0, 0, 0, 1);
	CGColorRelease(contentView.layer.backgroundColor);
   
   rootLayer = [CALayer layer];
   rootLayer.frame = CGRectMake(0, 0, 800, 600);
   rootLayer.masksToBounds = YES;
   
   [contentView.layer insertSublayer:rootLayer atIndex:0];
   
   [self setNextState:MainMenu_GS];
   
   shouldUpdate = YES;
   
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
   NSTimeInterval outroTime = [currentState outro];
   
   [NSTimer scheduledTimerWithTimeInterval:outroTime target:self selector:@selector(terminate) userInfo:nil repeats:NO];
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
}

/*
 * setNextState
 *
 * closes current state, and launches new one
 */

- (void) setNextState: (GameStateType) state
{
   if(nextState != None_GS)
   {
      state = nextState;
   }
   else
   {
      [currentState outro];
   }

   
   switch (state)
   {
      case MainMenu_GS: currentState = [[MainMenuState alloc] init]; break;
      case Authors_GS:  currentState = [[AuthorsState  alloc] init]; break;
      default: break;
   }
   
   currentState.yaspeg = self;
   [currentState stateInit];
   nextState = None_GS;
   shouldUpdate = YES;
}

/*
 * scheduledNextState
 *
 * schedules to launch nextState
 * (it will launch after outro)
 */

- (void) scheduledNextState: (GameStateType) state
{
   shouldUpdate = NO;
   nextState = state;
   
   NSTimeInterval outroTime = 0.3 * [currentState outro];
   
   [NSTimer scheduledTimerWithTimeInterval:outroTime target:self selector:@selector(setNextState:) userInfo:nil repeats:NO];
}

@end
