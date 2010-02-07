//
//  GameItselfState.m
//  Yaspeg
//
//  Created by Radex on 10-01-15.
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

#import "GameItselfState.h"

@implementation GameItselfState

/*
 * stateInit
 *
 *
 */

- (void) stateInit
{
   // bg
   
   bg = [ImageLayer layerWithImageNamed:@"bg2"];
   bg.opacity = 0;
   [yaspeg.rootLayer addSublayer:bg];
   
   // dude
   
   dude = [ImageLayer layerWithImageNamed:@"dude"];
   dude.opacity = 0;
   [yaspeg.rootLayer addSublayer:dude];
   
   // vars
   
   x = 0;
   y = 20;
   
   speed = 0;
   runSpeed = 20;
   bonusSpeed = 0;
   ySpeed = 0;
   
   maxSpeed = 10;
   runTime = 0;
   
   left = false;
   right = false;
   up = false;
   
   // info
   
   info = [CATextLayer layer];
   info.frame = CGRectMake(0, 550, 800, 50);
   info.fontSize = 15;
   [yaspeg.rootLayer addSublayer:info];
   
   /***/
   
   [self testing];
}

/*
 * events
 *
 *
 */

- (void) events
{
   if(eventType == KeyDown_ET && !eventIsRepeat)
   {
      unichar pressedKey = [eventCharachters characterAtIndex:0];
      
      switch(pressedKey)
      {
         case YK_ESC:
            [yaspeg scheduleNextState:MainMenu_GS];
            return;
         case NSRightArrowFunctionKey:
            right = true;
            left  = false;
            break;
         case NSLeftArrowFunctionKey:
            left  = true;
            right = false;
            break;
         case NSUpArrowFunctionKey:
            up    = true;
            break;
      }
   }
   else if(eventType == KeyUp_ET && !eventIsRepeat)
   {
      unichar pressedKey = [eventCharachters characterAtIndex:0];
      switch(pressedKey)
      {
         case NSRightArrowFunctionKey:
            right   = false;
            runTime = 0;
            break;
         case NSLeftArrowFunctionKey:
            left    = false;
            runTime = 0;
            break;
         case NSUpArrowFunctionKey:
            up      = false;
            break;
      }
   }
   
   eventType = None_ET;
}

/*
 * logic
 *
 *
 */

- (void) logic
{
   // jump
   
   if(up && ySpeed == 0 && y == 20)
   {
      ySpeed = 13;
      //up = false;
   }
   
   // run speed
   
   if(right || left)
   {
      if(runTime < 50)
      {
         runSpeed = (right ? 1 : -1) * (maxSpeed - 1) * (runTime / 50.0) + (right ? 1 : -1);
      }
      
      runTime++;
   }
   
   // slow down if not running
   
   if(!right && !left && !up && ySpeed == 0 && y == 20)
   {
      if(runSpeed > 0.5)
      {
         runSpeed -= 0.5;
      }
      else if(runSpeed < -0.5)
      {
         runSpeed += 0.5;
      }
      else
      {
         runSpeed = 0;
      }
   }
   
   // slowing bonus speed
   
   if(bonusSpeed > 0.5)
   {
      bonusSpeed -= 0.5;
   }
   else if(bonusSpeed < -0.5)
   {
      bonusSpeed += 0.5;
   }
   else
   {
      bonusSpeed = 0;
   }
   
   // Y axis speed
   
   if(y > 20 || ySpeed > 1)
   {
      if(y + ySpeed <= 20)
      {
         ySpeed = 0;
         y = 20;
      }
      else
      {
         ySpeed -= 0.5;
      }
   }
   else
   {
      ySpeed = 0;
   }
   
   /***/
   
   speed = runSpeed + bonusSpeed;
   
   x += speed;
   y += ySpeed;
   
   // bounds
   
   if(x + speed < 0)
   {
      x = 0;
      speed = 0;
      runSpeed = -0.5 * runSpeed;
      bonusSpeed = 0;
      ySpeed = 0;
   }
   else if(x + speed > 800 - 32)
   {
      x = 800 - 32;
      speed = 0;
      runSpeed = -0.5 * runSpeed;
      bonusSpeed = 0;
      ySpeed = 0;
   }
}

/*
 * render
 *
 *
 */

- (void) render
{
   // rendering for first time
   
   if(!inited)
   {
      [CATransaction begin];
      [CATransaction setAnimationDuration_c:0.5];
      
      bg.opacity = 1;
      dude.opacity = 1;
      
      [CATransaction commit];
      
      inited = YES;
   }
   info.string = [NSString stringWithFormat:@"x:%1.2f y:%1.2f", x, y];
   
   
   [CATransaction begin];
   [CATransaction setAnimationDuration_c:0];
   
   dude.x = (int) x;
   dude.y = (int) y;
   
   [CATransaction commit];
}

/*
 * outro
 *
 *
 */

- (NSTimeInterval) outro
{
   NSTimeInterval animationDuration = 0.5;
   
   [CATransaction begin];
   [CATransaction setAnimationDuration_c:animationDuration];
   
   bg.opacity = 0;
   dude.opacity = 0;
   info.opacity = 0;
   
   [CATransaction commit];
   
   [super scheduleCleanUp:animationDuration];
   
   return animationDuration;
}


/*
 * XML testing
 *
 *
 */

-(void) testing
{
   NSString *path = [[NSBundle mainBundle] pathForResource:@"testLevel1" ofType:@"yaspeg"];
   NSData *plistData = [NSData dataWithContentsOfFile:path];
   NSString *error;
   NSPropertyListFormat format;
   id plist;
   
   plist = [NSPropertyListSerialization propertyListFromData:plistData
                                            mutabilityOption:NSPropertyListImmutable
                                                      format:&format
                                            errorDescription:&error];
   if(!plist)
   {
      NSLog(@"%@", error);
      [error release];
   }
   
   NSLog(@"%@", plist);
}

@end
