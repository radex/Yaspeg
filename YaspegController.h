//
//  MainMenuState.m
//  Yaspeg2
//
//  Created by Radex on 10-01-01.
//  Copyright 2010 Radex. All rights reserved.
//

#import "ImageLayer.h"
#import "CATransaction+radex.h"

#import "GameState.h"
#import "MainMenuState.h"
#import "HelpState.h"
#import "EditorState.h"
#import "DownloadState.h"
#import "AuthorsState.h"
#import "SettingsState.h"

@interface YaspegController : NSObject
{
   CALayer *rootLayer;
	IBOutlet NSView *contentView;
   
   GameState    *currentState;
   GameStateType nextState;
   bool          shouldUpdate;
}

@property (readonly) CALayer *rootLayer;
@property (readonly) GameState *currentState;

+ (YaspegController *)sharedYaspegController;

- (void) setNextState:(GameStateType) state;
- (void) scheduleNextState:(GameStateType) state;
- (IBAction) runAuthorsState: (id) sender;
- (IBAction) runHelp: (id) sender;

- (void) runYaspegHomepage;

@end
