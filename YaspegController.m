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
   rootLayer = contentView.layer;
   rootLayer.masksToBounds = YES;
	rootLayer.backgroundColor = CGColorCreateGenericRGB(0, 0, 0, 1);
	CGColorRelease(rootLayer.backgroundColor);
   
   [[contentView window] setAcceptsMouseMovedEvents:YES];
   
   [self setNextState:MainMenu_GS];
   
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
      case MainMenu_GS: currentState = [[MainMenuState   alloc] init]; break;
      case Game_GS:     currentState = [[GameItselfState alloc] init]; break;
      case Help_GS:     currentState = [[HelpState       alloc] init]; break;
      case Editor_GS:   currentState = [[EditorState     alloc] init]; break;
      case Download_GS: currentState = [[DownloadState   alloc] init]; break;
      case Authors_GS:  currentState = [[AuthorsState    alloc] init]; break;
      case Settings_GS: currentState = [[SettingsState   alloc] init]; break;
      default: break;
   }
   
   currentState.yaspeg = self;
   [currentState stateInit];
   nextState = None_GS;
   shouldUpdate = YES;
}

/*
 * scheduleNextState
 *
 * schedules to launch nextState
 * (it will launch after outro)
 */

- (void) scheduleNextState: (GameStateType) state
{
   shouldUpdate = NO;
   nextState = state;
   
   NSTimeInterval outroTime = 0.3 * [currentState outro];
   
   [NSTimer scheduledTimerWithTimeInterval:outroTime target:self selector:@selector(setNextState:) userInfo:nil repeats:NO];
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
