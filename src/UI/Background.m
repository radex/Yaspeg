//
//  Background.m
//  Yaspeg
//
//  Created by Radex on 10-02-12.
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

#import "Background.h"
#import "YaspegController.h"

@implementation Background

- (id)initWithFilename:(NSString*)name;
{
   if(self = [super init])
   {
      yaspeg    = [YaspegController sharedYaspegController];
      gameState = yaspeg.currentState;
      
      [gameState.handledObjects addObject:self];
      
      self.frame = CGRectMake(0, 0, 800, 600);
      
      // background
      
      image = [ImageLayer layerWithImageNamed:name];
      image.opacity = 0;
      
      [self addSublayer:image];
      
      /***/
      
      [self setNeedsDisplay];
      
      [yaspeg.rootLayer addSublayer:self];
   }
   
   return self;
}

+ (id) backgroundWithFilename:(NSString*)name
{
   return [[self alloc] initWithFilename:name];
}

+ (id) genericBackground
{
   return [[self alloc] initWithFilename:@"bg"];
}

- (int) handleEvents
{
   return 0;
}

- (void) handleIntro
{
   image.opacity = 1;
}

- (void) handleOutro
{
   image.opacity = 0;
}

@end