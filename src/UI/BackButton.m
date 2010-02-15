//
//  BackButton.m
//  Yaspeg
//
//  Created by Radex on 10-01-14.
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

#import "BackButton.h"
#import "YaspegController.h"

@implementation BackButton

- (id)initWithTargetState:(NSString*)stateType
{
   if(self = [super init])
   {
      targetState = stateType;
      
      buttonLayer         = [ImageLayer layerWithImageNamed:@"back-button-unselected" frame:NSMakeRect(-50, 540, 50, 50)];
      selectedButtonLayer = [ImageLayer layerWithImageNamed:@"back-button-selected"   frame:NSMakeRect(-50, 540, 50, 50)];
      
      buttonLayer.opacity = -2;
      selectedButtonLayer.opacity = -2;
      
      [self addSublayer:buttonLayer];
      [self addSublayer:selectedButtonLayer];
   }
   
   return self;
}

+ (id)buttonWithTargetState:(NSString*)stateType
{
   return [[self alloc] initWithTargetState:stateType];
}

+ (id)button
{
   return [[self alloc] initWithTargetState:MainMenu_GS];
}

- (int)handleEvents
{
   if(gameState.eventType == KeyDown_ET)
   {
      if([gameState.eventCharachters characterAtIndex:0] == YK_ESC)
      {
         [yaspeg scheduleNextState:MainMenu_GS];
         return 0;
      }
   }
   
   if(gameState.eventType == MouseMove_ET || gameState.eventType == MouseDrag_ET)
   {
      if([buttonLayer isInBounds:gameState.eventMousePoint])
      {
         selectedButtonLayer.opacity = 1;
      }
      else
      {
         selectedButtonLayer.opacity = 0;
      }
   }
   
   if(gameState.eventType == MouseDown_ET && [buttonLayer isInBounds:gameState.eventMousePoint])
   {
      clicked = YES;
      buttonLayer.shadowColor   = CGColorCreateGenericRGB(80.0/256, 100.0/256, 50.0/256, 1);
      buttonLayer.shadowOffset  = CGSizeMake(0, 0);
      buttonLayer.shadowRadius  = 10;
      buttonLayer.shadowOpacity = 1;
   }
   
   if(gameState.eventType == MouseUp_ET)
   {
      buttonLayer.shadowOpacity = 0;
      
      if([buttonLayer isInBounds:gameState.eventMousePoint] && clicked)
      {
         [yaspeg scheduleNextState:targetState];
      }
      
      clicked = NO;
   }
   
   return 0;
}

- (void)handleIntro
{
   buttonLayer.x = 10;
   selectedButtonLayer.x = 10;
   
   buttonLayer.opacity = 1;
}

- (void)handleOutro
{
   buttonLayer.x = -50;
   selectedButtonLayer.x = -50;
   
   buttonLayer.opacity = -2;
   selectedButtonLayer.opacity = -2;
}

@end
