//
//  MainMenuState.m
//  Yaspeg2
//
//  Created by Radex on 10-01-01.
//  Copyright 2010 Radex. All rights reserved.
//

#import "ImageLayer.h"
#import "myBitmapContext.h"

#import "GameState.h"
#import "GameStates/MainMenuState.h"

@interface YaspegController : NSObject
{
   CALayer *rootLayer;
	IBOutlet NSView *contentView;
   
	NSTimer *timer;
   
   GameState *currentState;
}

@property (readonly) CALayer *rootLayer;
@property (readonly) GameState *currentState;

+ (YaspegController *)sharedYaspegController;

- (void) setNextState:(GameStateType) state;

@end
