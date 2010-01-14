//
//  BackButton.h
//  Yaspeg2
//
//  Created by Radex on 10-01-14.
//  Copyright 2010 Radex. All rights reserved.
//

#import "ImageLayer.h"
#import "GameState.h"

@interface BackButton : CALayer
{
   GameState *state;
   YaspegController *yaspeg;
   GameStateType leadingState;
   
   ImageLayer *buttonLayer;
   ImageLayer *selectedButtonLayer;
}

- (id) initWithLeadingState:(GameStateType)stateType sender:(GameState*)sender;
+ (id) buttonWithLeadingState:(GameStateType)stateType sender:(GameState*)sender;

- (void) handleEvents;
- (void) handleRender;
- (void) handleOutro;

@end
