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
   
   id testResult = [self testing];
   
   if([testResult isKindOfClass:[NSString class]])
   {
      [ModalAlert displayAlertWithHeader:@"Błąd" description:testResult];
      return;
   }
   
   NSDictionary *yaspegLevel = testResult;
   
   // checking version
   
   int minVersion = 1;
   int maxVersion = 1;
   
   NSNumber *docVersion_o = [yaspegLevel objectForKey:@"doc_version"];
   int docVersion = [docVersion_o intValue];
   
   if(docVersion < minVersion || docVersion > maxVersion)
   {
      [ModalAlert displayAlertWithHeader:@"Błąd" description:@"Nieobsługiwana wersja poziomu"];
      return;
   }
   
   // making board object
   
   board = [[GameBoard alloc] initWithWidth:[[yaspegLevel objectForKey:@"width"] intValue]
                                     height:[[yaspegLevel objectForKey:@"height"] intValue]];
   
}

/*
 * events
 *
 *
 */

- (void) events
{
   if([ModalAlert handleEvents]) return;
   
   if([btn handleEvents] == 1)
   {
      [ModalAlert displayAlertWithHeader:@"hejder" description:@"deskrypcja"];
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
      
      [super handleIntro];
      
      [CATransaction commit];
      
      inited = YES;
   }
   
   
}

/*
 * outro
 *
 *
 */

- (void) outro
{
}

/*
 * XML testing
 *
 *
 */

-(id) testing
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
      return error;
   }
   
   return plist;
}

@end
