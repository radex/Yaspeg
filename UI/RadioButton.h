//
//  RadioButton.h
//  Yaspeg2
//
//  Created by Radex on 10-01-17.
//  Copyright 2010 Radex. All rights reserved.
//

#import "ImageLayer.h"
#import "GameState.h"

@class YaspegController;

@interface RadioButton : CALayer
{
   GameState        *gameState;
   YaspegController *yaspeg;
   
   bool state;
   
   ImageLayer  *circleLayer;
   ImageLayer  *dotLayer;
   CATextLayer *labelLayer;
}

@property (readwrite) bool state;

- (id)   initWithLabel:(NSString*)label position:(NSPoint)position;
+ (id) buttonWithLabel:(NSString*)label position:(NSPoint)position;

- (void) handleEvents;
- (void) handleRender;
- (void) handleOutro;

@end
