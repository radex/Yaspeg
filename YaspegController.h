//
//  MainMenuState.m
//  Yaspeg2
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

#import "CATransaction+radex.h"
#import "CALayer+radex.h"
#import "ImageLayer.h"

#import "GameState.h"
#import "MainMenuState.h"
#import "GameItselfState.h"
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

- (void) windowWillClose:(NSNotification *)aNotification;

- (void) setNextState:(GameStateType) state;
- (void) scheduleNextState:(GameStateType) state;
- (IBAction) runAuthorsState: (id) sender;
- (IBAction) runHelp: (id) sender;

- (void) runYaspegHomepage;

@end
