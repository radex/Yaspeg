//
//  «FILENAME»
//  «PROJECTNAME»
//
//  Created by «FULLUSERNAME» on «DATE».
//  Copyright «YEAR» «ORGANIZATIONNAME». All rights reserved.
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

#import "«FILEBASENAMEASIDENTIFIER».h"

@implementation «FILEBASENAMEASIDENTIFIER»

/*
 * stateInit
 *
 *
 */

- (void) stateInit
{
   
}

/*
 * events
 *
 *
 */

- (void) events
{
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
   
   
   
   [CATransaction commit];
   
   [super scheduleCleanUp: animationDuration];
   
   return animationDuration;
}

@end
