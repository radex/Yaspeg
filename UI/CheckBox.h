//
//  CheckBox.h
//  Yaspeg2
//
//  Created by Radex on 10-01-15.
//  Copyright 2010 Radex. All rights reserved.
//

#import "ImageLayer.h"
#import "GameState.h"

@class YaspegController;

@interface CheckBox : CALayer
{
   GameState        *gameState;
   YaspegController *yaspeg;
   
   bool state;
   
   ImageLayer  *boxLayer;
   ImageLayer  *tickLayer;
   CATextLayer *labelLayer;
}

@property (readwrite) bool state;

- (id)   initWithLabel:(NSString*)label position:(NSPoint)position;
+ (id) buttonWithLabel:(NSString*)label position:(NSPoint)position;

- (void) handleEvents;
- (void) handleRender;
- (void) handleOutro;

@end
