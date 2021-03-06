//
//  ModalAlert.h
//  Yaspeg
//
//  Created by Radex on 10-02-11.
//  Copyright 2010 Radosław Pietruszewski. All rights reserved.
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
#import "Button.h"

@class YaspegController;

@interface ModalAlert : CALayer
{
   GameState        *gameState;
   YaspegController *yaspeg;
   
   CALayer *shadyLayer;
   CALayer *boxLayer;
   CATextLayer *headerLayer;
   CATextLayer *descriptionLayer;
   Button *okButton;
}

- (id)           initWithHeader:(NSString*)header description:(NSString*)description;
+ (void) displayAlertWithHeader:(NSString*)header description:(NSString*)description;

+ (bool) handleEvents;
- (bool) intHandleEvents;

@end
