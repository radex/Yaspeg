//
//  GameState.m
//  Yaspeg
//
//  Created by Radex on 10-01-03.
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

#import "GameState.h"
#import "YaspegController.h"

@implementation GameState

@synthesize yaspeg, eventType, eventIsRepeat, eventCharachters, eventMousePoint, handledObjects;

- (id) init
{
   if(self = [super init])
   {
      eventType = None_ET;
      inited    = NO;
      handledObjects = [NSMutableArray array];
   }
   
   return self;
}

- (void) stateInit{}
- (void) events{eventType = None_ET;}
- (void) logic{}
- (void) render{}

- (void) handleEvents
{
   for(id object in handledObjects)
   {
      [object handleEvents];
   }
}

- (void) handleIntro
{
   for(id object in handledObjects)
   {
      [object handleIntro];
   }
}

- (void) handleOutro
{
   for(id object in handledObjects)
   {
      [object handleOutro];
   }
}

- (void) outro{}

- (void) scheduleCleanUp
{
   removedObjects = [[YaspegController sharedYaspegController].rootLayer.sublayers copy];
   
   [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(cleanUp) userInfo:nil repeats:NO];
}

- (void) cleanUp
{
   for(CALayer *layer in removedObjects)
   {
      [layer removeFromSuperlayer];
   }
}

@end
