//
//  BackButton.h
//  Yaspeg2
//
//  Created by Radex on 10-01-14.
//  Copyright 2010 Radex. All rights reserved.
//

#import "ImageLayer.h"
#import "GameState.h"

@class YaspegController;

@interface BackButton : CALayer
{
   GameState        *state;
   YaspegController *yaspeg;
   GameStateType    targetState;
   
   ImageLayer *buttonLayer;
   ImageLayer *selectedButtonLayer;
}

- (id) initWithTargetState:(GameStateType)stateType;
+ (id) buttonWithTargetState:(GameStateType)stateType;

- (void) handleEvents;
- (void) handleRender;
- (void) handleOutro;

@end
