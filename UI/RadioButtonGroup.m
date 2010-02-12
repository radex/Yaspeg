//
//  RadioButtonGroup.m
//  Yaspeg
//
//  Created by Radex on 10-01-24.
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

#import "RadioButtonGroup.h"
#import "YaspegController.h"

@implementation RadioButtonGroup

- (id) initWithLabels:(NSArray*)labels current:(int)current position:(NSPoint)position
{
   if(self = [super init])
   {
      yaspeg    = [YaspegController sharedYaspegController];
      gameState = yaspeg.currentState;
      
      [gameState.handledObjects addObject:self];
      
      self.frame = CGRectMake(position.x, position.y, 800, [labels count] * 50);
      
      // creating buttons
      
      int i = 0;
      
      buttons = [NSMutableArray array];
      
      for(NSString *label in labels)
      {
         [buttons addObject:[RadioButton buttonWithLabel:label position:NSMakePoint(0, i * 50)]];
         i++;
      }
      
      for(RadioButton *button in buttons) // RadioButton class automatically adds itself to rootLayer,
      {                                   // so we have to remove it from rootLayer, and add to [self]
         [button removeFromSuperlayer];
         [self addSublayer:button];
         
         [gameState.handledObjects removeObject:button]; // RadioButton class also sets up automatic events handling.
                                                         // But we don't want that.
      }
      
      // setting selected radio button
      
      selectedButton = current;
      
      RadioButton *b = [buttons objectAtIndex:selectedButton];
      b.state = YES;
      
      /***/
      
      [self setNeedsDisplay];
      
      [yaspeg.rootLayer addSublayer:self];
   }
   
   return self;
}

+ (id) buttonGroupWithLabels:(NSArray*)labels current:(int)current position:(NSPoint)position
{
   return [[self alloc] initWithLabels:labels current:current position:position];
}

- (int) handleEvents
{
   int i = 0;
   
   for(RadioButton *button in buttons)
   {
      if([button handleEvents] == 1)
      {
         // if one radio button has been selected, unselect others
         
         for(int j = 0; j < [buttons count]; j++)
         {
            if(j == i) continue;
            
            RadioButton *b = [buttons objectAtIndex:j];
            b.state = NO;
         }
         
         return 1;
      }
      
      button.eventsHandled = NO; // events in RadioButton are meant to be handled automatically,
                                 // but because we are preventing this, we have to explicitly mark it as handled.
                                 // (I know that the expression eventsHandled = NO seems to do something opposite)
      
      i++;
   }
   
   return 0;
}

- (void) handleRender
{
   for(RadioButton *button in buttons)
   {
      [button handleRender];
   }
}

- (void) handleOutro
{
   for(RadioButton *button in buttons)
   {
      [button handleOutro];
   }
}

@end
