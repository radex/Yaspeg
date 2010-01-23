//
//  Button.h
//  Yaspeg2
//
//  Created by Radex on 10-01-23.
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

#import "ImageLayer.h"
#import "GameState.h"

@class YaspegController;

@interface Button : CALayer
{
   GameState        *gameState;
   YaspegController *yaspeg;
   
   ImageLayer  *leftLayer;
   ImageLayer  *rightLayer;
   ImageLayer  *bgLayer;
   
   ImageLayer  *leftFlippedLayer;
   ImageLayer  *rightFlippedLayer;
   ImageLayer  *bgFlippedLayer;
   
   CATextLayer *labelLayer;
}

@property (readwrite) bool state;

- (id)   initWithLabel:(NSString*)label position:(NSPoint)position width:(int)width;
+ (id) buttonWithLabel:(NSString*)label position:(NSPoint)position width:(int)width;

- (void) handleEvents;
- (void) handleRender;
- (void) handleOutro;

@end
