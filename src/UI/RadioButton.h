//
//  RadioButton.h
//  Yaspeg
//
//  Created by Radex on 10-01-17.
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

#import "SomeButton.h"

@interface RadioButton : SomeButton
{
   ImageLayer  *circleLayer;
   ImageLayer  *circleFlippedLayer;
   ImageLayer  *dotLayer;
   CATextLayer *labelLayer;
   
   bool state;
   bool selectable;
}

@property (readwrite) bool state;
@property (readwrite) bool selectable;

- (id)   initWithLabel:(NSString*)label position:(NSPoint)position;
+ (id) buttonWithLabel:(NSString*)label position:(NSPoint)position;

@end
