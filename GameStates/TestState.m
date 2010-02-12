//
//  TestState.m
//  Yaspeg
//
//  Created by Radex on 10-02-11.
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

#import "TestState.h"

@implementation TestState

/*
 * stateInit
 *
 *
 */

- (void) stateInit
{
   [Background genericBackground];
   [BackButton button];
   
   btn = [Button buttonWithLabel:@"Boom!" position:NSMakePoint(100, 100) width:150];
   
   //[self testing];
}

/*
 * events
 *
 *
 */

- (void) events
{
   if([ModalAlert isAlert])
   {
      [alert handleEvents];
      
      eventType = None_ET;
      return;
   }
   
   if([btn handleEvents] == 1)
   {
      alert = [ModalAlert alertWithHeader:@"hejder" description:@"deskrypcja"];
   }
   
   [super handleEvents];
   
   if(eventType == None_ET)
   {
      
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
      
      [super handleRender];
      
      [CATransaction commit];
      
      inited = YES;
   }
   
   
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
   
   [super handleOutro];
   
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
