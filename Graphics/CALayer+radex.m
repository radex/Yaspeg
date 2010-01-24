//
//  CALayer+radex.m
//  Yaspeg
//
//  Created by Radex on 10-01-23.
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

#import "CALayer+radex.h"
#import "YaspegController.h"

@implementation CALayer (radex)

- (bool)isInBounds:(NSPoint)point
{
   NSRect frame = NSRectFromCGRect([self convertRect:self.bounds toLayer:[YaspegController sharedYaspegController].rootLayer]);
   
   if(point.x > frame.origin.x &&
      point.x < frame.origin.x + frame.size.width &&
      point.y > frame.origin.y &&
      point.y < frame.origin.y + frame.size.height)
   {
      return YES;
   }
   
   return NO;
}
@end
